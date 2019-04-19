nfs not responding,8BD问题
=============
## 复现过程
8DB问题复现的条件是：
 
|  nfs服务端                                 | nfs客户端                               |现象       |
|:-------------------------------------------|:------------------------------------------   |:----------|
|cpu20-RHEL7.6 kernel-alt-4.14.0-115.el7a    | cpu16 ubuntu 18.04                           |出现       |
|cpu20-RHEL7.6 kernel-alt-4.14.0-115.7.1.el7a| cpu16 ubuntu 18.04                           |不出现     |
|cpu16-RHEL7.6 kernel-alt-4.14.0-115.el7a    | cpu20 RHEL7.6 kernel-alt-4.14.0-115.el7a     |出现       |
|cpu16-RHEL7.6 kernel-alt-4.14.0-115.el7a    | cpu20 RHEL7.6 kernel-alt-4.14.0-115.7.1.el7a |不出现     |



系统信息：
```
[root@readhat76 ~]#cat /etc/os-release
NAME="Red Hat Enterprise Linux Server"
VERSION="7.6 (Maipo)"
ID="rhel"
ID_LIKE="fedora"
VARIANT="Server"
VARIANT_ID="server"
VERSION_ID="7.6"
PRETTY_NAME="Red Hat Enterprise Linux Server 7.6 (Maipo)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:redhat:enterprise_linux:7.6:GA:server"
HOME_URL="https://www.redhat.com/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"

REDHAT_BUGZILLA_PRODUCT="Red Hat Enterprise Linux 7"
REDHAT_BUGZILLA_PRODUCT_VERSION=7.6
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux"
REDHAT_SUPPORT_PRODUCT_VERSION="7.6"
[root@readhat76 ~]#
```


## nfs 服务端设置
```shell-session
[root@readhat76 ~]#cat /etc/exports
/root/nfs-test-dir *(rw,sync,no_root_squash)
```

## nfs 客户端设置
```
[root@readhat76 ~]#mount -o vers=3 root@192.168.1.215:/root/nfs-test-dir /root/nfs-client-dir

[root@readhat76 ~]#df
Filesystem                       1K-blocks     Used  Available Use% Mounted on
devtmpfs                         267835008        0  267835008   0% /dev
tmpfs                            267845760        0  267845760   0% /dev/shm
tmpfs                            267845760    41728  267804032   1% /run
tmpfs                            267845760        0  267845760   0% /sys/fs/cgroup
/dev/mapper/rhel_readhat76-root   52403200 12393324   40009876  24% /
/dev/sdb2                          1038336   127428     910908  13% /boot
/dev/sdb1                           204580     7944     196636   4% /boot/efi
/dev/mapper/rhel_readhat76-home 3847258716    33008 3847225708   1% /home
tmpfs                             53569216        0   53569216   0% /run/user/0
/dev/loop0                         3109414  3109414          0 100% /mnt/cd_redhat7.6
localhost:/root/nfs-test-dir      52403200 12392448   40010752  24% /root/nfs-client-dir
```

## 在nfs客户段编译内核源码
源码需要位于挂载的目录下
```
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.0.3.tar.xz
xz -d linux-5.0.3.tar.xz

make defconfig

make -j48
```

## 复现成功



