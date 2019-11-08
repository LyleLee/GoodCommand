dstat
=====

dstat 功能丰富，可用于替代vmstat, iostat，netstat 和ifstat。

.. code:: shell-session

   root@ubuntu:~# dstat
   You did not select any stats, using -cdngy by default.
   --total-cpu-usage-- -dsk/total- -net/total- ---paging-- ---system--
   usr sys idl wai stl| read  writ| recv  send|  in   out | int   csw
     0   0 100   0   0|2019B 1422B|   0     0 |   0     0 |  62    73
     1   0  85  13   0|   0   124k|1031k 1449k|   0     0 |6324  4614
     0   0  88  12   0|   0    36k| 351k 2178k|   0     0 |5484  3732
     0   1  88  11   0|  20k  264k| 289k 1969k|   0     0 |8681  5838
     0   1  90   8   0|   0     0 | 512k 1843k|   0     0 |  13k 9888
     0   0  89  11   0|   0     0 | 428k 3169k|   0     0 |6685  4854
     1   1  91   8   0|   0  8192B| 355k 2070k|   0     0 |9556  7076
     1   1  92   7   0|   0  4096B| 396k 2796k|   0     0 |9253  6856
     0   0  92   7   0|   0    40k| 269k 1867k|   0     0 |7361  5017
     0   1  92   7   0|   0     0 | 392k 1774k|   0     0 |9138  6676
     1   1  91   7   0|   0     0 | 416k 1764k|   0     0 |  11k 7635
     3   1  90   6   0|   0   200k| 369k 1861k|   0     0 |9995  6864
     0   1  93   6   0|   0     0 | 286k 2162k|   0     0 |7412  5229
     0   1  93   6   0|   0     0 | 932k 2113k|   0     0 |9725  7276
     0   0  94   5   0|   0     0 | 340k 2799k|   0     0 |7805  5675
     0   0  95   4   0|   0     0 | 211k 1843k|   0     0 |4179  3235

.. code:: comments

   usr 执行用户程序耗时
   sys 执行系统程序耗时
   idl 空闲百分比
   wai 等待耗时
   stl

   read 读硬盘速度（每秒）
   writ 写硬盘速度（每秒）
   recv 接收到字节数
   send 发送字节数

   in  页面换入
   out 页面换出

   int 系统中断
   csw 上下文切换contxt switch
