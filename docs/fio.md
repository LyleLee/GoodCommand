

fio --ramp_time=10 --runtime=60 --size=10g --ioengine=libaio --filename=/mnt/testfile.doc --name=4k_read --rw=read --bs=4k

问题：
+ 缺少libaio库
```console
4k_read: No I/O performed by libaio, perhaps try --debug=io option for details?
```
解决办法
```console
sudo apt-get install libaio-dev
```
+ 限制带宽和IOPS
```console
--rate 400k,300k
```
把读速率设置为400kB/s， 把写速率设置为300kB/s