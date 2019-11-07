Mellanox ib 100G驱动
==========================
在HPC场景会用到100G IB网络。 这里介绍编译安装Mellanox驱动


+ 服务器：Taishan X6000 X320
+ CPU：Kunpeng920
+ 网卡： Mellanox Technologies MT28908 Family [ConnectX-6]
+ OS： CentOS 7.6
+ 内核： 4.14.0-115.el7a.0.1.aarch64
+ 安装包：[MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64.tgz](https://support.hpe.com/hpsc/swd/public/detail?swItemId=MTX-76c74a14b51448cfa9edd4f9ca)

PCIe插有Mellanox的网卡
```
[root@taishan-arm-cpu02 ~]# lspci
04:00.0 Infiniband controller: Mellanox Technologies MT28908 Family [ConnectX-6]
```

解压缩 MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64.tgz
```
tar -zxf MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64.tgz
cd MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64
```
为当前内核生成安装包
```
[root@taishan-arm-cpu02 MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64]# ./mlnx_add_kernel_support.sh -m ./ --make-tgz
Note: This program will create MLNX_OFED_LINUX TGZ for rhel7.6alternate under /tmp directory.
Do you want to continue?[y/N]:
[root@taishan-arm-cpu02 MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64]# ./mlnx_add_kernel_support.sh -m ./ --make-tgz
Note: This program will create MLNX_OFED_LINUX TGZ for rhel7.6alternate under /tmp directory.
Do you want to continue?[y/N]:y
See log file /tmp/mlnx_iso.17701_logs/mlnx_ofed_iso.17701.log

Checking if all needed packages are installed...
Building MLNX_OFED_LINUX RPMS . Please wait...
Creating metadata-rpms for 4.14.0-115.el7a.0.1.aarch64 ...
WARNING: If you are going to configure this package as a repository, then please note
WARNING: that it contains unsigned rpms, therefore, you need to disable the gpgcheck
WARNING: by setting 'gpgcheck=0' in the repository conf file.
Created /tmp/MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext.tgz
[root@taishan-arm-cpu02 MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64]#
```
如果出现报错，大慨率是缺少安装依赖的软件包，根据提示安装即可。

把/tmp目录下生成的tgz复制过来,解压缩
```
[root@taishan-arm-cpu02 ~]# tar -zxf MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext.tgz
[root@taishan-arm-cpu02 ~]# cd MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext
[root@taishan-arm-cpu02 MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext]#
```

执行安装：

```
[root@taishan-arm-cpu02 MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext]# ./mlnxofedinstall
Detected rhel7u6alternate aarch64. Disabling installing 32bit rpms...
Logs dir: /tmp/MLNX_OFED_LINUX.47126.logs
General log file: /tmp/MLNX_OFED_LINUX.47126.logs/general.log
This program will install the MLNX_OFED_LINUX package on your machine.
Note that all other Mellanox, OEM, OFED, RDMA or Distribution IB packages will be removed.
Those packages are removed due to conflicts with MLNX_OFED_LINUX, do not reinstall them.

Do you want to continue?[y/N]:y

Uninstalling the previous version of MLNX_OFED_LINUX

rpm --nosignature -e --allmatches --nodeps mft mft.

Starting MLNX_OFED_LINUX-4.5-1.0.1.0 installation ...

Installing mlnx-ofa_kernel 4.5 RPM
Preparing...                          ########################################
Updating / installing...
mlnx-ofa_kernel-4.5-OFED.4.5.1.0.1.1.g########################################
Installing mlnx-ofa_kernel-modules 4.5 RPM
Preparing...                          ########################################
Updating / installing...
mlnx-ofa_kernel-modules-4.5-OFED.4.5.1########################################
Installing mlnx-ofa_kernel-devel 4.5 RPM
Preparing...                          ########################################
Updating / installing...
mlnx-ofa_kernel-devel-4.5-OFED.4.5.1.0########################################
Installing kernel-mft 4.11.0 RPM
Preparing...                          ########################################
Updating / installing...
kernel-mft-4.11.0-103.kver.4.14.0_115.########################################
Installing knem 1.1.3.90mlnx1 RPM
Preparing...                          ########################################
Updating / installing...
knem-1.1.3.90mlnx1-OFED.4.4.2.5.2.1.g9########################################
Installing knem-modules 1.1.3.90mlnx1 RPM
Preparing...                          ########################################
Updating / installing...
knem-modules-1.1.3.90mlnx1-OFED.4.4.2.########################################
Installing iser 4.5 RPM
Preparing...                          ########################################
Updating / installing...
iser-4.5-OFED.4.5.1.0.1.1.gb4fdfac.kve########################################
Installing srp 4.5 RPM
Preparing...                          ########################################
Updating / installing...
srp-4.5-OFED.4.5.1.0.1.1.gb4fdfac.kver########################################
Installing isert 4.5 RPM
Preparing...                          ########################################
Updating / installing...
isert-4.5-OFED.4.5.1.0.1.1.gb4fdfac.kv########################################
Installing mlnx-rdma-rxe 4.5 RPM
Preparing...                          ########################################
Updating / installing...
mlnx-rdma-rxe-4.5-OFED.4.5.1.0.1.1.gb4########################################
Installing mpi-selector RPM
Preparing...                          ########################################
Updating / installing...
mpi-selector-1.0.3-1.45101            ########################################
Installing user level RPMs:
Preparing...                          ########################################
ofed-scripts-4.5-OFED.4.5.1.0.1       ########################################
Preparing...                          ########################################
libibverbs-41mlnx1-OFED.4.5.0.1.0.4510########################################
Preparing...                          ########################################
libibverbs-devel-41mlnx1-OFED.4.5.0.1.########################################
Preparing...                          ########################################
libibverbs-devel-static-41mlnx1-OFED.4########################################
Preparing...                          ########################################
libibverbs-utils-41mlnx1-OFED.4.5.0.1.########################################
Preparing...                          ########################################
libmlx4-41mlnx1-OFED.4.5.0.0.3.45101  ########################################
Preparing...                          ########################################
libmlx4-devel-41mlnx1-OFED.4.5.0.0.3.4########################################
Preparing...                          ########################################
libmlx5-41mlnx1-OFED.4.5.0.3.8.45101  ########################################
Preparing...                          ########################################
libmlx5-devel-41mlnx1-OFED.4.5.0.3.8.4########################################
Preparing...                          ########################################
librxe-41mlnx1-OFED.4.4.2.4.6.45101   ########################################
Preparing...                          ########################################
librxe-devel-static-41mlnx1-OFED.4.4.2########################################
Preparing...                          ########################################
libibcm-41mlnx1-OFED.4.1.0.1.0.45101  ########################################
Preparing...                          ########################################
libibcm-devel-41mlnx1-OFED.4.1.0.1.0.4########################################
Preparing...                          ########################################
libibumad-43.1.1.MLNX20180612.87b4d9b-########################################
Preparing...                          ########################################
libibumad-devel-43.1.1.MLNX20180612.87########################################
Preparing...                          ########################################
libibumad-static-43.1.1.MLNX20180612.8########################################
Preparing...                          ########################################
libibmad-5.0.0.MLNX20181022.0361c15-0.########################################
Preparing...                          ########################################
libibmad-devel-5.0.0.MLNX20181022.0361########################################
Preparing...                          ########################################
libibmad-static-5.0.0.MLNX20181022.036########################################
Preparing...                          ########################################
ibsim-0.7mlnx1-0.11.g85c342b.45101    ########################################
Preparing...                          ########################################
ibacm-41mlnx1-OFED.4.3.3.0.0.45101    ########################################
Preparing...                          ########################################
librdmacm-41mlnx1-OFED.4.2.0.1.3.45101########################################
Preparing...                          ########################################
librdmacm-utils-41mlnx1-OFED.4.2.0.1.3########################################
Preparing...                          ########################################
librdmacm-devel-41mlnx1-OFED.4.2.0.1.3########################################
Preparing...                          ########################################
opensm-libs-5.3.0.MLNX20181108.33944a2########################################
Preparing...                          ########################################
opensm-5.3.0.MLNX20181108.33944a2-0.1.########################################
Preparing...                          ########################################
opensm-devel-5.3.0.MLNX20181108.33944a########################################
Preparing...                          ########################################
opensm-static-5.3.0.MLNX20181108.33944########################################
Preparing...                          ########################################
perftest-4.4-0.5.g1ceab48.45101       ########################################
Preparing...                          ########################################
mstflint-4.11.0-1.5.g264ffeb.45101    ########################################
Preparing...                          ########################################
mft-4.11.0-103                        ########################################
Preparing...                          ########################################
srptools-41mlnx1-5.45101              ########################################
Preparing...                          ########################################
ibutils2-2.1.1-0.100.MLNX20181114.g83a########################################
Preparing...                          ########################################
ibutils-1.5.7.1-0.12.gdcaeae2.45101   ########################################
Preparing...                          ########################################
cc_mgr-1.0-0.39.g32c9c85.45101        ########################################
Preparing...                          ########################################
dump_pr-1.0-0.35.g32c9c85.45101       ########################################
Preparing...                          ########################################
ar_mgr-1.0-0.40.g32c9c85.45101        ########################################
Preparing...                          ########################################
ibdump-5.0.0-1.45101                  ########################################
Preparing...                          ########################################
infiniband-diags-5.0.0.MLNX20181101.2a########################################
Preparing...                          ########################################
infiniband-diags-compat-5.0.0.MLNX2018########################################
Preparing...                          ########################################
qperf-0.4.9-9.45101                   ########################################
Preparing...                          ########################################
ucx-1.5.0-1.45101                     ########################################
Preparing...                          ########################################
ucx-devel-1.5.0-1.45101               ########################################
Preparing...                          ########################################
ucx-static-1.5.0-1.45101              ########################################
Preparing...                          ########################################
sharp-1.7.2.MLNX20181122.e5da787-1.451########################################
Preparing...                          ########################################
hcoll-4.2.2543-1.45101                ########################################
Preparing...                          ########################################
openmpi-4.0.0rc5-1.45101              ########################################
Preparing...                          ########################################
mlnx-ethtool-4.2-1.45101              ########################################
Preparing...                          ########################################
mlnx-iproute2-4.7.0-1.45101           ########################################
Preparing...                          ########################################
mlnxofed-docs-4.5-1.0.1.0             ########################################
Preparing...                          ########################################
mpitests_openmpi-3.2.20-e1a0676.45101 ########################################
Device (04:00.0):
        04:00.0 Infiniband controller: Mellanox Technologies MT28908 Family [ConnectX-6]
        Link Width: x8
        PCI Link Speed: 16GT/s


Installation finished successfully.


Preparing...                          ################################# [100%]
Updating / installing...
   1:mlnx-fw-updater-4.5-1.0.1.0      ################################# [100%]

Added 'RUN_FW_UPDATER_ONBOOT=no to /etc/infiniband/openib.conf

Attempting to perform Firmware update...
Querying Mellanox devices firmware ...

Device #1:
----------

  Device Type:      ConnectX6
  Part Number:      MCX653105A-EFA_Ax
  Description:      ConnectX-6 VPI adapter card; 100Gb/s (HDR100; EDR IB and 100GbE); single-port QSFP56; PCIe3.0/4.0 Socket Direct 2x8 in a row; ROHS R6
  PSID:             MT_0000000237
  PCI Device Name:  04:00.0
  Port1 MAC:        98039bcc40b8
  Port1 GUID:       98039b0300cc40b8
  Port2 MAC:        N/A
  Port2 GUID:
  Versions:         Current        Available
     FW             20.25.0262     20.24.1000
     PXE            3.5.0603       3.5.0603
     UEFI           14.18.0012     14.17.0013

  Status:           Up to date


Log File: /tmp/MLNX_OFED_LINUX.47126.logs/fw_update.log
To load the new driver, run:
/etc/init.d/openibd restart
[root@taishan-arm-cpu02 MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext]#

```

启动ib驱动, 这个时候就可以看到ib0网卡接口了。 安装成功。
```
[root@taishan-arm-cpu02 MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext]# /etc/init.d/openibd restart
Unloading HCA driver:                                      [  OK  ]
Loading HCA driver and Access Layer:                       [  OK  ]
[root@taishan-arm-cpu02 MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext]#
[root@taishan-arm-cpu02 MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext]# ip a

5: ib0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 4092 qdisc mq state DOWN group default qlen 256
    link/infiniband 20:00:18:1e:fe:80:00:00:00:00:00:00:98:03:9b:03:00:cc:40:ba brd 00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
    inet 192.168.11.11/24 brd 192.168.11.255 scope global noprefixroute ib0
       valid_lft forever preferred_lft forever
[root@taishan-arm-cpu02 MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext]#

```


