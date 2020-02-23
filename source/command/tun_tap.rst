*************************
tun/tap
*************************




参考资料

tun tap 解释出处
https://www.fir3net.com/Networking/Terms-and-Concepts/virtual-networking-devices-tun-tap-and-veth-pairs-explained.html

+ tun是一个三层设备， 通过/dev/tunX 收发IP数据包
+ tap是一个二层设备， 通过/dev/tap 收发二层数据包，可以与物理网卡bridge
+ macvlan 实现一个网卡绑定多个mac地址，进而对应多个IP
+ mactap 是对macvlan的改进， macvlan会把数据交给网络协议栈， mactap把数据交给tapX

https://blog.kghost.info/2013/03/27/linux-network-tun/

+ 创建tun设备的示例程序
https://blog.csdn.net/sld880311/article/details/77854651


https://www.lijiaocn.com/%E6%8A%80%E5%B7%A7/2017/03/31/linux-net-devices.html#tun%E8%AE%BE%E5%A4%87%E5%88%9B%E5%BB%BA