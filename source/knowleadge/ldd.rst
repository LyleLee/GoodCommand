************************
LDD3 linux设备驱动
************************


主设备号，次设备号
==========================

主设备号一般用来标识设备的驱动。 次设备号内核用来区分实际设备。


printk 不支持浮点数

::

 The printk function used in hello.c earlier, for example, is the version of printf
 defined within the kernel and exported to modules. It behaves similarly to the original
 function, with a few minor differences, the main one being lack of floating-point suppor

内核中和驱动相关重要得数据结构

1. file_operations

.. c:type:: struct file_operations

file_operations是文件操作的抽象，注册了用户态对文件的读写，在内核是由哪些函数具体实现的。

.. literalinclude:: ../linux_root/include/linux/fs.h
    :language: c
    :lines: 1820-1827

这里仅节选了一部分，完整请查看文件 :download:`本站fs.h<../linux_root/include/linux/fs.h>`
:download:`github fs.h<https://raw.githubusercontent.com/torvalds/linux/master/include/linux/fs.h>`

用户态的read调用 [#user_read]_

.. code-block:: c

    #include <unistd.h>

    /** 尝试从文件fd读取count字节到buf
    */
    ssize_t read(int fd, void *buf, size_t count);

内核态的read  实现

.. code-block:: c

    /** @brief 文件的读函数
     *  @file 第一个参数，内核态代表打开的文件，不会在用户态出现，也是重要的数据结构的第三个。
     *  @_user 第二个参数，用户态中程序的地址或者是libc中的地址
     *  @size_t 第三个参数，用户态中的地址的大小
     *  @loff_t 第四个参数，内核态打开文件的文件的偏移量
     */
    ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);


2. inode

.. c:type:: struct inode

代表内核内的任意一个文件

.. literalinclude:: ../linux_root/include/linux/fs.h
    :language: c
    :lines: 628-633, 661-670, 714-721


4. file


.. c:type:: struct file

代表内核中每一个被打开的文件， 而inode节点代表每一个存在的文件， 很多打开的文件可以指向同一个inode

.. literalinclude:: ../linux_root/include/linux/fs.h
    :language: c
    :lines: 935-957


创建字符设备文件有两种方式
=================================

1. 使用 mknod，然后可以直接用rm删除

.. code-block:: shell

    mknod  filename type  major  minor

        filename :  设备文件名
        type        :  设备文件类型
        major      :   主设备号
        minor      :   次设备号

2. 在代码中手动创建

.. code-block:: shell

    struct class *cdev_class;
    cdev_class = class_create(owner,name)
    device_create(_cls,_parent,_devt,_device,_fmt)

    device_destroy(_cls,_device)
    class_destroy(struct class * cls)


引用空指针， 通常会导致oops。


使用/proc文件系统
===================

ldd 使用的函数是比较旧的，所以找了 linux kernel workbook的例子 [#workbook]_

1. 首先在驱动中实现接口

lld3中提到使用read_proc， 实际上在proc_fs.h中已经找不到read_proc，在proc_fs.h中
定义了proc_read [#read_proc]_

.. code-block:: c

    //已经弃用
    int (*read_proc)(char *page, char **start, off_t offset, int count, int *eof, void *data);

    //现使用
    ssize_t	(*proc_read)(struct file *, char __user *, size_t, loff_t *);

2. 仍然需要创建file_operations

.. code-block:: c

    struct file_operations proc_fops = {
        .read = my_proc_read,
        .write = my_proc_write,
    };


3. 创建/proc下的文件。

.. code-block:: c

    //已经弃用
    struct proc_dir_entry *create_proc_read_entry(const char *name,mode_t mode,
                                                struct proc_dir_entry *base,
                                                read_proc_t *read_proc,
                                                void *data);

    //现在使用接口
    extern struct proc_dir_entry *proc_create_data(const char *, umode_t,
                        struct proc_dir_entry *,
                        const struct proc_ops *,
                        void *);
    //删除文件
    remove_proc_entry("scullmem", NULL /* parent dir */);

4. 一个完整的例子 [#userproc]_

.. code-block:: c

    static int __init initialization_function(void){
        struct proc_dir_entry *ret = NULL;
        printk("%s: installing module\n", modname);
        ret = proc_create_data(modname, 0666, NULL, &proc_fops, NULL);
        if(!ret) printk("useproc error\n");
        return 0;
    }
    static void __exit deinitialization_function(void){
        remove_proc_entry(modname, NULL);
        printk("%s, removing..\n",modname);
    }

插入模块窗口

.. code-block:: console

    user1@ubuntu:~/fish_kernel_module/proc_module$ sudo insmod useproc.ko
    user1@ubuntu:~/fish_kernel_module/proc_module$
    user1@ubuntu:~/fish_kernel_module/proc_module$ sudo lsmod | grep useproc
    useproc               114688  0
    user1@ubuntu:~/fish_kernel_module/proc_module$ sudo dmesg | tail
    [18467.056449] useproc: installing module
    [18492.543355] msg has been save: kkkkkkkkkkkkkk
    [18494.560928] read argument: 00000000d6613f3c, 00000000df21919d, 256, 0
    [18494.560930] read data:kkkkkkkkkkkkkk

用户态程序测试窗口：

.. code-block:: console

    user1@ubuntu:~/fish_kernel_module/proc_module$ sudo ./test_proc_module.out
    [sudo] password for user1:
    Starting device test code example...
    Type in a short string to send to the kernel module:
    kkkkkkkkkkkkkkk
    Writing message to the device [kkkkkkkkkkkkkkk].
    Press ENTER to read back from the device...

    Reading from the device...
    The received message is: [kkkkkkkkkkkkkk]
    End of the program


.. [#user_read] http://man7.org/linux/man-pages/man2/read.2.html
.. [#workbook] https://lkw.readthedocs.io/en/latest/doc/05_proc_interface.html
.. [#read_proc] https://github.com/torvalds/linux/blob/master/include/linux/proc_fs.h
.. [#userproc] https://github.com/LyleLee/fish_kernel_module/tree/master/proc_module


信号量实现
=====================


信号量实现临界区互斥

.. code-block:: c
    :caption: include/linux/semaphore.h

    /* Please don't access any members of this structure directly */
    struct semaphore {
        raw_spinlock_t		lock;
        unsigned int		count;
        struct list_head	wait_list;
    };


.. code-block:: c
    :caption: include/linux/rwsem.h

    struct rw_semaphore {
        atomic_long_t count;
        atomic_long_t owner;
        struct optimistic_spin_queue osq; /* spinner MCS lock */
        raw_spinlock_t wait_lock;
        struct list_head wait_list;
    }

    extern void down_read(struct rw_semaphore *sem); //申请锁
    extern int down_read_trylock(struct rw_semaphore *sem);
    extern void up_read(struct rw_semaphore *sem);



complettion
========================

complettion提供等待条件成立的机制，例如一个进程wait_for_complete