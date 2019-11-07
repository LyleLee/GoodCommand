ceph 分布式存储系统
===================

| ceph 是一个高性能的分布式系统。提供三种服务：对象存储（Object
  Storage）、块存储（BLOCK Storage）、文件系统（File System）
| 一个ceph集群至少需要一个Ceph Monitor，Ceph Manager 和Ceph
  OSD。如果需要使用Ceph文件系统（Ceph File
  System），则还需要一个元数据服务器（Ceph Metadata）

下面以安装ceph 12.2.11为例

x86 Debian 版本的ceph依赖的安装包

::

   libaio1
   libsnappy1
   libcurl3
   curl
   libgoogle-perftools4
   google-perftools
   libleveldb1

::

   ceph -s
   ceph -w
   ceph df

查看集群的pool，下面可以看出来有一个pool，ID是1， 名字是volumes

::

   [root@ceph-node00 ~]# ceph osd lspools
   1 volumes

::

   [root@ceph-node00 ~]# ceph osd pool ls detail
   pool 1 'volumes' replicated size 3 min_size 2 crush_rule 0 object_hash rjenkins pg_num 4096 pgp_num 4096 autoscale_mode warn last_change 1644 lfor 0/0/739 flags hashpspool,selfmanaged_snaps stripe_width 0 application rbd
           removed_snaps [1~5]

查看集群的虚拟磁盘

::

   [root@ceph-node00 ~]# rbd ls volumes
   test-000
   test-001
   test-002
   test-003
   test-004
   test-005
   test-006
   test-007
   test-008

查看虚拟磁盘

::

   [root@ceph-node00 ~]# rbd info volumes/test-319
   rbd image 'test-319':
           size 400 GiB in 102400 objects
           order 22 (4 MiB objects)
           snapshot_count: 0
           id: 7de74cf76e78
           block_name_prefix: rbd_data.7de74cf76e78
           format: 2
           features: layering, exclusive-lock, object-map, fast-diff, deep-flatten
           op_features:
           flags:
           create_timestamp: Fri Jul  5 23:30:08 2019
           access_timestamp: Sat Jul  6 15:11:10 2019
           modify_timestamp: Sat Jul  6 15:25:48 2019

手动部署
--------

ubuntu node1 mon

生成uuid。

::

   root@ubuntu:~# uuidgen
   8b9fb887-8b58-4391-b002-a7e5fa5947e2

ceph.conf

::

   fsid = 8b9fb887-8b58-4391-b002-a7e5fa5947e2
   #设置node1(ubuntu)为mon节点
   mon initial members = ubuntu
   #设置mon节点地址
   mon host = 192.168.1.10
   public network = 192.168.1.0/24
   auth cluster required = cephx
   auth service required = cephx
   auth client required = cephx
   osd journal size = 1024
   #设置副本数
   osd pool default size = 3
   #设置最小副本数
   osd pool default min size = 1
   osd pool default pg num = 64
   osd pool default pgp num = 64
   osd crush chooseleaf type = 1
   osd_mkfs_type = xfs
   max mds = 5
   mds max file size = 100000000000000
   mds cache size = 1000000
   #设置osd节点down后900s，把此osd节点逐出ceph集群，把之前映射到此节点的数据映射到其他节点。
   mon osd down out interval = 900

   [mon]
   #把时钟偏移设置成0.5s，默认是0.05s,由于ceph集群中存在异构PC，导致时钟偏移总是大于0.05s，为了方便同步直接把时钟偏移设置成0.5s
   mon clock drift allowed = .50

下载二进制包
------------

ubuntu

::

   wget -q http://download.ceph.com/debian-{release}/pool/main/c/ceph/ceph_{version}{distro}_{arch}.deb
   wget -q http://download.ceph.com/debian-luminouse/pool/main/c/ceph/ceph_13.2.0bionic_x86_64.deb

ceph preflight log

::

   wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -

如果添加成功，可以查看到添加好的key

