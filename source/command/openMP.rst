======================
openMP
======================

如果在代码中展开了太多的for循环

.. code:: diff

   diff --git a/deconvolution/clarkloop.cpp b/deconvolution/clarkloop.cpp
   index 96fb91f..e017150 100644
   --- a/deconvolution/clarkloop.cpp
   +++ b/deconvolution/clarkloop.cpp
   @@ -86,7 +86,7 @@ boost::optional<double> ClarkLoop::Run(ImageSet& convolvedResidual, const ao::uv
                           double* image = _clarkModel.Residual()[imgIndex];
                           const double* psf = doubleConvolvedPsfs[_clarkModel.Residual().PSFIndex(imgIndex)];
                           double psfFactor = componentValues[imgIndex];
   -                       #pragma omp parallel for
   +                       //#pragma omp parallel for
                           for(size_t px=0; px <_clarkModel.size(); ++px)
                           {
                                   int psfX = _clarkModel.X(px) - x + _width/2;

由于存在数据依赖，循环无法展开，cpu会被占满

::

   [user1@taishan-arm-cpu03 perf]$ htop

     1  [|||||||||||||  60.5%]    25 [|||||||||||||  58.6%]   49 [|||||||||||||| 60.3%]    73 [|||||||||||||  60.5%]
     2  [||||||||||||   56.6%]    26 [|||||||||||||  57.6%]   50 [|||||||||||||  61.7%]    74 [|||||||||||||  59.2%]
     3  [|||||||||||||| 64.8%]    27 [|||||||||||||  57.9%]   51 [|||||||||||||  59.9%]    75 [|||||||||||||  61.2%]
     4  [|||||||||||||  57.1%]    28 [|||||||||||||  59.2%]   52 [|||||||||||||| 61.7%]    76 [||||||||||||   58.9%]
     5  [|||||||||||||  56.2%]    29 [|||||||||||||  60.0%]   53 [|||||||||||||  60.3%]    77 [|||||||||||||  62.2%]
     6  [|||||||||||||  55.9%]    30 [|||||||||||||  58.7%]   54 [|||||||||||||  58.9%]    78 [|||||||||||||  61.0%]
     7  [|||||||||||||  57.9%]    31 [|||||||||||||| 60.8%]   55 [|||||||||||||  60.0%]    79 [|||||||||||||  60.3%]
     8  [|||||||||||||  56.8%]    32 [|||||||||||||  58.4%]   56 [||||||||||||   58.9%]    80 [||              2.0%]
     9  [|||||||||||||  59.7%]    33 [|||||||||||||  60.5%]   57 [|||||||||||||  61.2%]    81 [|||||||||||||  60.0%]
     10 [|||||||||||||  58.1%]    34 [|||||||||||||| 61.0%]   58 [|||||||||||||  60.0%]    82 [|||||||||||||  58.4%]
     11 [|||||||||||||  57.0%]    35 [|||||||||||||  59.7%]   59 [|||||||||||||  59.7%]    83 [|||||||||||||  60.5%]
     12 [|||||||||||||  56.2%]    36 [||||||||||||   58.6%]   60 [|||||||||||||  59.2%]    84 [|||||||||||||  60.8%]
     13 [|||||||||||||||69.8%]    37 [|||||||||||||  59.7%]   61 [||||||||||||   59.5%]    85 [|||||||||||||  58.7%]
     14 [||||||||||||   56.3%]    38 [|||||||||||||  59.9%]   62 [|||||||||||||| 60.3%]    86 [                0.0%]
     15 [||||||||||||   56.2%]    39 [|||||||||||||  59.7%]   63 [|||||||||||||  59.7%]    87 [|||||||||||||  60.0%]
     16 [|||||||||||||  56.2%]    40 [||||||||||||   58.2%]   64 [|||||||||||||  59.7%]    88 [|||||||||||||  59.5%]
     17 [|||||||||||||  56.2%]    41 [|||||||||||||  58.4%]   65 [|||||||||||||  59.2%]    89 [|||||||||||||  58.7%]
     18 [|||||||||||||  60.9%]    42 [|||||||||||||  59.6%]   66 [||||||||||||   57.7%]    90 [|||||||||||||  60.5%]
     19 [||||||||||||   56.5%]    43 [|||||||||||||  59.9%]   67 [|||||||||||||  60.0%]    91 [                0.0%]
     20 [||||||||||||   59.6%]    44 [|||||||||||||  57.2%]   68 [|||||||||||||  60.0%]    92 [|||||||||||||  58.9%]
     21 [||||||||||||   57.1%]    45 [|||||||||||||  59.4%]   69 [|||||||||||||  57.8%]    93 [|||||||||||||  59.5%]
     22 [||||||||||||   54.3%]    46 [|||||||||||||  60.1%]   70 [|||||||||||||  60.3%]    94 [||||||||||||   58.9%]
     23 [|||||||||||||  58.4%]    47 [|||||||||||||  60.5%]   71 [|||||||||||||  60.0%]    95 [|||||||||||||  58.1%]
     24 [||||||||||||   55.2%]    48 [|||||||||||||  59.6%]   72 [|||||||||||||  60.5%]    96 [|||||||||||||  58.3%]
     Mem[|||||                                 28.8G/1021G]   Tasks: 45, 319 thr; 57 running
     Swp[                                         0K/16.0G]   Load average: 37.59 39.73 30.82
                                                              Uptime: 5 days, 18:12:00

     PID CPU USER      PRI  NI  VIRT   RES   SHR S CPU% MEM%   TIME+  Command
   52123  13 sjtu_chif  20   0 16.4G 9551M 32064 R 5575  0.9 18h33:20 /home/user1/sourcecode/wsclean-2.7/build/wscle
   57611  63 sjtu_chif  20   0 16.4G 9551M 32064 S 59.7  0.9  9:26.69 /home/user1/sourcecode/wsclean-2.7/build/wscle
   57632  76 sjtu_chif  20   0 16.4G 9551M 32064 S 59.7  0.9  9:35.22 /home/user1/sourcecode/wsclean-2.7/build/wscle
   57643  70 sjtu_chif  20   0 16.4G 9551M 32064 R 59.7  0.9  9:34.92 /home/user1/sourcecode/wsclean-2.7/build/wscle
   57677  77 sjtu_chif  20   0 16.4G 9551M 32064 R 59.7  0.9  9:21.89 /home/user1/sourcecode/wsclean-2.7/build/wscle
   57678  92 sjtu_chif  20   0 16.4G 9551M 32064 R 60.3  0.9  9:33.56 /home/user1/sourcecode/wsclean-2.7/build/wscle
   57658  67 sjtu_chif  20   0 16.4G 9551M 32064 R 59.7  0.9  9:38.84 /home/user1/sourcecode/wsclean-2.7/build/wscle
   57651  90 sjtu_chif  20   0 16.4G 9551M 32064 S 59.0  0.9  9:22.89 /home/user1/sourcecode/wsclean-2.7/build/wscle
   57668  57 sjtu_chif  20   0 16.4G 9551M 32064 S 60.3  0.9  9:18.94 /home/user1/sourcecode/wsclean-2.7/build/wscle
   F1Help  F2Setup F3SearchF4FilterF5Tree  F6SortByF7Nice -F8Nice +F9Kill  F10Quit

在热点中也可以看到

::

   Samples: 2M of event 'cycles:ppp', 4000 Hz, Event count (approx.): 805718621249
   Overhead  Shared Object               Symbol
     44.99%  libgomp.so.1.0.0            [.] gomp_barrier_wait_end
     43.95%  libgomp.so.1.0.0            [.] gomp_team_barrier_wait_end
      5.59%  [kernel]                    [k] queued_spin_lock_slowpath
      0.80%  libgomp.so.1.0.0            [.] gomp_barrier_wait
      0.75%  libgomp.so.1.0.0            [.] gomp_team_barrier_wait_final
      0.65%  [kernel]                    [k] arch_cpu_idle
      0.54%  [kernel]                    [k] finish_task_switch

栈区的情况， thread1起了很多线程

::

   Thread 2 (Thread 0xfffcba85f050 (LWP 57701)):
   #0  0x0000ffff8632a6f0 in syscall () from /lib64/libc.so.6
   #1  0x0000ffff8643abe4 in futex_wait (val=6569840, addr=<optimized out>) at ../.././libgomp/config/linux/futex.h:45
   #2  do_wait (val=6569840, addr=<optimized out>) at ../.././libgomp/config/linux/wait.h:67
   #3  gomp_barrier_wait_end (bar=<optimized out>, state=6569840) at ../.././libgomp/config/linux/bar.c:48
   #4  0x0000ffff864382d8 in gomp_simple_barrier_wait (bar=<optimized out>) at ../.././libgomp/config/posix/simple-bar.h:60
   #5  gomp_thread_start (xdata=<optimized out>) at ../.././libgomp/team.c:127
   #6  0x0000ffff86677c48 in start_thread () from /lib64/libpthread.so.0
   #7  0x0000ffff8632f600 in thread_start () from /lib64/libc.so.6
   Thread 1 (Thread 0xffff85a19020 (LWP 52123)):
   #0  0x0000ffff8632a6f0 in syscall () from /lib64/libc.so.6
   #1  0x0000ffff8643ae74 in futex_wait (val=6569832, addr=<optimized out>) at ../.././libgomp/config/linux/futex.h:45
   #2  do_wait (val=6569832, addr=<optimized out>) at ../.././libgomp/config/linux/wait.h:67
   #3  gomp_team_barrier_wait_end (bar=<optimized out>, state=6569832) at ../.././libgomp/config/linux/bar.c:112
   #4  0x0000ffff8643afe4 in gomp_team_barrier_wait_final (bar=<optimized out>) at ../.././libgomp/config/linux/bar.c:136
   #5  0x0000ffff8643949c in gomp_team_end () at ../.././libgomp/team.c:934
   #6  0x00000000005bea8c in ClarkLoop::Run (this=this@entry=0xffffc9191190, convolvedResidual=..., doubleConvolvedPsfs=...) at /home/user1/sourcecode/wsclean-2.7/deconvolution/clarkloop.cpp:89
   #7  0x00000000004de618 in GenericClean::ExecuteMajorIteration (this=<optimized out>, dirtySet=..., modelSet=..., psfs=..., width=4000, height=4000, reachedMajorThreshold=@0xffffc9191ef0: true) at /home/user1/sourcecode/wsclean-2.7/deconvolution/genericclean.cpp:81
   #8  0x00000000004f8d54 in ParallelDeconvolution::ExecuteMajorIteration (this=this@entry=0xffffc91936e8, dataImage=..., modelImage=..., psfImages=..., reachedMajorThreshold=@0xffffc9191ef0: true) at /home/user1/sourcecode/wsclean-2.7/deconvolution/paralleldeconvolution.cpp:164
   #9  0x00000000004cdc4c in Deconvolution::Perform (this=this@entry=0xffffc91936e0, groupTable=..., reachedMajorThreshold=@0xffffc9191ef0: true, majorIterationNr=4) at /home/user1/sourcecode/wsclean-2.7/deconvolution/deconvolution.cpp:142
   #10 0x0000000000482408 in WSClean::runIndependentGroup (this=this@entry=0xffffc91927f0, groupTable=..., primaryBeam=...) at /home/user1/sourcecode/wsclean-2.7/wsclean/wsclean.cpp:727
   #11 0x000000000048afb0 in WSClean::RunClean (this=0xffffc91927f0) at /home/user1/sourcecode/wsclean-2.7/wsclean/wsclean.cpp:472
   #12 0x0000000000461ff8 in CommandLine::Run (wsclean=...) at /home/user1/sourcecode/wsclean-2.7/wsclean/commandline.cpp:1308
   #13 0x0000000000454aac in main (argc=32, argv=0xffffc9193a08) at /home/user1/sourcecode/wsclean-2.7/wscleanmain.cpp:13

完整的栈区情况请查看 `52123 <resource/52123.txt>`__
