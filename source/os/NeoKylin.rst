NeoKylin软件包管理，设置本地源
===============================

插入iso
-------

在BMC界面插入操作系统镜像，可以观察到多了一个设备sr0

.. code:: shell-session

   [root@kylin ~]# lsblk
   NAME                MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
   sda                   8:0    0  7.3T  0 disk
   ├─sda2                8:2    0    1G  0 part /boot
   ├─sda3                8:3    0  7.3T  0 part
   │ ├─nlas-swap       253:1    0    4G  0 lvm  [SWAP]
   │ ├─nlas-root       253:0    0   50G  0 lvm  /
   │ └─nlas-home       253:5    0  7.2T  0 lvm  /home
   └─sda1                8:1    0  200M  0 part /boot/efi
   nvme0n1             259:0    0  2.9T  0 disk
   ├─nvme0n1p1         259:1    0    1G  0 part
   └─nvme0n1p2         259:2    0  2.9T  0 part
     ├─nlas_kylin-root 253:4    0   50G  0 lvm
     ├─nlas_kylin-swap 253:2    0    4G  0 lvm
     └─nlas_kylin-home 253:3    0  2.9T  0 lvm
   [root@kylin ~]#
   [root@kylin ~]#
   [root@kylin ~]# lsblk
   NAME                MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
   sr0                  11:0    1  2.9G  0 rom
   sda                   8:0    0  7.3T  0 disk
   ├─sda2                8:2    0    1G  0 part /boot
   ├─sda3                8:3    0  7.3T  0 part
   │ ├─nlas-swap       253:1    0    4G  0 lvm  [SWAP]
   │ ├─nlas-root       253:0    0   50G  0 lvm  /
   │ └─nlas-home       253:5    0  7.2T  0 lvm  /home
   └─sda1                8:1    0  200M  0 part /boot/efi
   nvme0n1             259:0    0  2.9T  0 disk
   ├─nvme0n1p1         259:1    0    1G  0 part
   └─nvme0n1p2         259:2    0  2.9T  0 part
     ├─nlas_kylin-root 253:4    0   50G  0 lvm
     ├─nlas_kylin-swap 253:2    0    4G  0 lvm
     └─nlas_kylin-home 253:3    0  2.9T  0 lvm
   [root@kylin ~]# 

挂载iso
-------

.. code:: shell-session

   [root@kylin dev]# mkdir /mnt/cdrom
   [root@kylin dev]#
   [root@kylin dev]# mount /dev/sr0 /mnt/cdrom
   mount: /dev/sr0 写保护，将以只读方式挂载
   [root@kylin dev]#
   [root@kylin dev]# df
   文件系统                   1K-块    已用       可用 已用% 挂载点
   devtmpfs               133625152       0  133625152    0% /dev
   tmpfs                  133636288       0  133636288    0% /dev/shm
   tmpfs                  133636288   58560  133577728    1% /run
   tmpfs                  133636288       0  133636288    0% /sys/fs/cgroup
   /dev/mapper/nlas-root   52403200 1052084   51351116    3% /
   /dev/sda2                1038336  127132     911204   13% /boot
   /dev/sda1                 204580    7760     196820    4% /boot/efi
   /dev/mapper/nlas-home 7752529920 2665096 7749864824    1% /home
   tmpfs                   26727296       0   26727296    0% /run/user/0
   /dev/sr0                 3003034 3003034          0  100% /mnt/cdrom

添加本地源
----------

.. code:: shell-session

   [root@kylin yum.repos.d]# touch media.repo
   [root@kylin yum.repos.d]# ls
   media.repo  ns7-adv.repo
   [root@kylin yum.repos.d]# vim media.repo

文件\ ``/etc/yum.repos.d/media.repo``\ 的内容：

.. code::

   [local_media_from_iso]
   baseurl=file:///mnt/cdrom

修改好后可以查看到已经添加的源

.. code:: shell-session

   [root@kylin yum.repos.d]# yum repolist
   源标识                                                                   源名称                                                                                       状态
   local_media_from_iso                                                     local_media_from_iso                                                                         3,645
   ns7-adv-os/aarch64                                                       NeoKylin Linux Advanced Server 7 - Os                                                            0
   ns7-adv-updates/aarch64                                                  NeoKylin Linux Advanced Server 7 - Updates                                                       0
   repolist: 3,645
   [root@kylin yum.repos.d]#

