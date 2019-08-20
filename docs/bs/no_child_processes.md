执行程序出现  No child processes
=============
原因是，再CentOS上，默认的用户空间最大线程数量是4096，当启动超过最大线程之后，会报错。 每种软件报的错可能不一样。

```
make: vfork: Resource temporarily unavailable
AS      libavfilter/aarch64/vf_nlmeans_neon.o
/bin/sh: fork: retry: No child processes
/bin/sh: fork: retry: No child processes
make: vfork: Resource temporarily unavailable
CC      libavfilter/aeval.o
/bin/sh: fork: retry: No child processes
AR      libavdevice/libavdevice.a
```

解决办法：

```
[me@centos ffmpeg]$ ulimit -a

max user processes              (-u) 4096

```
使用ulimit -u 设置最大进程数量
```
max user processes              (-u) 65535
```
修改后不再报错。

注意ulimit -u仅对当前窗口有效，需要永久改变的，需要写到文件当中
```
[me@centos ffmpeg]$ cat /etc/security/limits.d/20-nproc.conf
# Default limit for number of user's processes to prevent
# accidental fork bombs.
# See rhbz #432903 for reasoning.

*          soft    nproc     65535
root       soft    nproc     unlimited
[me@centos ffmpeg]$
```
