UPnP
======================
路由器界面上的介绍：开启 UPnP （Universal Plug and Play，通用即插即用）功能后，局域网中的计算机可以请求路由器自动进行端口转换。这样，互联网上的计算机就能在需要时访问局域网计算机上的资源（如 MSN Messenger 或迅雷、BT、PPTV 等支持 UPnP 协议的应用程序），让您在观看在线视频或使用多点下载等方面的软件时，享受更加稳定的网络。  
我使用UPnP来请求路由器为程序映射指定端口。  

使用工具时miniupnpc
```
yum install miniupnpc
```
使用时注意关闭防火墙，否则可能会出现upnpc被防火墙拦截。例如：
```
Jul 29 16:11:18 hadoop00 kernel: FINAL_REJECT: IN=enp125s0f0 OUT= MAC=f4:79:60:92:7c:82:c8:c2:fa:40:c1:e6:08:00 SRC=192.168.100.1 DST=192.168.100.12 LEN=420 TOS=0x00
 PREC=0x00 TTL=64 ID=56876 DF PROTO=UDP SPT=1900 DPT=41797 LEN=400
```
解决办法：  
方法一： 禁用防火墙
```
systemctl stop firewalld
```
方法二：添加一条规则，主机192.168.100.12接收网关192.168.100.1发送UDP数据。
```
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='192.168.100.1' destination address='192.168.100.12' protocol value='udp' log prefix='upnpc' level='warning' accept
```

添加一条转发规则：
```
upnpc -a 192.168.1.2 22 3333 TCP    #来自互联网的TCP链接会被转发到192.168.1.2的22号端口上。
upnpc -d 3333 TCP                   #删除这条规则
upnpc -l                            #显示网关路由器
upnpc -u http://192.168.100.1:37215/aceb1e42-5f94-3a9d-c107-53e4485f6b1a/upnpdev.xml -l #查询指定网关上的
```




## 被防火墙拦截的现象
```
[root@hadoop00 ~]# upnpc -l
upnpc : miniupnpc library test client, version 2.0.
 (c) 2005-2016 Thomas Bernard.
Go to http://miniupnp.free.fr/ or http://miniupnp.tuxfamily.org/
for more information.
No IGD UPnP Device found on the network !
[root@hadoop00 ~]#
[root@hadoop00 ~]#
[root@hadoop00 ~]#
[root@hadoop00 ~]# systemctl stop firewalld
[root@hadoop00 ~]# upnpc -l
upnpc : miniupnpc library test client, version 2.0.
 (c) 2005-2016 Thomas Bernard.
Go to http://miniupnp.free.fr/ or http://miniupnp.tuxfamily.org/
for more information.
List of UPNP devices found on the network :
 desc: http://192.168.100.1:37215/aceb1e42-5f94-3a9d-c107-53e4485f6b1a/upnpdev.xml
 st: urn:schemas-upnp-org:device:InternetGatewayDevice:1

Found valid IGD : http://192.168.100.1:37215/ctrlu/1baf2dc8-0d18-6d80-6050-bb858de4d14c/WANIPConn_1
Local LAN ip address : 192.168.100.12
Connection Type : IP_Routed
Status : Connected, uptime=974546s, LastConnectionError :
  Time started : Thu Jul 18 03:13:37 2019
MaxBitRateDown : 100000000 bps (100.0 Mbps)   MaxBitRateUp 100000000 bps (100.0 Mbps)
ExternalIPAddress = 124.127.117.242
 i protocol exPort->inAddr:inPort description remoteHost leaseTime
GetGenericPortMappingEntry() returned 713 (SpecifiedArrayIndexInvalid)
```