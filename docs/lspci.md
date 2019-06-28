lspci
================
lspci 查看pci设备

```
lspci -tv		#树状显示pci设备
lspci -vvv		#显示pci设备的详细信息
lspci -s 0002:e8:00.0 -vvv	#显示某个PCI设备的详细信息
```

删除pci设备并重新加载
```
echo 1 > /sys/bus/pci/devices/000c:21:00.0/remove 	#移除网卡设备网卡设备
echo 1 > /sys/bus/pci/devices/000c:20:00.0/rescan	#在hostbridge下重新rescan可以再次找到设备
echo 1 > /sys/bus/pci/rescan						#在pci下面也可以直接scan
```

