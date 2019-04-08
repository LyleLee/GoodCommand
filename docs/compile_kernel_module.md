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


## 在内核代码树内构建模块
模块代码fishing.c放置在linux内核源码的drivers/char/fishing/fishing.c路径下。  
模块的Makefile仅有一句，文件放置在linux内核源码的drivers/char/fishing/Makefile路径下
```Makefile
obj-m += fishing.o
```
修改char的Makefile，文章末尾添加
```Makefile
#add by fishing module accroding to book
obj-m                           += fishing/
```
这个时候就可以执行make了。make会自动进入fishing目录，编译出fishing.ko.
```shell-session
[root@localhost linux]# ls -al drivers/char/fishing/fishing.ko
-rw-r--r--. 1 root root 58336 Apr  8 23:26 drivers/char/fishing/fishing.ko
```
其实可以单独便宜fishing模块，也可以单独clean这个模块
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
## 在内核代码树外构建模块
模块代码放置在/home/201-code/fishing.c路径下。  
模块的Makefile仅有一句，放置在/home/201-code/Makefile路径下。
```
obj-m += fishing.o
```
编译模块
```
cd home/201-code
make -C ../linux SUBDIRS=$PWD modules
```
../linux是源码树的路径


## 问题 modprobe ko not found
```
modprobe drivers/char/fishing/fishing.ko
modprobe: FATAL: Module drivers/char/fishing/fishing.ko not found.
```
原因是modprobe只查找/lib/modules/(uname -r)/下的ko。 但是把ko复制到相应目录下并未解决，可能需要make module_install才能起作用

