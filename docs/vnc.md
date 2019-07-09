VNC
=====================

# 方案一： tigervnc

安装
```
yum install tigervnc
```
启动

```
vncserver	#默认会启动一个进程运行在5901端口，服务一个窗口.客户端使用IP：1 或者ip 5901登录
```
登录
```cs
vncviewer  192.168.100.12:1
# or
mobaxterm 192.168.100.12 5901
```

可以以指定方式启动VNC
```
vncserver :8	#启用一个进程运行在5908端口
```
关闭vnc进程
```
vncserver -kill :8
```
查看vnc
```
vncserver -list
```

设置VNC密码
```
vncpasswd
```
