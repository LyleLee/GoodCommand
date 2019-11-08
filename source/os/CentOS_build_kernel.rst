CentOS上编译安装内核
========================

获取内核源码
----------------

| iso版本内核源码包获取路径
  `[http://vault.centos.org/centos/7/os/Source/SPackages/] <http://vault.centos.org/centos/7/os/Source/SPackages/>`__
| 一般使用IOS安装包安装安装系统后，想要获取和当前系统默认内核相匹配的源码，使用这个链接

update版本内核源码包获取路径
`[http://vault.centos.org/centos/7/updates/Source/SPackages/] <http://vault.centos.org/centos/7/updates/Source/SPackages/>`__
针对每个内核版本，发行版会定期发布update版本，内核大版本会一样，小版本不同，期待获取更新的时候使用这个链接

使用wget命令下载安装包

::

   wget http://vault.centos.org/centos/7/os/Source/SPackages/kernel-alt-4.14.0-115.el7a.0.1.src.rpm

源码包安装解压
-------------------

::

   rpm -iv kernel-alt-4.14.0-115.el7a.0.1.src.rpm 

源码好会安装在~/rpmbuild目录下

源码打patch
-----------------

打patch主要是因为CentOS的源码其实和Redhat一致，Redhat的源码应用patch后就变成CentOS

打patch之前需要安装一些工具,主要是rpmbuild和git

::

   yum install -y rpm-build git

注意rpm-build的小横杠，rpmbuild是一个命令，但是安装包是rpm-build

首先打源码包里面的patch,可以在当前用户的任意路径执行

::

   rpmbuild -bp --nodeps ~/rpmbuild/SPECS/kernel-alt.spec

打自己想打的patch，譬如 0001.patch

::

   cd ~/rpmbuild/BUILD/kernel-alt-4.14.0-115.7.1.el7a/linux-4.14.0-115.7.1.el7a.aarch64
   git am 0001.patch

编译内核rpm包。
-----------------

这一步，编译内核，并且打包成rpm安装包，这样就可以把安装包拷贝到目标机器上执行安装了。

安装编译工具

::

   yum groupinstall –y “Development Tools”
   yum install -y ncurses-devel make gcc bc bison flex elfutils-libelf-devel openssl-devel rpm-build redhat-rpm-config -y

配合config.
主要是对内核编译选项进行设置。先把当前用来启动系统的config拷贝过来是最保险的。注意是.config

::

   cp /boot/config-4.14.0-115.el7a.0.1.aarch64 ./.config

修改.config中的CONFIG_SYSTEM_TRUSTED_KEYS=“certs/centos.pem”为空。

::

   CONFIG_SYSTEM_TRUSTED_KEYS=""

执行编译, 下载编译脚本：

::

   https://raw.githubusercontent.com/xin3liang/home-bin/master/build-kernel-natively.sh

或者从这里下载\ `build-kernel-natively <script/build-kernel-natively.sh>`__
在源码目录执行

::

   /home/build-kernel-natively.sh

安装内核rpm包
----------------

编译好的内核安装包在当前用户主目录下的rpmbuild/RPM下。

编译驱动
------------

由于重新编译了内核， 如果不是默认包含的驱动，
就需要重新进行编译。这个时候当前内核版本/usr/lib/modules/$(uname
-r)可能没有build目录，这个时候就需要创建一个符号链接指当前内核版本源码所在目录

::

   /usr/lib/modules/4.14.0-4k-2019-07-03/build -> /root/rpmbuild/BUILD/kernel-alt-4.14.0-115.el7a/linux-4.14.0-115.el7.0.1.aarch64
