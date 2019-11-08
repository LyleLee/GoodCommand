nethogs 显示程序即时流量
========================

很多时候我们想观察系统中哪些程序在使用网络，想知道是它们的即时网速是多少。这个时候可以使用nethogs来实现
在命令行输入

::

   nethogs

下面可以观察到浏览器网络流量最大

::

   PID     USER  PROGRAM                                       DEV         SENT        RECEIVED
   22596    pi    ..sr/lib/chromium-browser/chromium-browser   eth0        9.148       271.128 KB/sec
   22528   xrdp  /usr/sbin/xrdp                                eth0        792.582     8.918 KB/sec
     ?     root  192.168.2.168:59446-112.90.240.132:443                    0.331       0.895 KB/sec
     ?     root  192.168.2.168:59452-112.90.240.132:443                    0.297       0.194 KB/sec
   1266    pi    /home/pi/frp/frpc                             eth0        0.000       0.000 KB/sec
   22992    pi    sshd: pi@pts/2                               eth0        0.000       0.000 KB/sec
     ?     root  unknown TCP                                               0.000       0.000 KB/sec

   TOTAL                                                                   802.359     281.135 KB/sec
