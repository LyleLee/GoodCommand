HDD broken 硬盘损坏
================

## 问题现象

硬盘为系统盘，使用scp拷贝数据时，在dmesg出现print_req_error，提示硬盘有损坏。安装gcc时，提示print_req_error。
之后工作不正常。无法使用ls命令。

```
[ 1522.788557] print_req_error: I/O error, dev sda, sector 7799367864 flags 80700
[ 1522.795796] sd 2:0:0:0: [sda] tag#728 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[ 1522.804227] sd 2:0:0:0: [sda] tag#728 Sense Key : Not Ready [current]
[ 1522.810750] sd 2:0:0:0: [sda] tag#728 Add. Sense: Logical unit not ready, hard reset required
[ 1522.819263] sd 2:0:0:0: [sda] tag#728 CDB: Read(16) 88 00 00 00 00 01 d0 e0 e9 b8 00 00 01 00 00 00
[ 1522.828294] print_req_error: I/O error, dev sda, sector 7799368120 flags 80700
[ 1522.835515] ata3: EH complete
[ 1522.838506] sd 2:0:0:0: [sda] tag#28 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 1522.838511] sd 2:0:0:0: [sda] tag#29 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 1522.838520] sd 2:0:0:0: [sda] tag#30 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 1522.838524] sd 2:0:0:0: [sda] tag#30 CDB: Write(16) 8a 00 00 00 00 01 cb 80 b0 02 00 00 00 01 00 00
[ 1522.838525] print_req_error: I/O error, dev sda, sector 7709175810 flags 1001
[ 1522.838538] XFS (dm-0): metadata I/O error in "xfs_buf_iodone_callback_error" at daddr 0x2 len 1 error 5
[ 1522.847287] sd 2:0:0:0: [sda] tag#28 CDB: Synchronize Cache(10) 35 00 00 00 00 00 00 00 00 00
[ 1522.856056] sd 2:0:0:0: [sda] tag#29 CDB: Read(16) 88 00 00 00 00 01 d0 e0 e8 b8 00 00 00 80 00 00
[ 1522.859003] sd 2:0:0:0: [sda] tag#31 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 1522.859006] sd 2:0:0:0: [sda] tag#31 CDB: Write(16) 8a 00 00 00 00 01 cb 80 b0 02 00 00 00 01 00 00
[ 1522.859008] print_req_error: I/O error, dev sda, sector 7709175810 flags 1001
[ 1522.859020] sd 2:0:0:0: [sda] tag#125 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[ 1522.859023] sd 2:0:0:0: [sda] tag#125 CDB: Write(16) 8a 00 00 00 00 01 cb 80 b0 18 00 00 00 10 00 00
[ 1522.859024] print_req_error: I/O error, dev sda, sector 7709175832 flags 1001
[ 1522.859031] sd 2:0:0:0: [sda] tag#126 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
```

## 问题分析

网上查到，这个问题大概率是硬盘损坏
```
print_req_error: I/O error, dev sda, sector 7799368120 flags 80700
```

借助smarttool来查看信息
```bash
smartctl -a /dev/sdb
```

