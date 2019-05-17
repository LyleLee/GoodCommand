edac-util
============================
内存检测工具

正常的输出：
```CS
[root@hs home]# edac-util -v
mc0: 0 Uncorrected Errors with no DIMM info
mc0: 0 Corrected Errors with no DIMM info
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
异常的设备上的输出：
```CS
[root@hisilicon11 ]# edac-util -v
mc0: 0 Uncorrected Errors with no DIMM info
mc0: 15 Corrected Errors with no DIMM info
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