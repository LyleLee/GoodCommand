taskset
===================
CPU亲和力特性，可以让我们在某些核上运行程序。

```
taskset -c 1-16 -p 6298
```

#方法1：把CPU隔离出来
isolcpus=0-47

cd /sys/kernel/debug/tracing/
echo function > current_tracer
echo 1 > tracing_on

workload

cat tracer 

#方法2：使用脚本查出所有的PID，绑到指定核上。

观察到主要的后台服务是lsf_daemons.service
systemctl status lsf_daemons.service 获得Main PID
```
taskset -cp 48-95 9030
```
cd /sys/kernel/debug/tracing/
echo function > current_tracer
echo 1 > tracing_on

workload

cat tracer 




#方法2，
把PID是9030 绑到第0核和第4核上。
```
taskset -cp 0,4 9030
```


查看绑定结果
```
top -H -p `pgrep test`
isolcpus=1-2,7-8
```