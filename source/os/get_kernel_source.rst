获取kernel代码
**********************

有时我们经常需要获取当前内核版本的代码，查看代码确认问题，或者重新编译内核

CentOS
======

凡事都可以到这里去下载 `http://vault.centos.org/centos <http://vault.centos.org/centos>`__

在/usr/src/kernels/可以看到安装好的内核源码

.. code:: shell

   yum install kernel-devel-$(uname -r)    #安装当前内核版本的代码，保证和当前内核版本一致kernel-devel-4.14.0-115.el7a.0.1.aarch64
   yum install kernel-devel                #安装当前版本内核的update版本kernel-devel-4.14.0-115.8.1.el7a.aarch64

| 或者到网址下载
| `[默认内核版本源码] <http://vault.centos.org/centos/7/os/Source/SPackages/>`__
  kernel-alt-4.14.0-115.el7a.0.1.src.rpm 2018-11-27 06:00 101M
| `[更新版本源码] <http://vault.centos.org/centos/7/updates/Source/SPackages/>`__
  kernel-alt-4.14.0-115.2.2.el7a.src.rpm 2018-11-29 15:26 101M
| `[更新版本源码] <http://vault.centos.org/centos/7/updates/Source/SPackages/>`__
  kernel-alt-4.14.0-115.5.1.el7a.src.rpm 2019-02-07 15:56 101M
| `[更新版本源码] <http://vault.centos.org/centos/7/updates/Source/SPackages/>`__
  kernel-alt-4.14.0-115.6.1.el7a.src.rpm 2019-03-18 16:01 101M
| `[更新版本源码] <http://vault.centos.org/centos/7/updates/Source/SPackages/>`__
  kernel-alt-4.14.0-115.7.1.el7a.src.rpm 2019-05-24 16:26 101M

RedHat
======

命令行方式和CentOS一样 网址需要订阅才有

Ubuntu
======

::

   apt-get source linux-image-$(uname -r)
   git clone git://kernel.ubuntu.com/ubuntu/ubuntu-<release codename>.git
