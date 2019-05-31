linux挂在nfts移动硬盘
==========================
经常需要使用移动硬盘或者U盘拷贝软件，可能是格式化为ntfs格式，直接挂在会出错。可以通过额外的软件包ntfs-3G来支撑ntfs格式设备。

# 下载安装
```
wget https://www.tuxera.com/community/open-source-ntfs-3g/
./configure
make
make install # or 'sudo make install' if you aren't root
```

# 挂在移动硬盘
```
#找到为挂载的移动硬盘
lsblk

#挂载移动硬盘
mount -t ntfs-3g /dev/sda1 /mnt/windows
```

# 设置开启时自动挂载
```
vim /etc/fstab

# 后面添加
/dev/sda1 /mnt/windows ntfs-3g defaults 0 0
```