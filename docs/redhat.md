# 为redhat 添加本地源

## 复制IOS镜像到本机
这里复制到主目录下，已有的请忽略
```shell-session
#在其他机器执行
scp  RHEL-8.0-20181030.n.0-aarch64-dvd1.iso root@ip:~/
```
## 挂载镜像
```shell-session
cd ~
mkdir /mnt/cd_redhat
mount -o loop RHEL-8.0-20181030.n.0-aarch64-dvd1.iso /mnt/cd_redhat
```
## 添加本地源
```shell-session
vim /etc/yum.repos.d/local_iso.repo
##内容如下
[root@localhost yum.repos.d]# cat local_iso.repo 
[base]
name=baseos
baseurl=file:///mnt/cd_redhat/BaseOS
enable=1
gpgcheck=0

[app]
name=app
baseurl=file:///mnt/cd_redhat/AppStream
enable=1
gpgcheck=0
```
## 确认添加成功
```
yum repolist
```
可以看到添加好的源