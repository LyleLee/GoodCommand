集群4k随机写时延最大值超过了1ms
============
randwrite-4k-iodepth=2-numjobs=1.txt
```
mytest: (groupid=0, jobs=1): err= 0: pid=25587: Sat Jul  6 14:16:34 2019
  write: IOPS=189, BW=756KiB/s (775kB/s)(443MiB/600014msec)
    slat (nsec): min=2651, max=79920, avg=16935.79, stdev=4834.27
    clat (usec): min=775, max=1635.7k, avg=10547.28, stdev=40638.47
     lat (usec): min=792, max=1635.7k, avg=10564.21, stdev=40638.56
    clat percentiles (usec):
```
randwrite-4k-iodepth=32-numjobs=1.txt
```
mytest: (groupid=0, jobs=1): err= 0: pid=26945: Sat Jul  6 14:27:35 2019
  write: IOPS=529, BW=2116KiB/s (2167kB/s)(1240MiB/600211msec)
    slat (usec): min=2, max=1252, avg= 6.60, stdev= 8.83
    clat (usec): min=757, max=1643.2k, avg=60380.21, stdev=109530.00
     lat (usec): min=775, max=1643.2k, avg=60386.81, stdev=109530.05
    clat percentiles (usec):
     |  1.00th=[   1123],  5.00th=[   1450], 10.00th=[   1696],
     | 20.00th=[   2073], 30.00th=[   2343], 40.00th=[   2606],
     | 50.00th=[   2835], 60.00th=[   3130], 70.00th=[  13304],
     | 80.00th=[ 147850], 90.00th=[ 258999], 95.00th=[ 278922],
     | 99.00th=[ 371196], 99.50th=[ 471860], 99.90th=[ 683672],
```