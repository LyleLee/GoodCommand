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

2019年7月27日11:50:40 添加：


远程测试randwrite iodepth=2的情况：
大部分IO在毫秒级完成，平均值时正常的，在1s左右。 最大值1.4秒。 超过两秒的IO占比0.01%。
```
[root@localhost single_rbd_json]# fio -iodepth=2 -rw=randwrite -ioengine=rbd -rbdname=test-045 -clientname=admin -pool=volumes -bs=4k -numjobs=1 -ramp_time=60 -runtime=600 -size=100% -name=mytest1
mytest1: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=rbd, iodepth=2
fio-3.1
Starting 1 process
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=1120KiB/s][r=0,w=280 IOPS][eta 00m:00s]
mytest1: (groupid=0, jobs=1): err= 0: pid=1469666: Sat Jul 27 11:17:07 2019
  write: IOPS=194, BW=780KiB/s (798kB/s)(457MiB/600061msec)
    slat (nsec): min=1263, max=77223, avg=9816.68, stdev=7164.70
    clat (usec): min=642, max=1466.2k, avg=10241.64, stdev=38980.49
     lat (usec): min=652, max=1466.2k, avg=10251.45, stdev=38980.87
    clat percentiles (usec):
     |  1.00th=[   824],  5.00th=[   889], 10.00th=[   930], 20.00th=[   971],
     | 30.00th=[  1012], 40.00th=[  1045], 50.00th=[  1074], 60.00th=[  1123],
     | 70.00th=[  1172], 80.00th=[  1254], 90.00th=[  2212], 95.00th=[ 62653],
     | 99.00th=[208667], 99.50th=[240124], 99.90th=[283116], 99.95th=[295699],
     | 99.99th=[434111]
   bw (  KiB/s): min=   32, max= 2104, per=100.00%, avg=782.48, stdev=291.88, samples=1197
   iops        : min=    8, max=  526, avg=195.57, stdev=72.97, samples=1197
  lat (usec)   : 750=0.05%, 1000=26.71%
  lat (msec)   : 2=61.52%, 4=3.38%, 10=0.83%, 20=0.51%, 50=1.54%
  lat (msec)   : 100=1.27%, 250=3.79%, 500=0.39%, 750=0.01%, 2000=0.01%
  cpu          : usr=0.50%, sys=0.24%, ctx=75826, majf=0, minf=6448
  IO depths    : 1=37.4%, 2=71.9%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,116962,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=2

Run status group 0 (all jobs):
  WRITE: bw=780KiB/s (798kB/s), 780KiB/s-780KiB/s (798kB/s-798kB/s), io=457MiB (479MB), 
```

远程测试randwrite iodepth=32的情况：
```
[root@localhost single_rbd_json]# fio -iodepth=32 -rw=randwrite -ioengine=rbd -rbdname=test-045 -clientname=admin -pool=volumes -bs=4k -numjobs=1 -ramp_time=60 -ru
ntime=600 -size=100% -name=mytest1
mytest1: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=rbd, iodepth=32
fio-3.1
Starting 1 process
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=2250KiB/s][r=0,w=562 IOPS][eta 00m:00s]
mytest1: (groupid=0, jobs=1): err= 0: pid=1507429: Sat Jul 27 11:47:52 2019
  write: IOPS=570, BW=2281KiB/s (2336kB/s)(1337MiB/600267msec)
    slat (nsec): min=951, max=146901, avg=4029.70, stdev=5302.06
    clat (usec): min=672, max=1447.7k, avg=56048.07, stdev=101412.70
     lat (usec): min=674, max=1447.7k, avg=56052.10, stdev=101412.84
    clat percentiles (usec):
     |  1.00th=[    996],  5.00th=[   1188], 10.00th=[   1303],
     | 20.00th=[   1467], 30.00th=[   1598], 40.00th=[   1729],
     | 50.00th=[   1844], 60.00th=[   1991], 70.00th=[  10683],
     | 80.00th=[ 137364], 90.00th=[ 248513], 95.00th=[ 270533],
     | 99.00th=[ 333448], 99.50th=[ 421528], 99.90th=[ 530580],
     | 99.95th=[ 583009], 99.99th=[1098908]
   bw (  KiB/s): min=  256, max= 4800, per=100.00%, avg=2290.23, stdev=651.62, samples=1197
   iops        : min=   64, max= 1200, avg=572.51, stdev=162.90, samples=1197
  lat (usec)   : 750=0.01%, 1000=1.07%
  lat (msec)   : 2=59.14%, 4=8.36%, 10=1.32%, 20=1.42%, 50=3.57%
  lat (msec)   : 100=3.07%, 250=12.41%, 500=9.40%, 750=0.21%, 1000=0.01%
  lat (msec)   : 2000=0.02%
  cpu          : usr=0.39%, sys=0.05%, ctx=36070, majf=0, minf=19155
  IO depths    : 1=0.3%, 2=1.1%, 4=4.5%, 8=19.0%, 16=77.3%, 32=7.4%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=95.2%, 8=0.6%, 16=1.4%, 32=2.9%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,342312,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: bw=2281KiB/s 
```



看一下其他rbd是不是有同样的情况
```
fio -iodepth=2 -rw=randwrite -ioengine=rbd -rbdname=test-090 -clientname=admin -pool=volumes -bs=4k -numjobs=1 -ramp_time=60 -runtime=600 -size=100% -name=mytest1
```