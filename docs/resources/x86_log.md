x86 log
======================
记录X86相关的log

# HZ
查看定时器频率
```
cat ./include/asm-generic/param.h
```
```C
#ifndef __ASM_GENERIC_PARAM_H
#define __ASM_GENERIC_PARAM_H

#include <uapi/asm-generic/param.h>

# undef HZ
# define HZ             CONFIG_HZ       /* Internal kernel timer frequency */
# define USER_HZ        100             /* some user interfaces are */
# define CLOCKS_PER_SEC (USER_HZ)       /* in "ticks" like times() */
#endif /* __ASM_GENERIC_PARAM_H */
```
查看config设置的CONFIG_HZ
```
grep CONFIG_HZ /boot/config-3.10.0-957.el7.x86_64
```
```C
# CONFIG_HZ_PERIODIC is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
```