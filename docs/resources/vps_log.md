VPS log
=====================
记录vps相关的log


# HZ
查看定时器频率
```
cat ./include/asm-generic/param.h
```
```C
/* SPDX-License-Identifier: GPL-2.0 */
#ifndef __ASM_GENERIC_PARAM_H
#define __ASM_GENERIC_PARAM_H

#include <uapi/asm-generic/param.h>

# undef HZ
# define HZ             CONFIG_HZ       /* Internal kernel timer frequency */
# define USER_HZ        100             /* some user interfaces are */
# define CLOCKS_PER_SEC (USER_HZ)       /* in "ticks" like times() */
#endif /* __ASM_GENERIC_PARAM_H */
```
查看CONFIG_HZ
```
grep CONFIG_HZ /boot/config-4.15.0-20-generic
```
```config
# CONFIG_HZ_PERIODIC is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
root@ubuntu:/usr/src/linux-source-4.15.0/linux-source-4.15.0#
```