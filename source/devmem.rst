devmem
======

使用devmem时，需要内核生成了/dev/mem设备，要生成这个设备需要配置内核编译选项

::

   CONFIG_STRICT_DEVMEM=y
   CONFIG_DEVKMEM=y
   CONFIG_DEVMEM=y

wget -O /etc/yum.repos.d/CentOS-Base.repo
https://mirrors.huaweicloud.com/repository/conf/CentOS-7-anon.repo

我使用的源码是： https://bootlin.com/pub/mirror/devmem2.c
