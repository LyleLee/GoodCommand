awk 文本处理工具
==========================
使用awk可以帮助我们快速处理文本，筛选数据。

## 例子1
重新编排文本列，加入`\t`之后复制到excel可以自动生成表格
```
cat arm_fio_simple.log | awk '{printf "%3d %s %-10s %2d %3d %s %s %-4s %s %s %6s %8s %7s %6s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14}' > arm_temp.txt
cat x86_simple.log | awk '{printf "%3s\t%20s\t%-20s\t%-6s\t%-10s\t%9s\t%-10s\t%-10s\t%-10s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9}' > excel_86.txt
```

处理之前x86_simple.log
```
5 bs-rw-numjob-iodepth 4k-read-1-64  100k   411MB/s   638.26   usr=7.77% sys=39.01%  
6 bs-rw-numjob-iodepth 4k-read-1-128  98.4k   403MB/s   1300.35   usr=8.04% sys=39.84%  
7 bs-rw-numjob-iodepth 4k-read-1-265  98.1k   402MB/s   2699.93   usr=8.65% sys=40.14%  
8 bs-rw-numjob-iodepth 4k-read-8-1  73.2k   300MB/s   108.57   usr=2.24% sys=14.11%  
9 bs-rw-numjob-iodepth 4k-read-8-4  98.5k   403MB/s   323.68   usr=1.96% sys=38.91
```
处理之后excel_86.txt
```
5	bs-rw-numjob-iodepth	4k-read-1-64        	100k  	411MB/s   	   638.26	usr=7.77% 	sys=39.01%
6	bs-rw-numjob-iodepth	4k-read-1-128       	98.4k 	403MB/s   	  1300.35	usr=8.04% 	sys=39.84%
7	bs-rw-numjob-iodepth	4k-read-1-265       	98.1k 	402MB/s   	  2699.93	usr=8.65% 	sys=40.14%
8	bs-rw-numjob-iodepth	4k-read-8-1         	73.2k 	300MB/s   	   108.57	usr=2.24% 	sys=14.11%
9	bs-rw-numjob-iodepth	4k-read-8-4         	98.5k 	403MB/s   	   323.68	usr=1.96% 	sys=38.91%
```
### 例子2
过滤程序输出，提取数据
```shell
#!/bin/bash
result="
4k_read: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=1
fio-3.13
Starting 1 process
Jobs: 1 (f=1): [R(1)][100.0%][r=128MiB/s][r=32.7k IOPS][eta 00m:00s]
4k_read: (groupid=0, jobs=1): err= 0: pid=44255: Mon Mar 18 03:32:57 2019
  read: IOPS=32.8k, BW=128MiB/s (134MB/s)(7679MiB/60001msec)
    slat (nsec): min=3722, max=34210, avg=3972.12, stdev=187.36
    clat (usec): min=11, max=1172, avg=25.81, stdev= 4.09
     lat (usec): min=27, max=1176, avg=29.90, stdev= 4.09
    clat percentiles (nsec):
     |  1.00th=[24192],  5.00th=[24192], 10.00th=[24448], 20.00th=[24960],
     | 30.00th=[24960], 40.00th=[24960], 50.00th=[25216], 60.00th=[25216],
     | 70.00th=[25216], 80.00th=[25472], 90.00th=[26240], 95.00th=[28800],
     | 99.00th=[50944], 99.50th=[51456], 99.90th=[55040], 99.95th=[57088],
     | 99.99th=[80384]
   bw (  KiB/s): min=128407, max=135016, per=99.98%, avg=131028.03, stdev=1461.54, samples=119
   iops        : min=32101, max=33754, avg=32756.97, stdev=365.39, samples=119
  lat (usec)   : 20=0.01%, 50=98.44%, 100=1.55%, 250=0.01%, 500=0.01%
  lat (msec)   : 2=0.01%
  cpu          : usr=4.51%, sys=16.50%, ctx=1965949, majf=0, minf=19
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=1965940,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=128MiB/s (134MB/s), 128MiB/s-128MiB/s (134MB/s-134MB/s), io=7679MiB (8052MB), run=60001-60001msec

Disk stats (read/write):
  sdb: ios=2120756/0, merge=0/0, ticks=47028/0, in_queue=46712, util=72.05%
"

iops_bandwith=$(echo "$result" | grep "IOPS=")
iops=$(echo $iops_bandwith | awk '{print $2}'|awk -F '[=,]' '{print $2}')
bandwith=$(echo $iops_bandwith | awk -F '[()]' '{print $2}')
lat=$(echo "$result" | grep "\ lat.*avg"| awk -F, '{print $3}'|awk -F= '{print $2}')
cpu=$(echo "$result" | grep cpu |awk -F '[:,]' '{print $2 $3}')

echo $iops $bandwith $lat $cpu

```
输出结果：
```
32.8k 134MB/s 29.90 usr=4.51% sys=16.50%
```


