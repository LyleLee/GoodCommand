linux内核设计与实现
=========================

在X86上，struct thread_info在文件<asm/thread_info.h>中定义.

```c
struct task_struct {
        volatile long state;    /* -1 unrunnable, 0 runnable, >0 stopped */
        void *stack;
        atomic_t usage;
        unsigned int flags;     /* per process flags, defined below */
        unsigned int ptrace;

        int lock_depth;         /* BKL lock depth */
		
		struct task_struct *real_parent; /* real parent process */
        struct task_struct *parent; /* recipient of SIGCHLD, wait4() reports */
        /*
         * children/sibling forms the list of my natural children
         */
        struct list_head children;      /* list of my children */
        struct list_head sibling;       /* linkage in my parent's children list */
        struct task_struct *group_leader;       /* threadgroup leader */
```

创建进程：
```c

fork()  vfork()  __clone()
   +      +          +
   |      |          |
   +-----------------+
       clone()
         +
         + do_fork()
               +
               copy_process()
                    +
                   dup_task_struct()
                       thread_info
                       task_struct

                   copy_flags()
                   alloc_pid()

```

进程终结：
主要由定义在kernel/exit.c中的do_exit()函数执行

```
exit()

do_exit()
    PF_EXITING
    acct_update_integrals(tsk);
    exit_mm()
    exit_sem()
    exit_sem(tsk);
	exit_files(tsk);
	exit_fs(tsk);
    exit_notify(tsk, group_dead);
    schedule();
```

进程的优先级：
linux采用了两种不同的优先级范围。一种是nice值。范围-20~+19，默认是0. nice值越小，优先级越高，也就是-20拥有最高优先级。
```
me@ubuntu:~/code/linux$ ps -el
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
4 S     0     1     0  0  80   0 - 40391 -      ?        00:01:09 systemd
1 S     0     2     0  0  80   0 -     0 -      ?        00:00:00 kthreadd
1 I     0     4     2  0  60 -20 -     0 -      ?        00:00:00 kworker/0:0H
1 I     0     7     2  0  60 -20 -     0 -      ?        00:00:00 mm_percpu_wq
1 S     0     8     2  0  80   0 -     0 -      ?        00:04:04 ksoftirqd/0
1 I     0     9     2  0  80   0 -     0 -      ?        00:07:36 rcu_sched
1 I     0    10     2  0  80   0 -     0 -      ?        00:00:00 rcu_bh
1 S     0    11     2  0 -40   - -     0 -      ?        00:00:00 migration/0
5 S     0    12     2  0 -40   - -     0 -      ?        00:00:07 watchdog/0
1 S     0    13     2  0  80   0 -     0 -      ?        00:00:00 cpuhp/0
1 S     0    14     2  0  80   0 -     0 -      ?        00:00:00 cpuhp/1
5 S     0    15     2  0 -40   - -     0 -      ?        00:00:04 watchdog/1
1 S     0    16     2  0 -40   - -     0 -      ?        00:00:00 migration/1
```
第二种是实时优先级。范围是0~99，其值可配。和nice值相反，值越大优先级越高。  
RTPRIO是-的，表示不是实时进程。
```
me@ubuntu:~/code/linux$ ps -eo state,uid,pid,ppid,rtprio,time,comm
S   UID   PID  PPID RTPRIO     TIME COMMAND
S     0     1     0      - 00:01:09 systemd
S     0     2     0      - 00:00:00 kthreadd
I     0     4     2      - 00:00:00 kworker/0:0H
I     0     7     2      - 00:00:00 mm_percpu_wq
S     0     8     2      - 00:04:04 ksoftirqd/0
I     0     9     2      - 00:07:38 rcu_sched
I     0    10     2      - 00:00:00 rcu_bh
S     0    11     2     99 00:00:00 migration/0
S     0    12     2     99 00:00:07 watchdog/0
S     0    13     2      - 00:00:00 cpuhp/0
S     0    14     2      - 00:00:00 cpuhp/1
S     0    15     2     99 00:00:04 watchdog/1
S     0    16     2     99 00:00:00 migration/1
S     0    17     2      - 00:02:14 ksoftirqd/1
I     0    19     2      - 00:00:00 kworker/1:0H
S     0    20     2      - 00:00:00 cpuhp/2
S     0    21     2     99 00:00:04 watchdog/2
S     0    22     2     99 00:00:00 migration/2
S     0    23     2      - 00:02:11 ksoftirqd/2
I     0    25     2      - 00:00:00 kworker/2:0H
```