尝试安装软件
------------

.. code:: shell-session

   [root@kylin cdrom]# yum install vim
   http://update.cs2c.com.cn:8080/NS/V7/V7Update5/os/adv/lic/base/aarch64/repodata/repomd.xml: [Errno 14] HTTP Error 404 - Not Found
   正在尝试其它镜像。
   To address this issue please refer to the below knowledge base article

   http://www.cs2c.com.cn

   If above article doesn't help to resolve this issue please contact with CS2C Support.



    One of the configured repositories failed (NeoKylin Linux Advanced Server 7 - Os),
    and yum doesn't have enough cached data to continue. At this point the only
    safe thing yum can do is fail. There are a few ways to work "fix" this:

        1. Contact the upstream for the repository and get them to fix the problem.

        2. Reconfigure the baseurl/etc. for the repository, to point to a working
           upstream. This is most often useful if you are using a newer
           distribution release than is supported by the repository (and the
           packages for the previous distribution release still work).

        3. Run the command with the repository temporarily disabled
               yum --disablerepo=ns7-adv-os ...

        4. Disable the repository permanently, so yum won't use it by default. Yum
           will then just ignore the repository until you permanently enable it
           again or use --enablerepo for temporary usage:

               yum-config-manager --disable ns7-adv-os
           or
               subscription-manager repos --disable=ns7-adv-os

        5. Configure the failing repository to be skipped, if it is unavailable.
           Note that yum will try to contact the repo. when it runs most commands,
           so will have to try and fail each time (and thus. yum will be be much
           slower). If it is a very temporary problem though, this is often a nice
           compromise:

               yum-config-manager --save --setopt=ns7-adv-os.skip_if_unavailable=true

   failure: repodata/repomd.xml from ns7-adv-os: [Errno 256] No more mirrors to try.
   http://update.cs2c.com.cn:8080/NS/V7/V7Update5/os/adv/lic/base/aarch64/repodata/repomd.xml: [Errno 14] HTTP Error 404 - Not Found
   [root@kylin cdrom]# 

其他源有问题，禁用掉。编辑\ ``/etc/yum.repos.d/ns7-adv.repo``\ 改成\ ``enbale=0``

.. code::

   [ns7-adv-os]
   name=NeoKylin Linux Advanced Server 7 - Os
   baseurl=http://update.cs2c.com.cn:8080/NS/V7/V7Update5/os/adv/lic/base/$basearch/
   gpgcheck=0
   gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-neokylin-release
   enabled=0

   [ns7-adv-updates]
   name=NeoKylin Linux Advanced Server 7 - Updates
   baseurl=http://update.cs2c.com.cn:8080/NS/V7/V7Update5/os/adv/lic/updates/$basearch/
   gpgcheck=0
   gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-neokylin-release
   enabled=0

   [ns7-adv-addons]
   name=NeoKylin Linux Advanced Server 7 - Addons
   baseurl=http://update.cs2c.com.cn:8080/NS/V7/V7Update5/os/adv/lic/addons/$basearch/
   gpgcheck=0
   gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-neokylin-release
   enabled=0

这时安装正常

.. code:: shell-session

   [root@kylin cdrom]# yum install vim
   local_media_from_iso                                                                                                                                | 3.7 kB  00:00:00
   local_media_from_iso/group_gz                                                                                                                       | 136 kB  00:00:00
   正在解决依赖关系
   --> 正在检查事务
   ---> 软件包 vim-enhanced.aarch64.2.7.4.160-4.el7 将被 安装
   --> 正在处理依赖关系 vim-common = 2:7.4.160-4.el7，它被软件包 2:vim-enhanced-7.4.160-4.el7.aarch64 需要
   --> 正在处理依赖关系 perl(:MODULE_COMPAT_5.16.3)，它被软件包 2:vim-enhanced-7.4.160-4.el7.aarch64 需要
   --> 正在处理依赖关系 libperl.so()(64bit)，它被软件包 2:vim-enhanced-7.4.160-4.el7.aarch64 需要
   --> 正在处理依赖关系 libgpm.so.2()(64bit)，它被软件包 2:vim-enhanced-7.4.160-4.el7.aarch64 需要
   --> 正在检查事务
