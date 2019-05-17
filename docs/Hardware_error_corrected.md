Hardware Corrected Errors
======================
在服务器串口上发现上报Hareware error，最后发现是内存条有问题。设备可以正常启动OS，但是运行一段时间后会自动重启。

在message中查看到重启记录
```CS
May 13 15:05:20 hisilicon11 kernel: EDAC MC0: 1 CE reserved error (16) on unknown label (node:0 rank:0 bank:0 row:0 col:0 page:0x400000 offset:0x300 grain:0 syndrome:0x0)
May 13 15:05:20 hisilicon11 kernel: EDAC MC0: 1 CE reserved error (16) on unknown label (node:0 rank:0 bank:0 row:0 col:0 page:0x400000 offset:0x300 grain:0 syndrome:0x0)
May 13 15:05:20 hisilicon11 kernel: EDAC MC0: 1 CE reserved error (16) on unknown label (node:0 rank:0 bank:0 row:0 col:0 page:0x400000 offset:0x300 grain:0 syndrome:0x0)
May 13 15:05:21 hisilicon11 kernel: EDAC MC0: 1 CE reserved error (16) on unknown label (node:0 rank:0 bank:0 row:0 col:0 page:0x400000 offset:0x300 grain:0 syndrome:0x0)
May 13 15:05:21 hisilicon11 kernel: EDAC MC0: 1 CE reserved error (16) on unknown label (node:0 rank:0 bank:0 row:0 col:0 page:0x400000 offset:0x300 grain:0 syndrome:0x0)
May 13 15:05:21 hisilicon11 kernel: EDAC MC0: 1 CE reserved error (16) on unknown label (node:0 rank:0 bank:0 row:0 col:0 page:0x400000 offset:0x300 grain:0 syndrome:0x0)
May  5 18:18:46 hisilicon11 journal: Runtime journal is using 8.0M (max allowed 4.0G, trying to leave 4.0G free of 255.5G available → current limit 4.0G).
May  5 18:18:46 hisilicon11 kernel: Booting Linux on physical CPU 0x0000080000 [0x481fd010]
May  5 18:18:46 hisilicon11 kernel: Linux version 4.19.28.3-2019-05-13 (lixianfa@ubuntu) (gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.10)) #2 SMP Mon May 13 10:20:47 CST 2019
May  5 18:18:46 hisilicon11 kernel: efi: Getting EFI parameters from FDT:
May  5 18:18:46 hisilicon11 kernel: efi: EFI v2.70 by EDK II
May  5 18:18:46 hisilicon11 kernel: efi:  SMBIOS 3.0=0x3f0f0000  ACPI 2.0=0x39cb0000  MEMATTR=0x3b4bc018  ESRT=0x3f11bc98  RNG=0x3f11bd98  MEMRESERVE=0x39bb4d18 
May  5 18:18:46 hisilicon11 kernel: efi: seeding entropy pool
May  5 18:18:46 hisilicon11 kernel: esrt: Reserving ESRT space from 0x000000003f11bc98 to 0x000000003f11bcd0.
May  5 18:18:46 hisilicon11 kernel: crashkernel: memory value expected
May  5 18:18:46 hisilicon
```

