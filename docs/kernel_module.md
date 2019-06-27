编译内核模块
========================
根据《linux内核设计与实现第3版》如何编译内核模块呢？

模块代码
```c
/*
 * fishing.c __The Hello, World丨我们的第一个内核模块
 */
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
/*
 * * hello_init-初始化函数，当模块装栽时被调用，如果成功装栽返回零，否
 * *則返冋非零值
 *
 */
static int hello_init(void)
{
        printk(KERN_ALERT "I bear a charmed life.\n");
        return 0;
}
/*
* hello_exit—退出函数，当摸块卸栽时被调用
* */
static void hello_exit(void)
{
        printk(KERN_ALERT "Out, out, brief candle!\n");
}

module_init(hello_init);
module_exit(hello_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Shakespeare");
MODULE_DESCRIPTION("A Hello, World Module");
```


## 在内核代码树内构建模块【不使用内核配置选项】
模块代码fishing.c放置在linux内核源码的drivers/char/fishing/fishing.c路径下。  
模块的Makefile仅有一句，文件放置在linux内核源码的drivers/char/fishing/Makefile路径下
```Makefile
obj-m += fishing.o
```
修改drivers/char/Makefile，文章末尾添加
```Makefile
#add by fishing module accroding to book
obj-m                           += fishing/
```
这个时候就可以执行make了。make会自动进入fishing目录，编译出fishing.ko.
```shell-session
[root@localhost linux]# ls -al drivers/char/fishing/fishing.ko
-rw-r--r--. 1 root root 58336 Apr  8 23:26 drivers/char/fishing/fishing.ko
```
其实可以单独编译fishing模块，也可以单独clean这个模块
```shell-session
make drivers/char/fishing/fishing.ko
make drivers/char/fishing/fishing.ko clean
```
安装模块，卸载模块
```
insmod drivers/char/fishing/fishing.ko
rmmod drivers/char/fishing/fishing.ko
```
可以在dmesg中看到打印
``` 
[536435.653281] fishing: module verification failed: signature and/or required key missing - tainting kernel
[536435.655464] I bear a charmed life.
[536808.157762] Out, out, brief candle!
```
## 在内核代码树内构建模块【使用编译选项】
模块代码放置在/home/201-code/fishing/fishing.c路径下。
模块的Makefile仅有一句，放置在/home/201-code/fishing/Makefile路径下。
```Makefile
obj-(CONFIG_FISHING_POLE) += fishing.o
```
修改上一级模块的Makefile，即drivers/char/Makefile
```
obj-$(CONFIG_FISHING_POLE)      += fishing/
```
修改上一级模块的Kconfig，即
```config
source "drivers/char/fishing/Kconfig"
```
详细请查看
```Diff
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index e2e66a40c7f2..73f53caa2dd8 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -591,6 +591,7 @@ config TILE_SROM
 	  how to partition a single ROM for multiple purposes.
 
 source "drivers/char/xillybus/Kconfig"
+source "drivers/char/fishing/Kconfig"
 
 endmenu
 
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index bfb988a68c7a..169455628796 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -62,3 +62,7 @@ obj-$(CONFIG_XILLYBUS)		+= xillybus/
 obj-$(CONFIG_POWERNV_OP_PANEL)	+= powernv-op-panel.o
 
 obj-$(CONFIG_CRASH)            += crash.o
+
+#add by fishing module accroding to book
+#obj-m				+= fishing/
+obj-$(CONFIG_FISHING_POLE)	+= fishing/
diff --git a/drivers/char/fishing/Kconfig b/drivers/char/fishing/Kconfig
new file mode 100644
index 000000000000..68560cda570d
--- /dev/null
+++ b/drivers/char/fishing/Kconfig
@@ -0,0 +1,10 @@
+config FISHING_POLE
+       tristate "Fish Master 3000 support"
+       default m
+       help
+	       If you say Y here, support for the Firsh Master 3000 with computer
+               interface will be compiled into the kernel and accessible via a device
+               node. You can also say M here and the driver will be built as a module named fishing.ko
+
+               if unsure, say N
+
diff --git a/drivers/char/fishing/Makefile b/drivers/char/fishing/Makefile
new file mode 100644
index 000000000000..35e53bd6a136
--- /dev/null
+++ b/drivers/char/fishing/Makefile
@@ -0,0 +1,2 @@
+#obj-m += fishing.o
+obj-$(CONFIG_FISHING_POLE) += fishing.o
```

## 在内核代码树外构建模块【使用编译选项】
模块代码放置在/home/201-code/fishing/fishing.c路径下。  
模块的Makefile仅有一句，放置在/home/201-code/fishing/Makefile路径下。
```
obj-m += fishing.o
```
编译模块
```
cd home/201-code/fishing
make -C ../linux SUBDIRS=$PWD modules
```
../linux是源码树的路径



## 问题 modprobe ko not found
```
modprobe drivers/char/fishing/fishing.ko
modprobe: FATAL: Module drivers/char/fishing/fishing.ko not found.
```
原因是modprobe只查找/lib/modules/(uname -r)/下的ko。 但是把ko复制到相应目录下并未解决，可能需要make module_install才能起作用

## 问题：version magic
自行insmod是出现version magic的问题
```
sudo insmod drivers/char/fishing/fishing.ko
```
```
[Sun Jun 23 10:26:52 2019] fishing: version magic '4.15.18-dirty SMP preempt mod_unload aarch64' should be '4.15.0-29-generic SMP mod_unload aarch64'
```

```
me@ubuntu:~/code/linux$ modinfo drivers/char/fishing/fishing.ko
filename:       /home/me/code/linux/drivers/char/fishing/fishing.ko
description:    A Hello, World Module
author:         Shakespeare
license:        GPL
depends:
intree:         Y
name:           fishing
vermagic:       4.15.18-dirty SMP preempt mod_unload aarch64

```

