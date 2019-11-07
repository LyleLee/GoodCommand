pfring
======

pfring 是重放网络数据包的有有力工具

pfring发包

::

   /home/PF_RING-6.0.2/userland/examples/pfsend -i dna1 -f /data1/rawdata110   -r4 -n100
   /home/PF_RING-6.0.2/userland/examples/pfsend -i dna0 -f /data1/rawdata002 -r 5
   /home/PF_RING-6.0.2/userland/examples/pfsend -i dna0 -n 0 -r 5

   #更多参数
   -a              Active send retry
   -f <.pcap file> Send packets as read from a pcap file
   -g <core_id>    Bind this app to a core
   -h              Print this help
   -i <device>     Device name. Use device
   -l <length>     Packet length to send. Ignored with -f
   -n <num>        Num pkts to send (use 0 for infinite)
   -r <rate>       Rate to send (example -r 2.5 sends 2.5 Gbit/sec, -r -1 pcap capture rate)
   -m <dst MAC>    Reforge destination MAC (format AA:BB:CC:DD:EE:FF)
   -b <num>        Number of different IPs (balanced traffic)
   -w <watermark>  TX watermark (low value=low latency) [not effective on DNA]
   -z              Disable zero-copy, if supported [DNA only]
   -x <if index>   Send to the selected interface, if supported
   -d              Daemon mode
   -P <pid file>   Write pid to the specified file (daemon mode only)
   -v              Verbose

::

   watch -d -n 1 IPNetStat 0

测试线速

::

   134
   /home/jiuzhou/bin/jz_dpdk

   206
   /home/PF_RING-6.0.2/userland/examples/pfsend -i dna0 -f rawdata100 -r10 -n0
   /home/PF_RING-6.0.2/userland/examples/pfsend -i dna0 -r10 -n0               #需要制定要发送的IP数据包，否则自行构建的数据包可能不是IP数据包，测试结果较差