在nfs客户端编译停止
```
me@ubuntu:~/nfs-client-dir/linux-5.0.3$ sudo make -j48
  WRAP    arch/arm64/include/generated/uapi/asm/kvm_para.h
  WRAP    arch/arm64/include/generated/uapi/asm/errno.h
  WRAP    arch/arm64/include/generated/uapi/asm/ioctl.h
  WRAP    arch/arm64/include/generated/uapi/asm/ioctls.h
  WRAP    arch/arm64/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/arm64/include/generated/uapi/asm/mman.h
  WRAP    arch/arm64/include/generated/uapi/asm/msgbuf.h
  WRAP    arch/arm64/include/generated/uapi/asm/poll.h
  WRAP    arch/arm64/include/generated/uapi/asm/resource.h
  WRAP    arch/arm64/include/generated/uapi/asm/sembuf.h
  WRAP    arch/arm64/include/generated/uapi/asm/shmbuf.h
  WRAP    arch/arm64/include/generated/uapi/asm/siginfo.h
  UPD     include/config/kernel.release
  WRAP    arch/arm64/include/generated/uapi/asm/socket.h
  WRAP    arch/arm64/include/generated/uapi/asm/sockios.h
  WRAP    arch/arm64/include/generated/uapi/asm/swab.h
  WRAP    arch/arm64/include/generated/uapi/asm/termbits.h
  WRAP    arch/arm64/include/generated/uapi/asm/termios.h
  WRAP    arch/arm64/include/generated/uapi/asm/types.h
  UPD     include/generated/uapi/linux/version.h

```

在nfs客户端出现
```
me@ubuntu:~$ dmesg -T
[Thu Mar 21 15:17:02 2019] nfsacl: server 192.168.1.215 not responding, still trying
[Thu Mar 21 15:17:02 2019] nfsacl: server 192.168.1.215 not responding, still trying
```

在nfs服务端出现
```
[root@redhat76 linux-5.0.3]# dmesg -T
[Thu Mar 21 15:19:36 2019] rpc-srv/tcp: nfsd: got error -11 when sending 116 bytes - shutting down socket
[Thu Mar 21 15:21:15 2019] rpc-srv/tcp: nfsd: got error -11 when sending 116 bytes - shutting down socket
```

其中make的call stack是：
```
[Sat Apr 13 17:50:11 2019] [<ffff000008085e24>] __switch_to+0x8c/0xa8
[Sat Apr 13 17:50:11 2019] [<ffff000008828f18>] __schedule+0x328/0x860
[Sat Apr 13 17:50:11 2019] [<ffff000008829484>] schedule+0x34/0x8c
[Sat Apr 13 17:50:11 2019] [<ffff000000ef009c>] rpc_wait_bit_killable+0x2c/0xb8 [sunrpc]
[Sat Apr 13 17:50:11 2019] [<ffff000008829a7c>] __wait_on_bit+0xac/0xe0
[Sat Apr 13 17:50:11 2019] [<ffff000008829b58>] out_of_line_wait_on_bit+0xa8/0xcc
[Sat Apr 13 17:50:11 2019] [<ffff000000ef132c>] __rpc_execute+0x114/0x468 [sunrpc]
[Sat Apr 13 17:50:11 2019] [<ffff000000ef1a58>] rpc_execute+0x7c/0x10c [sunrpc]
[Sat Apr 13 17:50:11 2019] [<ffff000000ee1150>] rpc_run_task+0x118/0x168 [sunrpc]
[Sat Apr 13 17:50:11 2019] [<ffff000000ee3b44>] rpc_call_sync+0x6c/0xc0 [sunrpc]
[Sat Apr 13 17:50:11 2019] [<ffff000000de09dc>] nfs3_rpc_wrapper.constprop.11+0x78/0xd4 [nfsv3]
[Sat Apr 13 17:50:11 2019] [<ffff000000de1fd4>] nfs3_proc_getattr+0x70/0xec [nfsv3]
[Sat Apr 13 17:50:11 2019] [<ffff000002c7c114>] __nfs_revalidate_inode+0xf8/0x384 [nfs]
[Sat Apr 13 17:50:11 2019] [<ffff000002c755dc>] nfs_do_access+0x194/0x430 [nfs]
[Sat Apr 13 17:50:11 2019] [<ffff000002c75a48>] nfs_permission+0x15c/0x21c [nfs]
[Sat Apr 13 17:50:11 2019] [<ffff0000082adf08>] __inode_permission+0x98/0xf4
[Sat Apr 13 17:50:11 2019] [<ffff0000082adf94>] inode_permission+0x30/0x6c
[Sat Apr 13 17:50:11 2019] [<ffff0000082b10e4>] link_path_walk+0x7c/0x4ac
[Sat Apr 13 17:50:11 2019] [<ffff0000082b164c>] path_lookupat+0xac/0x230
[Sat Apr 13 17:50:11 2019] [<ffff0000082b29a4>] filename_lookup+0x90/0x158
[Sat Apr 13 17:50:11 2019] [<ffff0000082b2b9c>] user_path_at_empty+0x58/0x64
[Sat Apr 13 17:50:11 2019] [<ffff0000082a7b08>] vfs_statx+0x98/0x108
[Sat Apr 13 17:50:11 2019] [<ffff0000082a810c>] SyS_newfstatat+0x50/0x88
```
获取call_stack的办法是：
```
echo "w" > /proc/sysrq-trigger
dmesg
```
完整的log可以查看[[8DB]](resources/8DB_call_stack.txt)

