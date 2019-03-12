
./configure 提示一些fio特性会依赖zlib
```
yum install zlib-devel.aarch64
```

编译安装好之后，version还是不对，需要重新登录系统才会生效。
```
[root@localhost fio-fio-3.13]# fio -v
fio-3.7
[root@localhost ~]# which fio
/usr/local/bin/fio
[root@localhost ~]# /usr/local/bin/fio -v
fio-3.13
[root@localhost ~]# 
```


```
[root@localhost fio-fio-3.13]# make install
install -m 755 -d /usr/local/bin
install fio t/fio-genzipf t/fio-btrace2fio t/fio-dedupe t/fio-verify-state ./tools/fio_generate_plots ./tools/plot/fio2gnuplot ./tools/genfio ./tools/fiologparser.py ./tools/hist/fiologparser_hist.py ./tools/fio_jsonplus_clat2csv /usr/local/bin
install -m 755 -d /usr/local/man/man1
install -m 644 ./fio.1 /usr/local/man/man1
install -m 644 ./tools/fio_generate_plots.1 /usr/local/man/man1
install -m 644 ./tools/plot/fio2gnuplot.1 /usr/local/man/man1
install -m 644 ./tools/hist/fiologparser_hist.py.1 /usr/local/man/man1
install -m 755 -d /usr/local/share/fio
install -m 644 ./tools/plot/*gpm /usr/local/share/fio/
```

编译安装后发现libaio无法加载
```
[root@localhost fio_scripts]# perf record -ag -o fio_symbol.data fio --ramp_time=5 --runtime=60 --size=10g --ioengine=libaio --filename=/dev/sdb --name=4k_read --numjobs=1 --rw=read --bs=4k --direct=1
fio: engine libaio not loadable
fio: engine libaio not loadable
fio: failed to load engine
```

查看当前系统支持的io引擎
```
fio -enghelp
```

fio --ramp_time=10 --runtime=60 --size=10g --ioengine=libaio --filename=/mnt/testfile.doc --name=4k_read --rw=read --bs=4k

问题：
+ ubuntu下缺少libaio库
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