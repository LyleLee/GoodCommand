# 为redhat 添加本地源

## 复制IOS镜像到本机
从me@192.168.1.201复制到本机
```shell-session
[root@readhat76 ~]# scp me@192.168.1.201:~/RHEL-ALT-7.6-20181011.n.0-Server-aarch64-dvd1.iso ./
```
## 挂载镜像
```shell-session
[root@readhat76 ~]# mkdir /mnt/cd_redhat7.6
[root@readhat76 ~]# mount -o loop RHEL-ALT-7.6-20181011.n.0-Server-aarch64-dvd1.iso /mnt/cd_redhat7.6
[root@readhat76 ~]# lsblk
loop0                     7:0    0    3G  0 loop /mnt/cd_redhat7.6
```
## 添加本地源

redhat7.6及以下软件源配置文件如下：
```shell-session
[root@readhat76 ~]# cat /etc/yum.repos.d/local_iso.repo
[localiso]
name=redhatapp
baseurl=file:///mnt/cd_redhat7.6/
enable=1
gpgcheck=0
```
`baseurl=file:///mnt/cd_redhat7.6/`刚才创建的挂载目录


redhat8.0及以上软件源配置文件如下：
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
`baseurl=file:///mnt/cd_redhat`是刚才创建的挂载目录

## 确认添加成功
```shell-session
yum repolist
```
可以看到添加好的源
```shell-session
[root@readhat76 ~]# yum repolist
Loaded plugins: langpacks, product-id, search-disabled-repos, subscription-manager
This system is not registered with an entitlement server. You can use subscription-manager to register.
repo id                                            repo name                                            status
localiso                                           redhatapp                                            3,713
repolist: 3,713
```

## 安装软件
这个时候就可以使用命令安装软件了：
```shell-session
yum install gcc
```