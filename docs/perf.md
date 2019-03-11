perf 观察机器性能
====================

在内核源码当中散落有一些hook， 叫做Tracepoint的，当内核运行到Tracepoint时，会产生事件通知，这个时候Perf收集这些事件，生成报告，根据报告可以了解程序运行时的内核细节
```安装
apt-get install linux-tools-common linux-tools-generic linux-tools-`uname -r`
```
列出所有能触发perf采样点的事件  
    perf list  

查看程序运行时各种统计时间的大概情况  
    perf stat ./c  

查看针对指定事件的统计  
    perf stat -e syscalls:sys_enter_fchmod ./c

查看哪些可能出问题的程序在占用资源  
    perf top

查看具体是哪一个函数占用程序运行时间最多  
    perf record –e cpu-clock ./t1   
    perf report  

更具体的查看调用关系  
    perf record –e cpu-clock –g ./t1   
    perf -g report  

录制所有程序的调用栈:每秒采样99次，-a记录所有CPU的调用栈， 60秒，-g 采用graph call    
    perf record -F 99 -a -g -- sleep 60 

## 生成火焰图步骤

生成SVG三个步骤:
```
perf record -F 99 -a -g -- sleep 60
perf script > out.perf   
./FlameGraph/stackcollapse-perf.pl out.perf > out.folded  
./FlameGraph/flamegraph.pl out.folded > kernel.svg  
```
如果要去除cpu_idle
```
grep -v cpu_idle out.folded | ./flamegraph.pl > nonidle.svg
```    

## 资料
design.txt 描述有perf的实现
https://elixir.bootlin.com/linux/latest/source/tools/perf/design.txt
http://taozj.net/201703/linux-perf-intro.html
```
perf record -e block:block_rq_issue -ag
ctrl+c
perf report
```
```
block:block_rq_issue    块设备IO请求发出时触发的事件
-a                      追踪所有CPU
-g                      捕获调用图（stack traces）
```
快捷键停止程序后，捕获的数据会保存在perf.data中，使用perf report可以打印出保存的数据。 perf report 可以打印堆栈， 公共路径，以及每个路径的百分比。
```
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
```


## perf list
```
       perf list [--no-desc] [--long-desc]
                   [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|event_glob]
```

```
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
```

## 常用时间
```
cpu-cycles          ：统计cpu周期数，cpu周期：指一条指令的操作时间。
instructions        ： 机器指令数目
cache-references    ： cache命中次数
cache-misses        ： cache失效次数
branch-instructions ： 分支预测成功次数
branch-misses       ： 分支预测失败次数
alignment-faults    ： 统计内存对齐错误发生的次数，当访问的非对齐的内存地址时，内核会进行处理，已保存不会发生问题，但会降低性能
context-switches    ： 上下文切换次数，
cpu-clock           ： cpu clock的统计，每个cpu都有一个高精度定时器
task-clock          ：cpu clock中有task运行的统计
cpu-migrations      ：进程运行过程中从一个cpu迁移到另一cpu的次数
page-faults         ： 页错误的统计
major-faults        ：页错误，内存页已经被swap到硬盘上，需要I/O换回
minor-faults        ：页错误，内存页在物理内存中，只是没有和逻辑页进行映射
```

