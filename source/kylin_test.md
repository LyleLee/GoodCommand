1. IO randread
    ```
    (TaiShan) io rw_type=randread  blksize=4k runtime=180 filename=/dev/sda
    fio_test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
    fio-3.12
    Starting 1 process

    fio_test: (groupid=0, jobs=1): err= 0: pid=10363: Thu Jan 17 17:04:25 2019
      read: IOPS=42.7k, BW=167MiB/s (175MB/s)(29.4GiB/180200msec)
        slat (usec): min=5, max=1522.2k, avg=13.63, stdev=1279.37
        clat (usec): min=8, max=1560.9k, avg=1480.04, stdev=14231.26
         lat (usec): min=227, max=1641.3k, avg=1494.50, stdev=14307.51
        clat percentiles (usec):
         |  1.00th=[   277],  5.00th=[   396], 10.00th=[   537], 20.00th=[   758],
         | 30.00th=[   938], 40.00th=[  1106], 50.00th=[  1172], 60.00th=[  1254],
         | 70.00th=[  1303], 80.00th=[  1336], 90.00th=[  1369], 95.00th=[  1418],
         | 99.00th=[  1713], 99.50th=[ 14222], 99.90th=[ 58459], 99.95th=[132645],
         | 99.99th=[817890]
       bw (  KiB/s): min=    0, max=296224, per=18.88%, avg=32268.65, stdev=56648.94, samples=330
       iops        : min=    0, max=74056, avg=8066.82, stdev=14162.30, samples=330
      lat (usec)   : 10=0.01%, 250=0.32%, 500=8.42%, 750=10.91%, 1000=14.09%
      lat (msec)   : 2=65.40%, 4=0.03%, 10=0.01%, 20=0.55%, 50=0.16%
      lat (msec)   : 100=0.04%, 250=0.04%, 500=0.02%, 750=0.01%, 1000=0.01%
      cpu          : usr=13.78%, sys=63.29%, ctx=48658, majf=0, minf=11
      IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
         submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
         complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
         issued rwts: total=7699499,0,0,0 short=0,0,0,0 dropped=0,0,0,0
         latency   : target=0, window=0, percentile=100.00%, depth=64

    Run status group 0 (all jobs):
       READ: bw=167MiB/s (175MB/s), 167MiB/s-167MiB/s (175MB/s-175MB/s), io=29.4GiB (31.5GB), run=180200-180200msec

    Disk stats (read/write):
      sda: ios=7691474/0, merge=0/0, ticks=4884430/0, in_queue=4884570, util=92.53%

    (TaiShan)
    ```
2. IO randwrite
    ```
    (TaiShan) io rw_type=randwrite blksize=4k runtime=180 filename=/dev/sda
    fio_test: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
    fio-3.12
    Starting 1 process

    fio_test: (groupid=0, jobs=1): err= 0: pid=10395: Thu Jan 17 17:08:58 2019
      write: IOPS=55, BW=222KiB/s (227kB/s)(39.2MiB/180976msec); 0 zone resets
        slat (usec): min=8, max=116, avg=20.46, stdev= 6.82
        clat (msec): min=240, max=2682, avg=1152.96, stdev=288.99
         lat (msec): min=240, max=2682, avg=1152.98, stdev=288.99
        clat percentiles (msec):
         |  1.00th=[  693],  5.00th=[  760], 10.00th=[  810], 20.00th=[  919],
         | 30.00th=[  986], 40.00th=[ 1045], 50.00th=[ 1116], 60.00th=[ 1167],
         | 70.00th=[ 1284], 80.00th=[ 1385], 90.00th=[ 1519], 95.00th=[ 1636],
         | 99.00th=[ 2072], 99.50th=[ 2299], 99.90th=[ 2601], 99.95th=[ 2635],
         | 99.99th=[ 2635]
       bw (  KiB/s): min=    8, max=  448, per=100.00%, avg=223.41, stdev=74.80, samples=357
       iops        : min=    2, max=  112, avg=55.83, stdev=18.69, samples=357
      lat (msec)   : 250=0.01%, 500=0.10%, 750=4.41%, 1000=27.21%
      cpu          : usr=0.05%, sys=0.15%, ctx=8927, majf=0, minf=7
      IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.2%, 32=0.3%, >=64=99.4%
         submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
         complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
         issued rwts: total=0,10044,0,0 short=0,0,0,0 dropped=0,0,0,0
         latency   : target=0, window=0, percentile=100.00%, depth=64

    Run status group 0 (all jobs):
      WRITE: bw=222KiB/s (227kB/s), 222KiB/s-222KiB/s (227kB/s-227kB/s), io=39.2MiB (41.1MB), run=180976-180976msec

    Disk stats (read/write):
      sda: ios=15/10020, merge=0/0, ticks=6890/11525840, in_queue=11556750, util=99.95%

    (TaiShan)
    ```
