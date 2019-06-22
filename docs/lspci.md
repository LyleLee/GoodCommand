lspci
================
lspci 查看pci设备

```
lspci -tv		#树状显示pci设备
lspci -vvv		#显示pci设备的详细信息
lspci -s 0002:e8:00.0 -vvv	#显示某个PCI设备的详细信息
```