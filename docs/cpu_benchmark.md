评估CPU性能
==========

## 步骤

```shell
#执行编译
cd tools/src/
/buildtools
#安装，可选，不安装也可以执行，需要引用bin目录的路径
./install.sh

#设置环境
su root
. ./shrc
#执行
./runspec -c ../config/lemon-2cpu.cfg 450 --rate 1 -noreportable 
./runspec -c ../config/lemon-2cpu.cfg 450 --rate 1 -noreportable 
./runspec -c ../config/lemon-2cpu.cfg 400 --rate 1 -noreportable
./runspec -c ../config/lemon-2cpu.cfg all 
```

## 执行成功的log
命令在根目录下执行
```shell
./bin/runspec -c d05-2cpu.cfg all --rate 64
```
```log
Success: 3x400.perlbench 3x401.bzip2 3x403.gcc 3x410.bwaves 3x416.gamess 3x429.mcf 3x433.milc 3x434.zeusmp 3x435.gromacs 3x436.cactusADM 3x437.leslie3d 3x444.namd 3x445.g
obmk 3x447.dealII 3x450.soplex 3x453.povray 3x454.calculix 3x456.hmmer 3x458.sjeng 3x459.GemsFDTD 3x462.libquantum 3x464.h264ref 3x465.tonto 3x470.lbm 3x471.omnetpp 3x473
.astar 3x481.wrf 3x482.sphinx3 3x483.xalancbmk 3x998.specrand 3x999.specrand
Producing Raw Reports
mach: default
  ext: gcc43-64bit
    size: ref
      set: int
        format: raw -> /home/me/syncfile/cputool/speccpu2006/result/CINT2006.001.ref.rsf
Parsing flags for 400.perlbench base: done
Parsing flags for 401.bzip2 base: done
Parsing flags for 403.gcc base: done
Parsing flags for 429.mcf base: done
Parsing flags for 445.gobmk base: done
Parsing flags for 456.hmmer base: done
Parsing flags for 458.sjeng base: done
Parsing flags for 462.libquantum base: done
Parsing flags for 464.h264ref base: done
Parsing flags for 471.omnetpp base: done
Parsing flags for 473.astar base: done
Parsing flags for 483.xalancbmk base: done
Doing flag reduction: done
        format: flags -> /home/me/syncfile/cputool/speccpu2006/result/CINT2006.001.ref.flags.html
        format: ASCII -> /home/me/syncfile/cputool/speccpu2006/result/CINT2006.001.ref.txt
        format: CSV -> /home/me/syncfile/cputool/speccpu2006/result/CINT2006.001.ref.csv
        format: HTML -> /home/me/syncfile/cputool/speccpu2006/result/CINT2006.001.ref.html, /home/me/syncfile/cputool/speccpu2006/result/invalid.gif, /home/me/syncfile/c$
utool/speccpu2006/result/CINT2006.001.ref.gif
      set: fp
        format: raw -> /home/me/syncfile/cputool/speccpu2006/result/CFP2006.001.ref.rsf
Parsing flags for 410.bwaves base: done
Parsing flags for 416.gamess base: done
Parsing flags for 433.milc base: done
Parsing flags for 434.zeusmp base: done
Parsing flags for 435.gromacs base: done
Parsing flags for 436.cactusADM base: done
Parsing flags for 437.leslie3d base: done
Parsing flags for 444.namd base: done
Parsing flags for 447.dealII base: done
Parsing flags for 450.soplex base: done
Parsing flags for 453.povray base: done
Parsing flags for 454.calculix base: done
Parsing flags for 459.GemsFDTD base: done
Parsing flags for 465.tonto base: done
Parsing flags for 470.lbm base: done
Parsing flags for 481.wrf base: done
Parsing flags for 482.sphinx3 base: done
Doing flag reduction: done
        format: flags -> /home/me/syncfile/cputool/speccpu2006/result/CFP2006.001.ref.flags.html
        format: ASCII -> /home/me/syncfile/cputool/speccpu2006/result/CFP2006.001.ref.txt
        format: CSV -> /home/me/syncfile/cputool/speccpu2006/result/CFP2006.001.ref.csv
        format: HTML -> /home/me/syncfile/cputool/speccpu2006/result/CFP2006.001.ref.html, /home/me/syncfile/cputool/speccpu2006/result/CFP2006.001.ref.gif

The log for this run is in /home/me/syncfile/cputool/speccpu2006/result/CPU2006.001.log

runspec finished at Sat May 18 05:04:05 2019; 187651 total seconds elapsed

```

执行结果，请参考：
  
|case			|分数			|
|:--------------|:--------------|
|[[1616 int结果]](resources/1616_speccpu2006_full_run_result/CINT2006.001.ref.html)	|421	|
|[[1616 fp结果]](resources/1616_speccpu2006_full_run_result/CFP2006.001.ref.html)	|383	|
|[[1620 int结果]](resouces/1620_speccpu2006_full_run_result/CINT2006.002.ref.html)	|394	|
|[[1620 fp结果]](resources/1620_speccpu2006_full_run_result/CFP2006.002.ref.html)	|283	|

分数和软硬件强相关，请注意差别。  

所有的错误报告请查看[[spec cpu 2006编译报错]](resources/spec_cpu_compile_error.md)

一些编译错误

## 编译报错：__alloca问题
```
glob.c:(.text+0x520): undefined reference to `__alloca'
```

修改 ./cpu2006/tools/src/make-3.82/glob/glob.c
```c
#if !defined __alloca && !defined __GNU_LIBRARY__
//变为
#if !defined __alloca && defined __GNU_LIBRARY__
```
## 执行报错：Individual benchmark selection is not allowed for a reportable run
```
--noreport
```
## 执行install报错