::

   me@ubuntu:~$ apt-key list
   /etc/apt/trusted.gpg
   --------------------
   pub   rsa4096 2015-09-15 [SC]
         08B7 3419 AC32 B4E9 66C1  A330 E84A C2C0 460F 3994
   uid           [ unknown] Ceph.com (release key) <security@ceph.com>

::

   echo deb https://download.ceph.com/debian-luminouse/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list

redhat

rpm –import ‘https://download.ceph.com/keys/release.asc’

问题
----

逐一安装以下软件包

::

   libaio1
   libsnappy1
   libcurl3
   curl
   libgoogle-perftools4
   google-perftools
   libleveldb1

dpkg -i libaio1_0.3.110-5_arm64.deb dpkg -i
libsnappy1v5_1.1.7-1_arm64.deb dpkg -i curl_7.58.0-2ubuntu3.6_arm64.deb
dpkg -i libleveldb1v5_1.20-2_arm64.deb dpkg -i
librbd1_12.2.11-0ubuntu0.18.04.1_arm64.deb dpkg -i librados\*
librados-dev_12.2.11-0ubuntu0.18.04.1_arm64.deb

libcurl3 和libcurl4冲突

::

   root@ubuntu:# dpkg -i libcurl3_7.58.0-2ubuntu2_arm64.deb
   Selecting previously unselected package libcurl3:arm64.
   dpkg: regarding libcurl3_7.58.0-2ubuntu2_arm64.deb containing libcurl3:arm64:
    libcurl3 conflicts with libcurl4
     libcurl4:arm64 (version 7.58.0-2ubuntu3.6) is present and installed.

   dpkg: error processing archive libcurl3_7.58.0-2ubuntu2_arm64.deb (--install):
    conflicting packages - not installing libcurl3:arm64
   Errors were encountered while processing:
    libcurl3_7.58.0-2ubuntu2_arm64.deb

libgoogle-perftools4 会缺少依赖
===============================

::

   root@ubuntu:# dpkg -i libgoogle-perftools4_2.5-2.2ubuntu3_arm64.deb
   (Reading database ... 133811 files and directories currently installed.)
   Preparing to unpack libgoogle-perftools4_2.5-2.2ubuntu3_arm64.deb ...
   Unpacking libgoogle-perftools4 (2.5-2.2ubuntu3) over (2.5-2.2ubuntu3) ...
   dpkg: dependency problems prevent configuration of libgoogle-perftools4:
    libgoogle-perftools4 depends on libtcmalloc-minimal4 (= 2.5-2.2ubuntu3); however:
     Package libtcmalloc-minimal4 is not installed.

   dpkg: error processing package libgoogle-perftools4 (--install):
    dependency problems - leaving unconfigured
   Processing triggers for libc-bin (2.27-3ubuntu1) ...
   Errors were encountered while processing:
    libgoogle-perftools4
   root@ubuntu:/home/lxf/201/ceph_standalone/deb#

解决办法:下载并安装libtcmalloc-minimal4

使用dpkg -i 所有的deb包
~~~~~~~~~~~~~~~~~~~~~~~

Errors were encountered while processing:
libcurl3_7.58.0-2ubuntu2_arm64.deb ceph-common ceph-mgr ceph
libgoogle-perftools4 radosgw ceph-base ceph-mon google-perftools

dpkg -i libtcmalloc-minimal4_2.5-2.2ubuntu3_arm64.deb dpkg -i
libgoogle-perftools4_2.5-2.2ubuntu3_arm64.deb dpkg -i
python-prettytable_0.7.2-3_all.deb dpkg -i
libbabeltrace1_1.5.5-1_arm64.deb dpkg -i
ceph-common_12.2.11-0ubuntu0.18.04.1_arm64.deb dpkg -i
ceph-base_12.2.11-0ubuntu0.18.04.1_arm64.deb dpkg -i
ceph-mon_12.2.11-0ubuntu0.18.04.1_arm64.deb dpkg -i
ceph-mgr_12.2.11-0ubuntu0.18.04.1_arm64.deb
