******************************
CentOS软件包管理，设置软件源
******************************

设置CentOS软件源
=================

本地软件源
--------------

设置和redhat相同请参考：:doc:`redhat_package`

在线源
-------------------------

::

   wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.huaweicloud.com/repository/conf/CentOS-7-anon.repo


epel源
-------------------------------

方法1：

::

   yum install https://mirrors.huaweicloud.com/epel/epel-release-latest-7.noarch.rpm
   rpm --import https://mirrors.huaweicloud.com/epel/RPM-GPG-KEY-EPEL-7

方法2：

::

   yum install epel-release


CentOS8
-----------------------

CentOS-Base.repo 文件中，启用baseurl并且替换网址为https://mirrors.huaweicloud.com， Centos8 alt软件源合一了 ::

   [BaseOS]
   name=CentOS-$releasever - Base huawei
   #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=BaseOS&infra=$infra
   baseurl=https://mirrors.huaweicloud.com/$contentdir/$releasever/BaseOS/$basearch/os/
   gpgcheck=1
   enabled=1
   gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial


Key的问题
----------------------

一般一个repo有两个key。 repo key 和 package key

我们通过yum-config-manager添加repo， 通过 repm import引入key, 以kubernetes为例 ::

   yum-config-manager --add-repo
   curl -OL https://packages.cloud.google.com/yum/doc/yum-key.gpg



问题解决
----------------------

如果出现repodata/repomd.xml Error 404

::

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

解决办法修改CentOS-Base.repo,
baseurl中的baseurl=https://mirrors.huaweicloud.com/centos/
修改为baseurl=https://mirrors.huaweicloud.com/centos-altarch/7/updates/



.. code-block:: console

   [user1@kunpeng920 ~]$ sudo dnf config-manager
   No such command: config-manager. Please use /bin/dnf --help
   It could be a DNF plugin command, try: "dnf install 'dnf-command(config-manager)'"

解决办法：

.. code-block:: shell

   sudo dnf install -y dnf-plugins-core


CentOS 常见依赖包
------------------

.. code-block:: shell

   yum install bash-completion bash-completion-extras # 命令行补全

   yum install ncurses-devel zlib-devel texinfo gtk+-devel gtk2-devel
   qt-devel tcl-devel tk-devel libX11-devel kernel-headers kernel-devel
   yum install https://mirrors.huaweicloud.com/epel/epel-release-latest-7.noarch.rpm
   rpm –import https://mirrors.huaweicloud.com/epel/RPM-GPG-KEY-EPEL-7

CentOS 软件包常用命令
----------------------

::

   yum install iperf3
   yum -y install firefox
   yum remove firefox
   yum -y remove firefox
   yum update mysql
   yum list openssh
   yum list openssh-4.3p2
   yum list installed | less #查询已安装软件包
   yum list installed | grep kernel    #查看已安装内核
   yum search snappy
   yum info snappy
   yum update
   yum repolist        #查询已经启用的软件源
   yum repolist all    #查询所有软件源
   yum config-manager --disable ovirt-4.1   #禁用软件源
   dnf config-manager --disable ovirt-4.1   #禁用软件源
   yum grouplist
   yum groupinstall "Development Tools"

   yum provides htop   #查看拿个软件包提供命令
   yum provides /usr/include/mysql/mysql.h     #查看哪个软件包提供mysql.h
   yum --enbalerepo=epel install phpmyadmin #指定软件源安装软件包
   yum clean all       #清除缓存
   yum history         #查看安装历史
   yum list <package_name> --showduplicates    #显示所有版本软件
   yum install <package_name>-<version_info>   #安装指定版本软件包
   yum downgrade <package_name>-<version_info> #强制降级软件包
   sudo dnf config-manager --add-repo https://mirrors.huaweicloud.com/ceph/rpm-luminous/el7/aarch64/
   sudo yum config-manager --add-repo https://mirrors.huaweicloud.com/ceph/rpm-luminous/el7/aarch64/

   yumdownloader --urls nload  #获取nload的url下载地址

   rpm -ivh [package_name]     #安装软件包
   rpm -Uvh [package_name]     #升级软件包
   rpm -e   [package_name]     #卸载软件包
   rpm -qa                     #查询已安装软件包
   rpm -q   [package_name]     #查询软件包是否已经安装
   rpm -qi  [package_name]     #查看软件包信息
   rpm -aql [package_name]     #列出软件包安装的文件，也就是把哪些可执行文件复制到了系统目录
   rpm -qf  [绝对路径    ]     #列出可执行文件/命令是由哪个安装包安装的
   rpm -e kernel-debuginfo-4.14.0-115.el7a.aarch64 kernel-debuginfo-common-aarch64-4.14.0-115.el7a.aarch64 kernel-4.14.0-115.el7a.aarch64 kernel-devel-4.14.0-115.el7a.aarch64 #卸载内核
   ``

查找RPM包的网站
--------------------

https://www.rpmfind.net/
