CentOS Pakages
===================
设置CentOS软件源

# 本地软件源设置和redhat相同
请参考：[[redhat 软件源设置]](redhat_package.md)

# 在线源

直接下载到本地即可
```
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.huaweicloud.com/repository/conf/CentOS-7-anon.repo
```
# 直接下载CentOS源配置文件到本地

前面的下载方式下载到的不是alt-aarch64这里提供一份下载[[CentOS7.6repo]](resources/CentOS7.6repo/CentOS-Base.repo)

# 配置epel源
方法1：参考[Redhat的配置](redhat_package.md)
方法2：CentOS的本地源或者在线源配置好之后，就可以直接安装epel源：
```
yum install epel-release
```

## 问题解决
如果出现repodata/repomd.xml Error 404
```
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * epel: fedora.cs.nctu.edu.tw
https://mirrors.huaweicloud.com/centos/7/os/aarch64/repodata/repomd.xml: [Errno 14] HTTPS Error 404 - Not Found
Trying other mirror.
To address this issue please refer to the below wiki article

https://wiki.centos.org/yum-errors

If above article doesn't help to resolve this issue please use https://bugs.centos.org/.

https://mirrors.huaweicloud.com/centos/7/extras/aarch64/repodata/repomd.xml: [Errno 14] HTTPS Error 404 - Not Found
Trying other mirror.
https://mirrors.huaweicloud.com/centos/7/updates/aarch64/repodata/repomd.xml: [Errno 14] HTTPS Error 404 - Not Found
```
解决办法修改CentOS-Base.repo, baseurl中的$releasever替换为7，centos替换为centos-altarch
```
baseurl=https://mirrors.huaweicloud.com/centos/$releasever/os/$basearch/
修改为：
baseurl=https://mirrors.huaweicloud.com/centos-altarch/7/updates/$basearch/
```

# CentOS 常见依赖包
```
yum install ncurses-devel zlib-devel texinfo gtk+-devel gtk2-devel qt-devel tcl-devel tk-devel libX11-devel kernel-headers kernel-devel
yum install https://mirrors.huaweicloud.com/epel/epel-release-latest-7.noarch.rpm
rpm --import https://mirrors.huaweicloud.com/epel/RPM-GPG-KEY-EPEL-7
```

# CentOS 常用命令
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
yum grouplist
yum groupinstall "Development Tools"

yum --enbalerepo=epel install phpmyadmin
yum clean all       #清除缓存
yum history         #查看安装历史
yum list <package_name> --showduplicates    #显示所有版本软件
yum install <package_name>-<version_info>   #安装指定版本软件包
yum downgrade <package_name>-<version_info> #强制降级软件包

yum list installed | grep kernel	#查看已安装内核

rpm -ivh [package_name]     #安装软件包
rpm -Uvh [package_name]     #升级软件包
rpm -e   [package_name]     #卸载软件包
rpm -qa                     #查询已安装软件包
rpm -q   [package_name]     #查询软件包是否已经安装
rpm -qi  [package_name]     #查看软件包信息
rpm -ql  [package_name]     #列出软件包安装的文件，也就是把哪些可执行文件复制到了系统目录
rpm -qf  [绝对路径    ]     #列出可执行文件/命令是由哪个安装包安装的

```