## 编译内核进行验证
根据 [[redhat 编译内核]](redhat_build_kernel_zh.md) 编译新内核并安装。


## 重新验证
成功编译内核
```shell-session
  LD [M]  sound/soc/meson/snd-soc-meson-axg-tdm-formatter.ko
  LD [M]  sound/soc/meson/snd-soc-meson-axg-tdm-interface.ko
  LD [M]  sound/soc/meson/snd-soc-meson-axg-tdmin.ko
  LD [M]  sound/soc/meson/snd-soc-meson-axg-tdmout.ko
  LD [M]  sound/soc/meson/snd-soc-meson-axg-toddr.ko
  LD [M]  sound/soc/rockchip/snd-soc-rk3399-gru-sound.ko
  LD [M]  sound/soc/rockchip/snd-soc-rockchip-i2s.ko
  LD [M]  sound/soc/rockchip/snd-soc-rockchip-pcm.ko
  LD [M]  sound/soc/rockchip/snd-soc-rockchip-rt5645.ko
  LD [M]  sound/soc/rockchip/snd-soc-rockchip-spdif.ko
  LD [M]  sound/soc/sh/rcar/snd-soc-rcar.ko
me@ubuntu:~/nfs-client-dir/linux-5.0.3$
me@ubuntu:~/nfs-client-dir/linux-5.0.3$
me@ubuntu:~/nfs-client-dir/linux-5.0.3$
me@ubuntu:~/nfs-client-dir/linux-5.0.3$ ls
arch   built-in.a  COPYING  crypto         drivers   fs       init  Kbuild   kernel  LICENSES     Makefile  modules.builtin  Module.symvers  README   scripts   sound       tools  virt     vmlinux.o
block  certs       CREDITS  Documentation  firmware  include  ipc   Kconfig  lib     MAINTAINERS  mm        modules.order    net             samples  security  System.map  usr    vmlinux
```
没有出现nfs server not respond
```
me@ubuntu:~/nfs-client-dir/linux-5.0.3$ dmesg -T
me@ubuntu:~/nfs-client-dir/linux-5.0.3$
```

复现问题过程的问题
## 问题1 plex not found 
```
me@ubuntu:~/nfs-client-dir/linux-5.0.3$ sudo make defconfig
  LEX     scripts/kconfig/zconf.lex.c
/bin/sh: 1: flex: not found
scripts/Makefile.lib:193: recipe for target 'scripts/kconfig/zconf.lex.c' failed
make[1]: *** [scripts/kconfig/zconf.lex.c] Error 127
Makefile:538: recipe for target 'defconfig' failed
make: *** [defconfig] Error 2
```
解决办法是：
```
apt install plex
```

## 问题2 bison: not found
```
apt install bison
```

## 问题3 openssl not found
```
scripts/extract-cert.c:21:25: fatal error: openssl/bio.h: No such file or directory
 #include <openssl/bio.h>
                         ^
compilation terminated.
```
解决办法