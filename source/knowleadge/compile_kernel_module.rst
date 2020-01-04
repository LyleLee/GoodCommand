********************
编译内核模块
********************

想要编译网卡驱动，该怎么做，这里以Taishan 200(Kunpeng 920)的板载网卡驱动hns3, sas为例

获取内核源码
====================

.. code-block:: shell

    git clone --depth=1 https://github.com/torvalds/linux.git


``--depth=1`` 是为了更快复制，指包含所有文件的最近一个commit， 不包含全部的commits.


在源码目录树下编译
====================

在linux内核源码目录目录树下， 例如我的目录树在/home/user1/linux, cd进去执行

.. code-block:: shell

    make olddefconfig && make prepare                       #生成config
    make -C . M=drivers/net/ethernet/hisilicon/hns3 modules #生成ko
    make -C . M=drivers/net/ethernet/hisilicon/hns3 clean   #删除ko


..


``-C .`` 指明内核源码目录 ``M`` 指明模块路径

编译结果

.. code-block:: console

  Building modules, stage 2.
  MODPOST 4 modules
  CC [M]  drivers/net/ethernet/hisilicon/hns3/hnae3.mod.o
  LD [M]  drivers/net/ethernet/hisilicon/hns3/hnae3.ko
  CC [M]  drivers/net/ethernet/hisilicon/hns3/hns3.mod.o
  LD [M]  drivers/net/ethernet/hisilicon/hns3/hns3.ko
  CC [M]  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge.mod.o
  LD [M]  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge.ko
  CC [M]  drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf.mod.o
  LD [M]  drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf.ko


在源码目录树外编译
=====================

.. code-block:: shell

    make -C ../../linux/ M=$(pwd) modules
    make -C ../../linux/ M=$(pwd) clean


问题记录
================


问题：asm/errno.h: No such file or directory
-------------------------------------------------------------

.. code-block:: console

    [user1@centos linux]$ make -C . M=drivers/net/ethernet/hisilicon/hns3 modules
    make: Entering directory `/home/user1/linux'
      CC [M]  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.o
    In file included from ./include/linux/errno.h:5:0,
                     from ./include/linux/acpi.h:11,
                     from drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:4:
    ./include/uapi/linux/errno.h:1:23: fatal error: asm/errno.h: No such file or directory
     #include <asm/errno.h>
                           ^
    compilation terminated.
    make[3]: *** [drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.o] Error 1
    make[2]: *** [drivers/net/ethernet/hisilicon/hns3/hns3pf] Error 2
    make[1]: *** [drivers/net/ethernet/hisilicon/hns3] Error 2
    make: *** [sub-make] Error 2
    make: Leaving directory `/home/user1/linux'

解决办法

.. code-block:: shell

    make olddefconfig && make prepare

问题: ERROR: Kernel configuration is invalid
-------------------------------------------------------------=

.. code-block:: console

    [user1@centos linux]$ make -C . M=drivers/scsi/hisi_sas modules
    make: Entering directory '/home/user1/linux'

      ERROR: Kernel configuration is invalid.
             include/generated/autoconf.h or include/config/auto.conf are missing.
             Run 'make oldconfig && make prepare' on kernel src to fix it.

    Makefile:613: include/config/auto.conf: No such file or directory
    make: *** [Makefile:685: include/config/auto.conf] Error 1
    make: Leaving directory '/home/user1/linux'


解决办法

.. code-block:: shell

    make olddefconfig && make prepare

问题：scripts/genksyms/genksyms: No such file or directory
-------------------------------------------------------------

.. code-block:: console

    [user1@centos linux-4.18.0-80.7.2.el8_0]$ make -C . M=drivers/scsi/hisi_sas modules
    make: Entering directory '/home/user1/open_software/kernel-src-4.18/linux-4.18.0-80.7.2.el8_0'
      CC [M]  drivers/scsi/hisi_sas/hisi_sas_main.o
    /bin/sh: scripts/genksyms/genksyms: No such file or directory
    make[1]: *** [scripts/Makefile.build:322: drivers/scsi/hisi_sas/hisi_sas_main.o] Error 1
    make: *** [Makefile:1528: _module_drivers/scsi/hisi_sas] Error 2
    make: Leaving directory '/home/user1/open_software/kernel-src-4.18/linux-4.18.0-80.7.2.el8_0'

解决办法

.. code-block:: shell

    make olddefconfig && make prepare scripts