# awk 截取字符串
```
[root@ceph-node00 ceph]# lsblk | grep ceph
└─ceph--cbab595d--da69--431f--b7b6--c52101f10d39-osd--block--2091e673--d027--4b9f--b8c0--6e7f476fc741 253:11   0   7.3T  0 lvm
└─ceph--69275ba9--1d6a--4478--9ccd--1a23f7831b37-osd--block--4b24b591--1b1e--4e29--8c55--d279187e039d 253:9    0   7.3T  0 lvm
└─ceph--7805f320--84b3--4000--a6fb--c32bf9b32a0c-osd--block--4603b474--8bfa--47f7--b69a--0394a727d863 253:4    0   7.3T  0 lvm
└─ceph--2d3a8630--dbfb--4eba--97bf--7fbfb5cc91ef-osd--block--636d1e4b--5a01--4fc4--aa11--260f7356a7bc 253:14   0   7.3T  0 lvm
└─ceph--c4e816d1--6e97--4aef--9abf--7502c94709f6-osd--block--1f3e67b4--166b--408f--ae1a--6e07a4667bec 253:12   0   7.3T  0 lvm
└─ceph--7608df58--0556--424e--9b97--659a4bab1e84-osd--block--b5db2324--be59--4f59--8958--46394f580535 253:10   0   7.3T  0 lvm
└─ceph--7fe90132--69c8--4c15--a60f--7f2037b4230c-osd--block--b1b345d3--8e44--4f5b--807b--f1dcca93b5a2 253:8    0   7.3T  0 lvm
└─ceph--bf42f625--f8a1--4351--8762--3bc84847b90e-osd--block--478d5cda--a78d--41c3--a2f9--253c41e62cba 253:3    0   7.3T  0 lvm
└─ceph--b2a6fe35--c3df--46b3--981c--beaedfc27f53-osd--block--49c7c971--bf3e--481e--be2b--40c021ccb88b 253:13   0   7.3T  0 lvm
[root@ceph-node00 ceph]# lsblk | grep ceph | awk '{print substr($1,3)}'
ceph--cbab595d--da69--431f--b7b6--c52101f10d39-osd--block--2091e673--d027--4b9f--b8c0--6e7f476fc741
ceph--69275ba9--1d6a--4478--9ccd--1a23f7831b37-osd--block--4b24b591--1b1e--4e29--8c55--d279187e039d
ceph--7805f320--84b3--4000--a6fb--c32bf9b32a0c-osd--block--4603b474--8bfa--47f7--b69a--0394a727d863
ceph--dda7a760--1a67--45b0--8992--0148beea4146-osd--block--e887daf2--b51a--4c75--a793--e85c9af286b8
ceph--2d3a8630--dbfb--4eba--97bf--7fbfb5cc91ef-osd--block--636d1e4b--5a01--4fc4--aa11--260f7356a7bc
ceph--c4e816d1--6e97--4aef--9abf--7502c94709f6-osd--block--1f3e67b4--166b--408f--ae1a--6e07a4667bec
ceph--7608df58--0556--424e--9b97--659a4bab1e84-osd--block--b5db2324--be59--4f59--8958--46394f580535
ceph--7fe90132--69c8--4c15--a60f--7f2037b4230c-osd--bl
```


# awk 获取IP地址
```
ip a | awk '/inet /{print substr($2,5)}' |awk -F '[/]' '{print $1}'
```