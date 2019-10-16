time
===============
time命令可以用来统计程序运行的时间

统计top命令的耗时
```shell
time top
ctrl c
```
```cs
real    0m6.396s    #top命令一共运行了6秒
user    0m0.010s    #包含所有子程序用户层cpu耗时
sys     0m0.086s    #包含所有子程序系统层cpu耗时
```