原始的信息请查看[[dev_sdb_smartctl_output.txtl]](resources/dev_sdb_smartctl_output.txt)
```CS
smartctl 6.6 2017-11-05 r4594 [aarch64-linux-4.18.0-74.el8.aarch64] (local build)
Copyright (C) 2002-17, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Enterprise Capacity 3.5 HDD
Device Model:     ST4000NM0035-1V4107
Serial Number:    ZC14R1M8
LU WWN Device Id: 5 000c50 0a60470ef
Firmware Version: TN03
User Capacity:    4,000,787,030,016 bytes [4.00 TB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-3 T13/2161-D revision 5
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Wed Apr 17 04:48:27 2019 EDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82)	Offline data collection activity
					was completed without error.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		(  584) seconds.
Offline data collection
capabilities: 			 (0x7b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					General Purpose Logging supported.
Short self-test routine 
recommended polling time: 	 (   1) minutes.
Extended self-test routine
recommended polling time: 	 ( 425) minutes.
Conveyance self-test routine
recommended polling time: 	 (   2) minutes.
SCT capabilities: 	       (0x50bd)	SCT Status supported.
					SCT Error Recovery Control supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   054   053   044    Pre-fail  Always       -       8253459
  3 Spin_Up_Time            0x0003   093   092   000    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   100   100   020    Old_age   Always       -       79
  5 Reallocated_Sector_Ct   0x0033   100   100   010    Pre-fail  Always       -       60   #应为0，重定向分区，一般是硬盘损坏时由硬盘自行完成
  7 Seek_Error_Rate         0x000f   087   060   045    Pre-fail  Always       -       511774162
  9 Power_On_Hours          0x0032   097   097   000    Old_age   Always       -       3334 (205 144 0)
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   020    Old_age   Always       -       63
184 End-to-End_Error        0x0032   100   100   099    Old_age   Always       -       0
187 Reported_Uncorrect      0x0032   096   096   000    Old_age   Always       -       4
188 Command_Timeout         0x0032   100   089   000    Old_age   Always       -       22 22 31
189 High_Fly_Writes         0x003a   100   100   000    Old_age   Always       -       0
190 Airflow_Temperature_Cel 0x0022   063   049   040    Old_age   Always       -       37 (Min/Max 37/39)
191 G-Sense_Error_Rate      0x0032   100   100   000    Old_age   Always       -       718
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       23
193 Load_Cycle_Count        0x0032   097   097   000    Old_age   Always       -       7886
194 Temperature_Celsius     0x0022   037   051   000    Old_age   Always       -       37 (0 21 0 0 0)
195 Hardware_ECC_Recovered  0x001a   003   001   000    Old_age   Always       -       8253459
197 Current_Pending_Sector  0x0012   099   099   000    Old_age   Always       -       614   #应为0，停止分区，这些分区处于停止状态
198 Offline_Uncorrectable   0x0010   099   099   000    Old_age   Offline      -       614   #应为0，离线分区。表示不可用
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
240 Head_Flying_Hours       0x0000   100   253   000    Old_age   Offline      -       1045h+16m+00.994s
241 Total_LBAs_Written      0x0000   100   253   000    Old_age   Offline      -       4583746847
242 Total_LBAs_Read         0x0000   100   253   000    Old_age   Offline      -       3489786674

SMART Error Log Version: 1
ATA Error Count: 4
	CR = Command Register [HEX]
	FR = Features Register [HEX]
	SC = Sector Count Register [HEX]
	SN = Sector Number Register [HEX]
	CL = Cylinder Low Register [HEX]
	CH = Cylinder High Register [HEX]
	DH = Device/Head Register [HEX]
	DC = Device Command Register [HEX]
	ER = Error register [HEX]
	ST = Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=days, hh=hours, mm=minutes,
SS=sec, and sss=millisec. It "wraps" after 49.710 days.

Error 4 occurred at disk power-on lifetime: 3306 hours (137 days + 18 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 53 00 ff ff ff 0f  Error: UNC at LBA = 0x0fffffff = 268435455

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  60 00 20 80 d0 b2 40 00      00:10:59.166  READ FPDMA QUEUED
  60 00 00 ff ff ff 4f 00      00:10:55.078  READ FPDMA QUEUED
  60 00 20 ff ff ff 4f 00      00:10:54.341  READ FPDMA QUEUED
  60 00 00 ff ff ff 4f 00      00:10:54.334  READ FPDMA QUEUED
  60 00 80 ff ff ff 4f 00      00:10:54.333  READ FPDMA QUEUED

Error 3 occurred at disk power-on lifetime: 3293 hours (137 days + 5 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 53 00 ff ff ff 0f  Error: WP at LBA = 0x0fffffff = 268435455

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  61 00 20 ff ff ff 4f 00   1d+03:38:29.611  WRITE FPDMA QUEUED
  60 00 80 ff ff ff 4f 00   1d+03:38:29.611  READ FPDMA QUEUED
  61 00 08 ff ff ff 4f 00   1d+03:38:29.611  WRITE FPDMA QUEUED
  60 00 20 80 d0 b2 40 00   1d+03:38:29.610  READ FPDMA QUEUED
  60 00 20 ff ff ff 4f 00   1d+03:38:29.610  READ FPDMA QUEUED

Error 2 occurred at disk power-on lifetime: 3293 hours (137 days + 5 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 53 00 ff ff ff 0f  Error: WP at LBA = 0x0fffffff = 268435455

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  61 00 08 ff ff ff 4f 00   1d+03:37:57.039  WRITE FPDMA QUEUED
  60 00 20 80 d0 b2 40 00   1d+03:37:53.278  READ FPDMA QUEUED
  60 00 00 ff ff ff 4f 00   1d+03:37:51.151  READ FPDMA QUEUED
  60 00 20 ff ff ff 4f 00   1d+03:37:51.146  READ FPDMA QUEUED
  60 00 20 ff ff ff 4f 00   1d+03:37:51.140  READ FPDMA QUEUED

Error 1 occurred at disk power-on lifetime: 3287 hours (136 days + 23 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 53 00 ff ff ff 0f  Error: UNC at LBA = 0x0fffffff = 268435455

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  60 00 20 80 d0 b2 40 00      22:32:51.562  READ FPDMA QUEUED
  60 00 00 ff ff ff 4f 00      22:32:45.502  READ FPDMA QUEUED
  60 00 20 ff ff ff 4f 00      22:32:45.497  READ FPDMA QUEUED
  60 00 20 ff ff ff 4f 00      22:32:45.491  READ FPDMA QUEUED
  60 00 20 ff ff ff 4f 00      22:32:45.484  READ FPDMA QUEUED

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed: read failure       90%      3232         548968
# 2  Short offline       Completed: read failure       90%      3231         548964
# 3  Short offline       Completed: read failure       90%      3231         548969
# 4  Short offline       Completed: read failure       90%      3206         548969

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.


```