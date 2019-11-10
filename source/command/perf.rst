*******************
perf 
*******************

在内核源码当中散落有一些hook，
叫做Tracepoint的，当内核运行到Tracepoint时，会产生事件通知，这个时候Perf收集这些事件，生成报告，根据报告可以了解程序运行时的内核细节

安装
----

ubuntu

::

   sudo apt install linux-tools-common
   sudo apt install linux-tools-4.15.0-46-generic

| 列出所有能触发perf采样点的事件
| perf list

| 查看程序运行时各种统计时间的大概情况
| perf stat ./c

| 查看针对指定事件的统计
| perf stat -e syscalls:sys_enter_fchmod ./c

| 查看哪些可能出问题的程序在占用资源
| perf top

| 查看具体是哪一个函数占用程序运行时间最多
| perf record –e cpu-clock ./t1
| perf report

| 更具体的查看调用关系
| perf record –e cpu-clock –g ./t1
| perf -g report

| 录制所有程序的调用栈:每秒采样99次，-a记录所有CPU的调用栈， 60秒，-g
  采用graph call
| perf record -F 99 -a -g – sleep 60

生成火焰图步骤
--------------

生成SVG三个步骤:

::

   sudo perf record -F 99 -a -g -p 66350 -o ClarkLoop_x86.data -- sleep 60

   perf script -i ClarkLoop_x86.data > ClarkLoop_x86.perf
   ../FlameGraph/stackcollapse-perf.pl ClarkLoop_x86.perf > ClarkLoop_x86.folded
   ../FlameGraph/flamegraph.pl ClarkLoop_x86.folded > ClarkLoop_x86.svg

复制粘贴执行

::

   flame_graph_path=../FlameGraph/

   perf_file="$(hostnamectl --static)-${perf_pid}-$(date +%Y-%m-%d-%H-%M-%S)"

   sudo perf record -F 99 -a -g -o "$perf_file".data -- sleep 60

   sudo perf script -i "$perf_file".data > "$perf_file".perf
   sudo ${flame_graph_path}/stackcollapse-perf.pl "$perf_file".perf > "$perf_file".folded
   sudo ${flame_graph_path}/flamegraph.pl "$perf_file".folded > "$perf_file".svg


   if [ -e "$perf_file".svg ]; then
       sudo rm "$perf_file".perf "$perf_file".folded
   fi

如果要去除cpu_idle

::

   grep -v cpu_idle out.folded | ./flamegraph.pl > nonidle.svg

常用命令
--------

::

   perf record -o result.perf
   perf stat -ddd   -a -- sleep 2

资料
----

design.txt 描述有perf的实现
https://elixir.bootlin.com/linux/latest/source/tools/perf/design.txt
http://taozj.net/201703/linux-perf-intro.html

::

   perf record -e block:block_rq_issue -ag
   ctrl+c
   perf report
   perf report -i file

::

   block:block_rq_issue    块设备IO请求发出时触发的事件
   -a                      追踪所有CPU
   -g                      捕获调用图（stack traces）

快捷键停止程序后，捕获的数据会保存在perf.data中，使用perf
report可以打印出保存的数据。 perf report 可以打印堆栈，
公共路径，以及每个路径的百分比。

