kernel_levels.h
===================
定义了内核打印级别

# include/linux/kern_levels.h
内核源码树的这个文件定义了内核打印级别
或者参考[【github】](https://github.com/torvalds/linux/blob/master/include/linux/kern_levels.h)

```c
#define KERN_EMERG	KERN_SOH "0"	/* system is unusable */
#define KERN_ALERT	KERN_SOH "1"	/* action must be taken immediately */
#define KERN_CRIT	KERN_SOH "2"	/* critical conditions */
#define KERN_ERR	KERN_SOH "3"	/* error conditions */
#define KERN_WARNING	KERN_SOH "4"	/* warning conditions */
#define KERN_NOTICE	KERN_SOH "5"	/* normal but significant condition */
#define KERN_INFO	KERN_SOH "6"	/* informational */
#define KERN_DEBUG	KERN_SOH "7"	/* debug-level messages */

#define KERN_DEFAULT	""		/* the default kernel loglevel */
```

在内核模块代码使用printk打印信息：
```c
printk(KERN_INFO "EBB: Hello %s from the BBB LKM!\n", name);
```

## 查看当前系统的打印级别
```
cat /proc/sys/kernel/printk
```
使用sysctl可以达到同样效果
```
sysctl kernel/printk
```
```
4       4       1       7
```
The first value in our output is the current console_loglevel. This is the information we were looking for: the value, 4 in this case, represents the log level currently used. As said before this means that only messages adopting a severity level higher than it, will be displayed on the console. 

第一个参数是4， 是当前终端的打印级别

The second value in the output represents the default_message_loglevel. This value is automatically used for messages without a specific log level: if a message is not associated with a log level, this one will be used for it. 

第二个参数是4，是/var/log/messages 的默认保存级别

The third value in the output reports the minimum_console_loglevel status. It indicates the minimum loglevel which can be used for console_loglevel. The level here used it's 1, the highest. 

第三个参数是1，是最小化终端的打印级别

Finally, the last value represents the default_console_loglevel, which is the default loglevel used for console_loglevel at boot time. 

第四个参数是7，默认终端的打印级别。也就是系统启动时能看到的信息。

## 修改内核的打印级别

```
echo "7"  > /proc/sys/kernel/printk
```
使用sysctl可以达到同样效果
```
sudo sysctl -w kernel.printk=7
```
