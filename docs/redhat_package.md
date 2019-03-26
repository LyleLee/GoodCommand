redhat 安装软件
======================
一般redhat安装有3个源需要我们考虑。一是官方源，也就是将服务器注册到redhat官方，由官方源提供更新，这里不作介绍。二是使用ISO本地安装，安装redhat时使用的ISO包含了大量常用软件，这个时候挂载到本地系统，也可以实现安装。另外可以考虑epel源，也就是额外的rpm包软件源。


### 一、ISO本地软件源
从me@192.168.1.201复制到本机
```shell-session
[root@readhat76 ~]# scp me@192.168.1.201:~/RHEL-ALT-7.6-20181011.n.0-Server-aarch64-dvd1.iso ./
```
### 挂载镜像
```shell-session
[root@readhat76 ~]# mkdir /mnt/cd_redhat7.6
[root@readhat76 ~]# mount -o loop RHEL-ALT-7.6-20181011.n.0-Server-aarch64-dvd1.iso /mnt/cd_redhat7.6
[root@readhat76 ~]# lsblk
loop0                     7:0    0    3G  0 loop /mnt/cd_redhat7.6
```
### 添加本地源

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

### 确认添加成功
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

### 安装软件
这个时候就可以使用命令安装软件了：
```shell-session
yum install gcc
```
## 二、添加epel软件源。

随便一个镜像站，打开网址。找到epel-release-latest-7.noarch.rpm文件下载安装到本地就可以了。如果你的是RHEL6，那么请下载epel-release-latest-6.noarch.rpm以华为镜像站为例：  
浏览器打开[https://mirrors.huaweicloud.com](https://mirrors.huaweicloud.com) 找到epel。  
浏览器打开[https://mirrors.huaweicloud.com/epel/](https://mirrors.huaweicloud.com/epel/) 找到epel-release-latest-7
```
rpm -ivh epel-release-latest-7.noarch.rpm
```
这个时候会在`/etc/yum.repo.d/`下面多了一个epel.repo的文件。
```
yum clean all
yum update
yum install htop
```
这样就可以安装htop了

如果之前已经安装过了epel软件包，其实可以直接替换epel.repo中的url
```
sudo sed -i "s/#baseurl/baseurl/g" /etc/yum.repos.d/epel.repo
sudo sed -i "s/mirrorlist/#mirrorlist/g" /etc/yum.repos.d/epel.repo
sudo sed -i "s@http://download.fedoraproject.org/pub@https://mirrors.huaweicloud.com@g" /etc/yum.repos.d/epel.repo
```

[[epel 官方文档]](https://fedoraproject.org/wiki/EPEL/zh-cn)

## 三、常用命令
```shell
yum install iperf3
yum -y install firefox
yum remove firefox
yum -y remove firefox
yum update mysql

yum list openssh
yum list openssh-4.3p2
yum list installed | less #查询已安装软件包
yum search snappy
yum info snappy

yum update

yum repolist        #查询已经启用的软件源
yum repolist all    #查询所有软件源

yum --enbalerepo=epel install phpmyadmin
yum clean all       #清除缓存
yum history         #查看安装历史
```

