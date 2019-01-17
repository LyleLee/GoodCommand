1. 启动脚本
```
[root@kylin TaiShan_Test]# python TaiShan_Test.py
server test environment checking ...
which: no numactl in (/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/me/.local/bin:/home/me/bin)
警告：numactl-2.0.9-7.el7.aarch64.rpm: 头V3 RSA/SHA256 Signature, 密钥 ID 305d49d6: NOKEY
准备中...                          ########################################
正在升级/安装...
numactl-2.0.9-7.el7                   ########################################

server test environment checking ok
```
1. 用例1
```
(TaiShan) mem version=1  core_num=1   test_num=5
---1---1---5
======No 0 Test======
: streamv1core0
STREAM copy latency: 1.62 nanoseconds
STREAM copy bandwidth: 9875.08 MB/sec
STREAM scale latency: 1.63 nanoseconds
STREAM scale bandwidth: 9786.65 MB/sec
STREAM add latency: 2.18 nanoseconds
STREAM add bandwidth: 11012.61 MB/sec
STREAM triad latency: 2.17 nanoseconds
STREAM triad bandwidth: 11044.84 MB/sec
======No 1 Test======
: streamv1core0
STREAM copy latency: 1.82 nanoseconds
STREAM copy bandwidth: 8788.12 MB/sec
STREAM scale latency: 1.80 nanoseconds
STREAM scale bandwidth: 8910.27 MB/sec
STREAM add latency: 2.22 nanoseconds
STREAM add bandwidth: 10833.06 MB/sec
STREAM triad latency: 2.21 nanoseconds
STREAM triad bandwidth: 10851.28 MB/sec
======No 2 Test======
: streamv1core0
STREAM copy latency: 1.81 nanoseconds
STREAM copy bandwidth: 8823.59 MB/sec
STREAM scale latency: 1.78 nanoseconds
STREAM scale bandwidth: 8967.81 MB/sec
STREAM add latency: 2.17 nanoseconds
STREAM add bandwidth: 11066.23 MB/sec
STREAM triad latency: 2.19 nanoseconds
STREAM triad bandwidth: 10952.90 MB/sec
======No 3 Test======
: streamv1core0
STREAM copy latency: 1.66 nanoseconds
STREAM copy bandwidth: 9637.39 MB/sec
STREAM scale latency: 1.64 nanoseconds
STREAM scale bandwidth: 9740.18 MB/sec
STREAM add latency: 2.19 nanoseconds
STREAM add bandwidth: 10968.52 MB/sec
STREAM triad latency: 2.18 nanoseconds
STREAM triad bandwidth: 10985.99 MB/sec
======No 4 Test======
: streamv1core0
STREAM copy latency: 1.59 nanoseconds
STREAM copy bandwidth: 10034.87 MB/sec
STREAM scale latency: 1.59 nanoseconds
STREAM scale bandwidth: 10068.21 MB/sec
STREAM add latency: 2.17 nanoseconds
STREAM add bandwidth: 11060.11 MB/sec
STREAM triad latency: 2.17 nanoseconds
STREAM triad bandwidth: 11077.26 MB/sec

(TaiShan)
```
2. 用例2
```
(TaiShan) mem version=2  core_num=64  test_num=5
---2---64---5
======No 0 Test======
: streamv2core0-63
libnuma: Warning: node argument 1 is out of range

usage: numactl [--all | -a] [--interleave= | -i <nodes>] [--preferred= | -p <node>]
               [--physcpubind= | -C <cpus>] [--cpunodebind= | -N <nodes>]
               [--membind= | -m <nodes>] [--localalloc | -l] command args ...
       numactl [--show | -s]
       numactl [--hardware | -H]
       numactl [--length | -l <length>] [--offset | -o <offset>] [--shmmode | -M <shmmode>]
               [--strict | -t]
               [--shmid | -I <id>] --shm | -S <shmkeyfile>
               [--shmid | -I <id>] --file | -f <tmpfsfile>
               [--huge | -u] [--touch | -T]
               memory policy | --dump | -d | --dump-nodes | -D

memory policy is --interleave | -i, --preferred | -p, --membind | -m, --localalloc | -l
<nodes> is a comma delimited list of node numbers or A-B ranges or all.
Instead of a number a node can also be:
  netdev:DEV the node connected to network device DEV
  file:PATH  the node the block device of path is connected to
  ip:HOST    the node of the network device host routes through
  block:PATH the node of block device path
  pci:[seg:]bus:dev[:func] The node of a PCI device
<cpus> is a comma delimited list of cpu numbers or A-B ranges or all
all ranges can be inverted with !
all numbers and ranges can be made cpuset-relative with +
the old --cpubind argument is deprecated.
use --cpunodebind or --physcpubind instead
<length> can have g (GB), m (MB) or k (KB) suffixes
<0,1,2,3> is invalid
======No 1 Test======
: streamv2core0-63
libnuma: Warning: node argument 1 is out of range

usage: numactl [--all | -a] [--interleave= | -i <nodes>] [--preferred= | -p <node>]
               [--physcpubind= | -C <cpus>] [--cpunodebind= | -N <nodes>]
               [--membind= | -m <nodes>] [--localalloc | -l] command args ...
       numactl [--show | -s]
       numactl [--hardware | -H]
       numactl [--length | -l <length>] [--offset | -o <offset>] [--shmmode | -M <shmmode>]
               [--strict | -t]
               [--shmid | -I <id>] --shm | -S <shmkeyfile>
               [--shmid | -I <id>] --file | -f <tmpfsfile>
               [--huge | -u] [--touch | -T]
               memory policy | --dump | -d | --dump-nodes | -D

memory policy is --interleave | -i, --preferred | -p, --membind | -m, --localalloc | -l
<nodes> is a comma delimited list of node numbers or A-B ranges or all.
Instead of a number a node can also be:
  netdev:DEV the node connected to network device DEV
  file:PATH  the node the block device of path is connected to
  ip:HOST    the node of the network device host routes through
  block:PATH the node of block device path
  pci:[seg:]bus:dev[:func] The node of a PCI device
<cpus> is a comma delimited list of cpu numbers or A-B ranges or all
all ranges can be inverted with !
all numbers and ranges can be made cpuset-relative with +
the old --cpubind argument is deprecated.
use --cpunodebind or --physcpubind instead
<length> can have g (GB), m (MB) or k (KB) suffixes
<0,1,2,3> is invalid
```