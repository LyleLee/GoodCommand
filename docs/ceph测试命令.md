rbd create foo2 --size 4096 --image-feature layering \
	-m node1 -k /etc/ceph/ceph.client.admin.keyring \
	-p rbd

//大小不够
rbd create foo2 --size 20480 --image-feature layering \
	-m node1 -k /etc/ceph/ceph.client.admin.keyring \
	-p rbd
//会默认map为/dev/rbd0
	
rbd map foo2 --name client.admin -m node1 \
	-k /etc/ceph/ceph.client.admin.keyring \
	-p rbd
	
fio --ramp_time=10 \
	--runtime=60 \
	--size=10g \
	--ioengine=libaio \
	--filename=/mnt/ceph-block-device \
	--rw=read \
	--bs=4k	\
	--name=4k_read
	
fio --ramp_time=10 --runtime=60 --size=10g --ioengine=libaio --filename=/mnt/ceph-block-device/test.doc --rw=read --bs=4k --name=4k_read 



## 创建一个
//大小不够

1. 在mgr节点，也就是node1上执行操作
```sh
ceph osd pool create big_ocean 64
ceph osd pool ls
rbd pool init big_ocean
```
2. 在ceph-client节点上， 准备创建块设备，使用是在ceph-client上。
```sh
rbd create foo3 --size 20480 --image-feature layering \
	-m node1 -k /etc/ceph/ceph.client.admin.keyring \
	-p big_ocean
rbd map foo3 --name client.admin -m node1 \
	-k /etc/ceph/ceph.client.admin.keyring \
	-p big_ocean
#自动打印生成路径
/dev/rbd1
#可以看到生成的/dev/rbd/big_ocean/foo3指向的是/dev/rbd1
root@ceph-client:~# ls -la /dev/rbd/big_ocean/foo3
lrwxrwxrwx 1 root root 10 Jan 11 17:47 /dev/rbd/big_ocean/foo3 -> ../../rbd1
root@ceph-client:~#
```
3. 在块设备上创建文件系统，并挂载
```sh
##命令格式root@ceph-client:~# sudo mkfs.ext4 -m0 /dev/rbd/{pool-name}/{foo3}
root@ceph-client:~# sudo mkfs.ext4 -m0 /dev/rbd/big_ocean/foo3
root@ceph-client:~# mkdir /mnt/ceph-block-device-foo3
root@ceph-client:~# mount /dev/rbd/big_ocean/foo3 /mnt/ceph-block-device-foo3/
```

4. 创建待测文件
```sh
root@ceph-client:~# cd /mnt/ceph-block-device-foo3/
root@ceph-client:/mnt/ceph-block-device-foo3# touch test.doc
root@ceph-client:/mnt/ceph-block-device-foo3# ls
lost+found  test.doc
root@ceph-client:/mnt/ceph-block-device-foo3#
```
5. fio测试
```sh
fio --ramp_time=10 --runtime=60 --size=10g --ioengine=libaio --filename=/mnt/ceph-block-device-foo3/test.doc --rw=read --bs=4k --name=4k_read 

4k_read: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=1
fio-3.1
Starting 1 process
4k_read: Laying out IO file (1 file / 10240MiB)
Jobs: 1 (f=1): [R(1)][46.1%][r=160MiB/s,w=0KiB/s][r=40.9k,w=0 IOPS][eta 01m:23s]
4k_read: (groupid=0, jobs=1): err= 0: pid=6120: Fri Jan 11 18:20:42 2019
   read: IOPS=18.1k, BW=70.7MiB/s (74.1MB/s)(4312MiB/60999msec)
    slat (usec): min=3, max=1586.9k, avg=52.39, stdev=3468.14
    clat (nsec): min=1320, max=83654k, avg=1528.66, stdev=79622.51
     lat (usec): min=4, max=1700.0k, avg=54.10, stdev=3533.46
    clat percentiles (nsec):
     |  1.00th=[ 1368],  5.00th=[ 1368], 10.00th=[ 1384], 20.00th=[ 1384],
     | 30.00th=[ 1384], 40.00th=[ 1400], 50.00th=[ 1400], 60.00th=[ 1400],
     | 70.00th=[ 1400], 80.00th=[ 1416], 90.00th=[ 1464], 95.00th=[ 1560],
     | 99.00th=[ 2544], 99.50th=[ 3376], 99.90th=[ 7008], 99.95th=[17536],
     | 99.99th=[23936]
   bw (  KiB/s): min=   97, max=129536, per=28.34%, avg=20517.06, stdev=21202.38, samples=109
   iops        : min=   24, max=32384, avg=5128.87, stdev=5300.64, samples=109
  lat (usec)   : 2=98.28%, 4=1.47%, 10=0.16%, 20=0.07%, 50=0.02%
  lat (usec)   : 100=0.01%, 250=0.01%, 500=0.01%
  lat (msec)   : 100=0.01%
  cpu          : usr=3.82%, sys=11.64%, ctx=17448, majf=0, minf=4
  IO depths    : 1=120.9%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=1103936,0,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=70.7MiB/s (74.1MB/s), 70.7MiB/s-70.7MiB/s (74.1MB/s-74.1MB/s), io=4312MiB (4522MB), run=60999-60999msec
```


fio集群状态
```sh
root@node1:/etc/ceph# ceph -s
  cluster:
    id:     dd666fac-75e5-48ee-9767-43dc34ac2775
    health: HEALTH_OK

  services:
    mon: 3 daemons, quorum node2,node1,node3
    mgr: node1(active)
    osd: 3 osds: 3 up, 3 in
    rgw: 1 daemon active

  data:
    pools:   8 pools, 144 pgs
    objects: 2.98k objects, 10.7GiB
    usage:   35.2GiB used, 265GiB / 300GiB avail
    pgs:     144 active+clean

  io:
    client:   2.67KiB/s rd, 646KiB/s wr, 2op/s rd, 169op/s wr
```