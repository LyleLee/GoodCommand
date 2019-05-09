grub
===============================
如何设置启动选项



RedHat设置以选择的启动项作为下次的默认启动项. 需要设置这两项
```
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
```

完整的grub配置为
```
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=rhel/root rd.lvm.lv=rhel/swap rhgg
b quiet console=ttyAMA0,115200"
GRUB_DISABLE_RECOVERY="true"
```
grub2-mkconfig 使用/etc/grub.d下的模板和/etc/default/grub配置创建/boot/efi/EFI/redhat/grub.cfg，所以设置完之后执行命令， 使用生成的grub.cfg替换掉原来的grub.cfg
```
grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
```


查看系统已有的开机启动项：
```CS
grep "^menuentry" /boot/efi/EFI/redhat/grub.cfg
# 需要以menuentry开头

$ sudo grub-set-default 0
上面这条语句将会持续有效，直到下一次修改；下面的命令则只有下一次启动的时候生效：

$ sudo grub-reboot 0
将下次选择的启动项设为默认
```


grub官方文档：
https://www.gnu.org/software/grub/manual/grub/grub.html#Introduction