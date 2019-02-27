## 获取源码
向redhat获取源码URL
```shell-session
wget URL
```
下载成功会出现kernel-alt-4.14.0-115.el7a.src.rpm

##  解压源码包
```shell-session
rpm2cpio kernel-alt-4.14.0-115.el7a.src.rpm | cpio -idmv
xz -d linux-4.14.0-115.el7a.tar.xz
tar -xf linux-4.14.0-115.el7a.tar
cd linux-4.14.0-115.el7a/
```

## 打上patch
假设patch文件放在 `~/patch/`
在源码目录下顺序执行以下命令
```shell-session
git apply ~/patch/0001-net-hns3-remove-hns3_fill_desc_tso.patch
git apply ~/patch/0002-net-hns3-move-DMA-map-into-hns3_fill_desc.patch
git apply ~/patch/0003-net-hns3-add-handling-for-big-TX-fragment.patch
git apply ~/patch/0004-net-hns3-rename-hns_nic_dma_unmap.patch
git apply ~/patch/0005-net-hns3-fix-for-multiple-unmapping-DMA-problem.patch
git apply ~/patch/0006-net-hns3-Fix-for-packet-buffer-setting-bug.patch
git apply ~/patch/0007-net-hns3-getting-tx-and-dv-buffer-size-through-firmw.patch
git apply ~/patch/0008-net-hns3-aligning-buffer-size-in-SSU-to-256-bytes.patch
git apply ~/patch/0009-net-hns3-fix-a-SSU-buffer-checking-bug.patch
git apply ~/patch/0010-net-hns3-add-8-BD-limit-for-tx-flow.patch
```

## 创建内核配置文件
如果是在ARM64服务器本机编辑，之需要在 `/boot/config-xxx` 复制过来即可.
```shell-session
cp /boot/config-4.14.0-115.el7a.aarch64 ./.config
```
把config中的CONFIG_SYSTEM_TRUSTED_KEYS变量枝为空串
```config
CONFIG_SYSTEM_TRUSTED_KEYS=""
```

## 获取编译脚本
```
wget https://raw.githubusercontent.com/xin3liang/home-bin/master/build-kernel-natively.sh
```
可以使用LOCALVERSION设置内核名字
```
export LOCALVERSION="-liuxl-test-`date +%F`"
```
## 安装编译依赖
```
yum install -y ncurses-devel make gcc bc bison flexelfutils-libelf-devel openssl-devel
```

## 执行脚本
```shell-session
chmod +x build-kernel-natively.sh
./build-kernel-natively.sh
```
在 `~/rpmbuild/RPMS/aarch64`下会生成以下文件
```shell-session
kernel-4.14.0_liuxl_test_2019_02_27-1.aarch64.rpm
kernel-headers-4.14.0_liuxl_test_2019_02_27-1.aarch64.rpm
```

## 安装内核
```shell-session
yum install kernel-4.14.0_liuxl_test_2019_02_27-1.aarch64.rpm
```
重启选择新内核启动