3. IO read
    ```
    (TaiShan) io rw_type=read blksize=1m runtime=180 filename=/dev/sda
    fio_test: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=libaio, iodepth=64
    fio-3.12
    Starting 1 process

    fio_test: (groupid=0, jobs=1): err= 0: pid=10476: Thu Jan 17 17:14:02 2019
      read: IOPS=4686, BW=4687MiB/s (4915MB/s)(50.0GiB/10924msec)
        slat (usec): min=8, max=31408, avg=26.74, stdev=432.78
        clat (usec): min=807, max=532914, avg=13300.79, stdev=16351.60
         lat (usec): min=818, max=533113, avg=13328.31, stdev=16511.62
        clat percentiles (msec):
         |  1.00th=[    3],  5.00th=[    7], 10.00th=[    8], 20.00th=[   11],
         | 30.00th=[   12], 40.00th=[   12], 50.00th=[   13], 60.00th=[   13],
         | 70.00th=[   13], 80.00th=[   14], 90.00th=[   17], 95.00th=[   20],
         | 99.00th=[   30], 99.50th=[   82], 99.90th=[  239], 99.95th=[  313],
         | 99.99th=[  485]
       bw (  MiB/s): min= 1518, max= 5398, per=100.00%, avg=4880.75, stdev=969.45, samples=20
       iops        : min= 1518, max= 5398, avg=4880.70, stdev=969.55, samples=20
      lat (usec)   : 1000=0.17%
      lat (msec)   : 2=0.50%, 4=1.37%, 10=15.64%, 20=78.72%, 50=2.73%
      lat (msec)   : 100=0.39%, 250=0.41%, 500=0.06%, 750=0.01%
      cpu          : usr=1.83%, sys=13.79%, ctx=6066, majf=0, minf=1031
      IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
         submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
         complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
         issued rwts: total=51200,0,0,0 short=0,0,0,0 dropped=0,0,0,0
         latency   : target=0, window=0, percentile=100.00%, depth=64

    Run status group 0 (all jobs):
       READ: bw=4687MiB/s (4915MB/s), 4687MiB/s-4687MiB/s (4915MB/s-4915MB/s), io=50.0GiB (53.7GB), run=10924-10924msec

    Disk stats (read/write):
      sda: ios=50924/0, merge=0/0, ticks=643400/0, in_queue=644270, util=95.88%

    (TaiShan)
    ```
4. IO write
    ```
    (TaiShan) io rw_type=write     blksize=1m runtime=180 filename=/dev/sda
    fio_test: (g=0): rw=write, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=libaio, iodepth=64
    fio-3.12
    Starting 1 process

    fio_test: (groupid=0, jobs=1): err= 0: pid=10492: Thu Jan 17 17:18:09 2019
      write: IOPS=88, BW=88.7MiB/s (93.0MB/s)(15.6GiB/180071msec); 0 zone resets
        slat (usec): min=36, max=1178.6k, avg=572.23, stdev=15702.50
        clat (usec): min=1554, max=25826k, avg=720642.62, stdev=3339274.07
         lat (usec): min=1617, max=25826k, avg=721238.18, stdev=3339258.24
        clat percentiles (msec):
         |  1.00th=[    3],  5.00th=[    4], 10.00th=[    4], 20.00th=[    5],
         | 30.00th=[    6], 40.00th=[    8], 50.00th=[   12], 60.00th=[   20],
         | 70.00th=[   33], 80.00th=[   63], 90.00th=[  506], 95.00th=[ 1569],
         | 99.00th=[17113], 99.50th=[17113], 99.90th=[17113], 99.95th=[17113],
         | 99.99th=[17113]
       bw (  KiB/s): min= 1256, max=720896, per=100.00%, avg=164592.60, stdev=198090.85, samples=60
       iops        : min=    1, max=  704, avg=160.28, stdev=193.61, samples=60
      lat (msec)   : 2=0.23%, 4=13.39%, 10=33.90%, 20=13.09%, 50=16.42%
      lat (msec)   : 100=6.18%, 250=3.17%, 500=3.59%, 750=1.33%, 1000=0.90%
      cpu          : usr=3.17%, sys=1.36%, ctx=12384, majf=0, minf=7
      IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.2%, >=64=99.6%
         submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
         complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
         issued rwts: total=0,15977,0,0 short=0,0,0,0 dropped=0,0,0,0
         latency   : target=0, window=0, percentile=100.00%, depth=64

    Run status group 0 (all jobs):
      WRITE: bw=88.7MiB/s (93.0MB/s), 88.7MiB/s-88.7MiB/s (93.0MB/s-93.0MB/s), io=15.6GiB (16.8GB), run=180071-180071msec

    Disk stats (read/write):
      sda: ios=15/15913, merge=0/0, ticks=20/9805160, in_queue=11089730, util=97.90%
    ```