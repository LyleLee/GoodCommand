coremark
============================
测试CPU性能的benchmark
```shell
git clone https://github.com/eembc/coremark.git
cd coremark
make
```

```shell
[me@servername ~]$ git clone https://github.com/eembc/coremark.git
Cloning into 'coremark'...
remote: Enumerating objects: 189, done.
remote: Total 189 (delta 0), reused 0 (delta 0), pack-reused 189
Receiving objects: 100% (189/189), 426.12 KiB | 198.00 KiB/s, done.
Resolving deltas: 100% (117/117), done.
[me@servername ~]$
[me@servername ~]$ ls
coremark
[me@servername ~]$
[me@servername ~]$ cd coremark/
[me@servername coremark]$
[me@servername coremark]$ make
make XCFLAGS=" -DPERFORMANCE_RUN=1" load run1.log
make[1]: Entering directory `/home/me/coremark'
make port_prebuild
make[2]: Entering directory `/home/me/coremark'
make[2]: Nothing to be done for `port_prebuild'.
make[2]: Leaving directory `/home/me/coremark'
make link
make[2]: Entering directory `/home/me/coremark'
gcc -O2 -Ilinux64 -I. -DFLAGS_STR=\""-O2 -DPERFORMANCE_RUN=1  -lrt"\" -DITERATIONS=0 -DPERFORMANCE_RUN=1 core_list_join.c core_main.c core_matrix.c core_state.c core_util.c linux64/core_portme.c -o ./coremark.exe -lrt
Link performed along with compile
make[2]: Leaving directory `/home/me/coremark'
make port_postbuild
make[2]: Entering directory `/home/me/coremark'
make[2]: Nothing to be done for `port_postbuild'.
make[2]: Leaving directory `/home/me/coremark'
make port_preload
make[2]: Entering directory `/home/me/coremark'
make[2]: Nothing to be done for `port_preload'.
make[2]: Leaving directory `/home/me/coremark'
echo Loading done ./coremark.exe
Loading done ./coremark.exe
make port_postload
make[2]: Entering directory `/home/me/coremark'
make[2]: Nothing to be done for `port_postload'.
make[2]: Leaving directory `/home/me/coremark'
make port_prerun
make[2]: Entering directory `/home/me/coremark'
make[2]: Nothing to be done for `port_prerun'.
make[2]: Leaving directory `/home/me/coremark'
./coremark.exe  0x0 0x0 0x66 0 7 1 2000 > ./run1.log
make port_postrun
make[2]: Entering directory `/home/me/coremark'
make[2]: Nothing to be done for `port_postrun'.
make[2]: Leaving directory `/home/me/coremark'
make[1]: Leaving directory `/home/me/coremark'
make XCFLAGS=" -DVALIDATION_RUN=1" load run2.log
make[1]: Entering directory `/home/me/coremark'
make port_preload
make[2]: Entering directory `/home/me/coremark'
make[2]: Nothing to be done for `port_preload'.
make[2]: Leaving directory `/home/me/coremark'
echo Loading done ./coremark.exe
Loading done ./coremark.exe
make port_postload
make[2]: Entering directory `/home/me/coremark'
make[2]: Nothing to be done for `port_postload'.
make[2]: Leaving directory `/home/me/coremark'
make port_prerun
make[2]: Entering directory `/home/me/coremark'
make[2]: Nothing to be done for `port_prerun'.
make[2]: Leaving directory `/home/me/coremark'
./coremark.exe  0x3415 0x3415 0x66 0 7 1 2000  > ./run2.log
make port_postrun
make[2]: Entering directory `/home/me/coremark'
make[2]: Nothing to be done for `port_postrun'.
make[2]: Leaving directory `/home/me/coremark'
make[1]: Leaving directory `/home/me/coremark'
Check run1.log and run2.log for results.
See README.md for run and reporting rules.
[me@servername coremark]$
[me@servername coremark]$
[me@servername coremark]$ ls
barebones         core_main.c   coremark.h     core_state.c  cygwin  LICENSE.md  linux64   README.md  run2.log
core_list_join.c  coremark.exe  core_matrix.c  core_util.c   docs    linux       Makefile  run1.log   simple
[me@servername coremark]$
[me@servername coremark]$
[me@servername coremark]$ more run1.log
2K performance run parameters for coremark.
CoreMark Size    : 666
Total ticks      : 15836
Total time (secs): 15.836000
Iterations/Sec   : 12629.451882
Iterations       : 200000
Compiler version : GCC4.8.5 20150623 (Red Hat 4.8.5-36)
Compiler flags   : -O2 -DPERFORMANCE_RUN=1  -lrt
Memory location  : Please put data memory location here
                        (e.g. code in flash, data on heap etc)
seedcrc          : 0xe9f5
[0]crclist       : 0xe714
[0]crcmatrix     : 0x1fd7
[0]crcstate      : 0x8e3a
[0]crcfinal      : 0x4983
Correct operation validated. See README.md for run and reporting rules.
CoreMark 1.0 : 12629.451882 / GCC4.8.5 20150623 (Red Hat 4.8.5-36) -O2 -DPERFORMANCE_RUN=1  -lrt / Heap
[me@servername coremark]$
[me@servername coremark]$
[me@servername coremark]$ ls
barebones         core_main.c   coremark.h     core_state.c  cygwin  LICENSE.md  linux64   README.md  run2.log
core_list_join.c  coremark.exe  core_matrix.c  core_util.c   docs    linux       Makefile  run1.log   simple
[me@servername coremark]$
[me@servername coremark]$
[me@servername coremark]$ more run2.log
2K validation run parameters for coremark.
CoreMark Size    : 666
Total ticks      : 15847
Total time (secs): 15.847000
Iterations/Sec   : 12620.685303
Iterations       : 200000
Compiler version : GCC4.8.5 20150623 (Red Hat 4.8.5-36)
Compiler flags   : -O2 -DPERFORMANCE_RUN=1  -lrt
Memory location  : Please put data memory location here
                        (e.g. code in flash, data on heap etc)
seedcrc          : 0x18f2
[0]crclist       : 0xe3c1
[0]crcmatrix     : 0x0747
[0]crcstate      : 0x8d84
[0]crcfinal      : 0x5b5d
Correct operation validated. See README.md for run and reporting rules.
[me@servername coremark]$
```