在BIOS启动日子打印NOTICE 可纠正错误
```CS
NOTICE:  [TotemRasIntMemoryNodeFhi]:[197L] 

NOTICE:  [MemoryErrorFillInHest]:[245L]ErrorType is CE, ErrorSeverity is CORRECTED. #纠正错误

NOTICE:  [IsMemoryError]:[156L]Ierr = 0xf

NOTICE:  RASC socket[0]die[3]channel[3]						#内存条位置
NOTICE:  [GetMemoryErrorDataErrorType]:[103L]Ierr = 0xf

NOTICE:  RASC H[0]L[0]
NOTICE:  PlatData R[0]B[0] R[0]C[0]
NOTICE:  [CollectArerErrorData]:[226L]SysAddr=4000000300:  #物理地址
NOTICE:  [HestGhesV2ResetAck]:[84L] I[2] CeValid[0]

NOTICE:  [HestGhesV2ResetAck]:[84L] Index 2 

NOTICE:  count[0] Severity[2] CeValid[0]

NOTICE:  [HestGhesV2SetGenericErrorData]:[163L] Fill in HEST TABLE ,AckRegister=44010050
NOTICE:  [HestNotifiedOS]:[37L]
NOTICE:  [TotemRasIntM = 0x0 
```
在系统启动过程中打印Hareware error
```CS
[   27.740329] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 5
[   27.753985] {1}[Hardware Error]: It has been coHz, action=0.
[   27.791954] {1}[Hardware Error]: event severity: corrected
[   27.791957] {1}[Hardware Error]:  Error 0, type: corrected
[   27.791959] {1}[Hardware Error]:   section_type: memory error
[   27.814227] {1}[Hardware Error]:   physical_address: 0x0000004000000300 #同样的物理地址
[   27.830193] {1}[Hardware Error]:   node: 0 rank: 0 bank: 0 row: 0 column: 0 
[   27.830197] {1}[Hardw0 row:0 col:0 page:0x400000 offset:0x300 grain:0 syndrome:0x0)
```
在OS内部使用edac-utils -v可以查看到可纠正错误。
```shell
edac-util -v
```
```CS
mc0: 0 Uncorrected Errors with no DIMM info
mc0: 13 Corrected Errors with no DIMM info			#可纠正错误
mc0: csrow0: 0 Uncorrected Errors
mc0: csrow0: mc#0memory#0: 0 Corrected Errors
mc0: csrow10: 0 Uncorrected Errors
mc0: csrow10: mc#0memory#10: 0 Corrected Errors
mc0: csrow12: 0 Uncorrected Errors
mc0: csrow12: mc#0memory#12: 0 Corrected Errors
mc0: csrow14: 0 Uncorrected Errors
mc0: csrow14: mc#0memory#14: 0 Corrected Errors
mc0: csrow16: 0 Uncorrected Errors
mc0: csrow16: mc#0memory#16: 0 Corrected Errors
mc0: csrow18: 0 Uncorrected Errors
mc0: csrow18: mc#0memory#18: 0 Corrected Errors
mc0: csrow2: 0 Uncorrected Errors
mc0: csrow2: mc#0memory#2: 0 Corrected Errors
mc0: csrow20: 0 Uncorrected Errors
mc0: csrow20: mc#0memory#20: 0 Corrected Errors
mc0: csrow22: 0 Uncorrected Errors
mc0: csrow22: mc#0memory#22: 0 Corrected Errors
mc0: csrow24: 0 Uncorrected Errors
mc0: csrow24: mc#0memory#24: 0 Corrected Errors
mc0: csrow26: 0 Uncorrected Errors
mc0: csrow26: mc#0memory#26: 0 Corrected Errors
mc0: csrow28: 0 Uncorrected Errors
mc0: csrow28: mc#0memory#28: 0 Corrected Errors
mc0: csrow30: 0 Uncorrected Errors
mc0: csrow30: mc#0memory#30: 0 Corrected Errors
mc0: csrow4: 0 Uncorrected Errors
mc0: csrow4: mc#0memory#4: 0 Corrected Errors
mc0: csrow6: 0 Uncorrected Errors
mc0: csrow6: mc#0memory#6: 0 Corrected Errors
mc0: csrow8: 0 Uncorrected Errors
mc0: csrow8: mc#0memory#8: 0 Corrected Errors
```
在OS内部使用dmesg看到重复上报的可纠正错误
```CS
[ 2624.662038] {3}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 5
[ 2624.662200] {3}[Hardware Error]: It has been corrected by h/w and requires no further action
[ 2624.662396] {3}[Hardware Error]: event severity: corrected
[ 2624.662526] {3}[Hardware Error]:  Error 0, type: corrected
[ 2624.662654] {3}[Hardware Error]:   section_type: memory error
[ 2624.662784] {3}[Hardware Error]:   physical_address: 0x0000004000000300		#同样的物理地址
[ 2624.662941] {3}[Hardware Error]:   node: 0 rank: 0 bank: 0 row: 0 column: 0 
[ 2624.663102] {3}[Hardware Error]:   error_type: 16, unknown
[ 2624.663236] EDAC MC0: 1 CE reserved error (16) on unknown label (node:0 rank:0 bank:0 row:0 col:0 page:0x400000 offset:0x300 grain:0 syndrome:0x0)
[12083.123880] {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 5
[12083.124069] {4}[Hardware Error]: It has been corrected by h/w and requires no further action
[12083.124279] {4}[Hardware Error]: event severity: corrected
[12083.124417] {4}[Hardware Error]:  Error 0, type: corrected
[12083.124557] {4}[Hardware Error]:   section_type: memory error
[12083.124702] {4}[Hardware Error]:   physical_address: 0x0000004000000300
[12083.124870] {4}[Hardware Error]:   node: 0 rank: 0 bank: 0 row: 0 column: 0 
[12083.125043] {4}[Hardware Error]:   error_type: 16, unknown
[12083.125188] EDAC MC0: 1 CE reserved error (16) on unknown label (node:0 rank:0 bank:0 row:0 col:0 page:0x400000 offset:0x300 grain:0 syndrome:0x0)
[12383.322871] {5}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 5
[12383.323060] {5}[Hardware Error]: It has been corrected by h/w and requires no further action
[12383.323269] {5}[Hardware Error]: event severity: corrected
[12383.323409] {5}[Hardware Error]:  Error 0, type: corrected
[12383.323546] {5}[Hardware Error]:   section_type: memory error
[12383.323692] {5}[Hardware Error]:   physical_address: 0x0000004000000300
[12383.323857] {5}[Hardware Error]:   node: 0 rank: 0 bank: 0 row: 0 column: 0
```

解决办法是：

拔掉BIOS启动中提示的内存条，会发现错误消失。具体是那根内存条，由BIOS和EVB确定。