::

   Samples: 81  of event 'block:block_rq_issue', Event count (approx.): 81
     Children      Self  Trace output                                                    
   -    2.47%     2.47%  8,0 FF 0 () 18446744073709551615 + 0 [jbd2/sda2-8]              
        ret_from_fork                                                                    
        kthread                                                                          
        kjournald2                                                                       
        jbd2_journal_commit_transaction                                                  
        journal_submit_commit_record                                                     
        submit_bh                                                                        
        submit_bh_wbc                                                                    
        submit_bio                                                                       
        generic_make_request                                                             
        blk_queue_bio                                                                    
        __blk_run_queue                                                                  
        scsi_request_fn                                                                  
        blk_peek_request                                                                 
        blk_peek_request                                                                 
   +    1.23%     1.23%  8,0 FF 0 () 18446744073709551615 + 0 [swapper/0]                
   +    1.23%     1.23%  8,0 FF 0 () 18446744073709551615 + 0 [swapper/37]               
   +    1.23%     1.23%  8,0 W 4096 () 1050624 + 8 [kworker/u129:1]                      
   +    1.23%     1.23%  8,0 W 4096 () 5327136 + 8 [kworker/u129:1]                      
   +    1.23%     1.23%  8,0 W 12288 () 1287264 + 24 [kworker/u129:1]                    
   +    1.23%     1.23%  8,0 W 12288 () 5334608 + 24 [kworker/u129:1]                    
   +    1.23%     1.23%  8,0 W 4096 () 1280136 + 8 [kworker/u129:1]                      
   +    1.23%     1.23%  8,0 W 4096 () 1282984 + 8 [kworker/u129:1]                      
   +    1.23%     1.23%  8,0 W 4096 () 1285440 + 8 [kworker/u129:1]                      
   +    1.23%     1.23%  8,0 W 4096 () 1287392 + 8 [kworker/u129:1]                      
   +    1.23%     1.23%  8,0 W 4096 () 1287448 + 8 [kworker/u129:1]                      
   +    1.23%     1.23%  8,0 W 4096 () 1287480 + 8 [kworker/u129:1]                      
   +    1.23%     1.23%  8,0 W 4096 () 1287912 + 8 [kworker/u129:1]                      
   +    1.23%     1.23%  8,0 W 4096 () 1291360 + 8 [kworker/u129:1]                      
   +    1.23%     1.23%  8,0 W 4096 () 1291456 + 8 [kworker/u129:1]                      
   +    1.23%     1.23%  8,0 W 4096 () 1291560 + 8 [swapper/0]                           
   +    1.23%     1.23%  8,0 W 4096 () 1291656 + 8 [swapper/0]                           
   +    1.23%     1.23%  8,0 W 4096 () 1291760 + 8 [swapper/0]                           
   +    1.23%     1.23%  8,0 W 4096 () 1292360 + 8 [swapper/0]                           
   +    1.23%     1.23%  8,0 W 4096 () 1292456 + 8 [swapper/0]                           
   +    1.23%     1.23%  8,0 W 4096 () 1292568 + 8 [swapper/0]                           
   +    1.23%     1.23%  8,0 W 4096 () 1294896 + 8 [swapper/0]                           
   +    1.23%     1.23%  8,0 W 4096 () 1295416 + 8 [swapper/0]                           
   +    1.23%     1.23%  8,0 W 4096 () 1295536 + 8 [swapper/0]                           
   +    1.23%     1.23%  8,0 W 4096 () 1295568 + 8 [swapper/0]                           
   +    1.23%     1.23%  8,0 W 4096 () 1295616 + 8 [swapper/0]                           
   +    1.23%     1.23%  8,0 W 4096 () 1295808 + 8 [swapper/0]                           
   +    1.23%     1.23%  8,0 W 4096 () 1295848 + 8 [swapper/0]                           
   +    1.23%     1.23%  8,0 W 4096 () 15747672 + 8 [swapper/0]                          
   +    1.23%     1.23%  8,0 WM 4096 () 1050640 + 8 [kworker/u129:1]                     

perf list
---------

::

          perf list [--no-desc] [--long-desc]
                      [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|event_glob]

::

     cache-misses                                       [Hardware event]
     cache-references                                   [Hardware event]
     ..........
     cpu-clock                                          [Software event]
     cpu-migrations OR migrations                       [Software event]
     ..........
     bpf-output                                         [Software event]
     context-switches OR cs                             [Software event]
     cpu-clock                                          [Software event]
     cpu-migrations OR migrations                       [Software event]
     ..........
     armv8_pmuv3_0/br_mis_pred/                         [Kernel PMU event]
     armv8_pmuv3_0/br_pred/                             [Kernel PMU event]
     ..........
     rNNN                                               [Raw hardware event descriptor]
     cpu/t1=v1[,t2=v2,t3 ...]/modifier                  [Raw hardware event descriptor]
     ..........
     block:block_bio_backmerge                          [Tracepoint event]
     block:block_bio_bounce                             [Tracepoint event]
     block:block_bio_complete                           [Tracepoint event]
     block:block_bio_frontmerge                         [Tracepoint event]
     block:block_bio_queue                              [Tracepoint event]
     block:block_bio_remap                              [Tracepoint event]
     dma_fence:dma_fence_emit                           [Tracepoint event]
     ext4:ext4_allocate_blocks                          [Tracepoint event]
     iommu:add_device_to_group                          [Tracepoint event]
     kvm:kvm_entry                                      [Tracepoint event]
     ...........
     syscalls:sys_enter_fchmod                          [Tracepoint event]
     syscalls:sys_enter_fchmodat                        [Tracepoint event]
     syscalls:sys_enter_fchown                          [Tracepoint event]
     syscalls:sys_enter_fchownat                        [Tracepoint event]
     syscalls:sys_enter_fcntl                           [Tracepoint event]

常用事件
--------