# 时间片  
时间片是一个数值，它表示进程在被抢占前所能持续运行的时间。


基础的调度代码定义在 kernel/sched.c  
CFS算法定义在kernel/sched_fair.c  





# 时间,节拍，系统定时器
<arm/param.h> 定义了节拍率。

系统定时器频率（节拍率），通过静态预处理器定义的。HZ。  
x86体系结构中，系统定时器默认频率值是100，时钟中断频率是100HZ。每10ms产生一次（原书）
x86体系结构中，系统定时器默认频率值是1000，时钟中断频率是1000HZ。每1ms产生一次（根据下述代码）

include/asm-generic/param.h
```c
#ifdef __KERNEL__
# define HZ             CONFIG_HZ       /* Internal kernel timer frequency */
# define USER_HZ        100             /* some user interfaces are */
# define CLOCKS_PER_SEC (USER_HZ)       /* in "ticks" like times() */
#endif
```
```shell
me@ubuntu:~/code/linux$ grep -rn CONFIG_HZ . | grep x86
./arch/x86/configs/i386_defconfig:340:CONFIG_HZ=1000
./arch/x86/configs/x86_64_defconfig:341:CONFIG_HZ=1000
```
找了一些设备进行验证

|名称          | 架构 |OS         |内核版本                 |时钟中断频率  |用户接口时钟频率  |log                                |
|:-------------|:-----|:----------|:------------------------|:-------------|:-----------------|:-------------                     |
|RH2288 V3     |x86_64|RHEL7.6    |3.10.0-957.el7.x86_64    |1000HZ        |100HZ  10ms       |                                   |
|Taishan2280v2 |ARM   |RHEL7.6    |4.18.0-74.el8.aarch64    |100HZ         |100HZ  10ms       |[[log]](resources/x86_log.md#HZ)|
|Red Hat kvm   |x86_64|ubuntu     |4.15.0-20-generic        |250HZ         |100HZ  10ms       |[[log]](resources/vps_log.md#HZ)|

# 实际时间
当前时间（墙上时间）定义在文件kernel/time/timekeeping.c中：
```c
struct timespec xtime;
```
timespec数据结构定义在文件<linux/time.h>中：
```c
struct timespec{
    _kernel_time_t tv_sec;
    long tc_nsec;
}
```


# 竞争和锁
各种锁的机制区别在于：当锁已经被其他线程持有，因而不可用时的行为表现-----一些锁会简单地执行忙等待，而另外一些锁会使当前任务睡眠直到锁可用为止。
锁解决竞争条件地前提是，锁是原子操作实现的。
在X86体系结构总，锁的实现使用了成为compare和exchange的类似指令。

# 内核提供了两组原子操作接口

一组针对整数进行操作，另一组针对单独的位进行操作.  

整数原子操作数据类型定义在include/linux/types.h
```
typedef struct {
        volatile int counter;
} atomic_t;
```

整数原子操作定义在：
```
include/asm-generic/atomic.h
```
位原子操作定义在：
```
include/linux/bitops.h
asm/bitops.h
```

# 锁
自旋锁。申请锁的进程旋转等待，耗费处理器时间，持有自旋锁的时间应该小于进程两次上下文切换的时间。
信号量。申请信号量的进程会被睡眠，等待唤醒，不消耗处理器时间。
读写自旋锁。 多个线程可以同时获得读锁，读锁可以递归。写锁会保证没有人能在读或者写。

自旋锁定义在 asm/spinlock.h, 调用结构定义在linux/spinlock.h
