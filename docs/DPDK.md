下载地址
http://core.dpdk.org/download/

安装依赖
```
[root@arm-134 ~]# yum install make makecache gcc-c++ patch kernel-devel numactl
已加载插件：fastestmirror, langpacks
Loading mirror speeds from cached hostfile
软件包 1:make-3.82-23.el7.aarch64 已安装并且是最新版本
没有可用软件包 makecache。
软件包 gcc-c++-4.8.5-36.el7.aarch64 已安装并且是最新版本
软件包 patch-2.7.1-10.el7_5.aarch64 已安装并且是最新版本
软件包 kernel-devel-4.14.0-115.el7a.0.1.aarch64 已安装并且是最新版本
软件包 numactl-2.0.9-7.el7.aarch64 已安装并且是最新版本
无须任何处理
```

设置环境变量
```

export RTE_SDK=/home/lixianfa/dpdk/dpdk-stable-17.11.6/
export RTE_TARGET=arm64-armv8a-linuxapp-gcc
export KERNELDIR=/lib/modules/4.14.0-115.el7a.0.1.aarch64/build/
```




# 问题

缺少numa.h, 
```
/home/lixianfa/dpdk/dpdk-stable-17.11.6/lib/librte_eal/linuxapp/eal/eal_memory.c:56:18: fatal error: numa.h: No such file or directory
```
解决办法
```
sudo yum install numactl-devel
```