::

   cpu-cycles          ：统计cpu周期数，cpu周期：指一条指令的操作时间。
   instructions        ：机器指令数目
   cache-references    ：cache命中次数
   cache-misses        ：cache失效次数
   branch-instructions ：分支预测成功次数
   branch-misses       ：分支预测失败次数
   alignment-faults    ：统计内存对齐错误发生的次数，当访问的非对齐的内存地址时，内核会进行处理，已保存不会发生问题，但会降低性能
   context-switches    ：上下文切换次数，
   cpu-clock           ：cpu clock的统计，每个cpu都有一个高精度定时器
   task-clock          ：cpu clock中有task运行的统计
   cpu-migrations      ：进程运行过程中从一个cpu迁移到另一cpu的次数
   page-faults         ：页错误的统计
   major-faults        ：页错误，内存页已经被swap到硬盘上，需要I/O换回
   minor-faults        ：页错误，内存页在物理内存中，只是没有和逻辑页进行映射

##事件统计

::

   perf list | awk -F: '/Tracepoint event/ { lib[$1]++ } END {
       for (l in lib) { printf "  %-16.16s %d\n", l, lib[l] } }' | sort | column

perf record 出现错误
--------------------

::

   [root@localhost perf_data]# perf record -ag fio --ramp_time=5 --runtime=60 --size=10g --ioengine=libaio --filename=/dev/sda --name=4k_read --numjobs=1 --iodepth=128 --rw=randread --bs=4k --direct=1
   failed to mmap with 12 (Cannot allocate memory)

解决办法

::

   [root@localhost perf_data]# sysctl -w vm.max_map_count=1048576
   vm.max_map_count = 1048576
   [root@localhost perf_data]#

最优编译选项下对比x86和ARM的差别
--------------------------------

::

   gcc -mcmodel=medium -O -DSTREAM_ARRAY_SIZE=100000000 stream.c -o option_O_100M_stream

ARM不支持perf mem
-----------------

arm不支持

::

   root@ubuntu:~/app/stream# perf mem record ls
   failed: memory events not supported
   root@ubuntu:~/app/stream#
   root@ubuntu:~/app/stream# perf mem record -e list
   failed: memory events not supported
   root@ubuntu:~/app/stream#

x86支持

::

   [root@localhost stream]# perf mem record -e list
   ldlat-loads  : available
   ldlat-stores : available
   [root@localhost stream]#

perf 的cache-misses 是统计哪一层的
----------------------------------

perf 支持下面cache相关的事件：

::

   cache-misses            [Hardware event]        cache失效。指内存访问不由cache提供服务的事件。 
   cache-references        [Hardware event]        cache命中。 
   L1-dcache-load-misses   [Hardware cache event]  L1 数据取miss
   L1-dcache-loads         [Hardware cache event]  L1 数据取命中
   L1-dcache-store-misses  [Hardware cache event]  L1 数据存miss
   L1-dcache-stores        [Hardware cache event]  L1 数据存命中
   L1-icache-load-misses   [Hardware cache event]  L1 指令miss
   L1-icache-loads         [Hardware cache event]  L1 指令命中

cache-misses
`参考 <https://stackoverflow.com/questions/12601474/what-are-perf-cache-events-meaning/15283379>`__
内存访问不是由cache提供的记为cache-misses。含L1，L2，L3。

为什么perf统计的LDR指令比STR指令耗时更多
----------------------------------------

.. code:: asm

            :              for (j=0; j<STREAM_ARRAY_SIZE; j++)
       0.00 :        1054:       mov     x0, #0x0                        // #0
            :                  b[j] = scalar*c[j];
      19.14 :        1058:       ldr     d0, [x19, x0, lsl #3]
       0.00 :        105c:       fmul    d0, d0, d8
       0.10 :        1060:       str     d0, [x21, x0, lsl #3]

可能的原因：

1. 根据Cortex-A57的\ `文档 <http://infocenter.arm.com/help/topic/com.arm.doc.uan0015b/Cortex_A57_Software_Optimization_Guide_external.pdf>`__
   ,
   stream代码中的LDR需要至少4或2个指令周期。STR需要1个或2个指令周期来完成
   (ps:没有找到A72的文档)
2. STR可以写入cache，并不像LDR只能从内存读取，因为stream的数组大，cache是不命中的。

================================== ==================== ============
Instruction Group                  AArch64 Instructions Exec Latency
================================== ==================== ============
Load，scaled register post-indexed LDR,LDRSW,PRFM       4(2)
Store,scaled register post-indexed STR{T},STRB{T}       1(2)
================================== ==================== ============
