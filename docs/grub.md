grub
===============================
如何设置启动选项

查看系统已有的开机启动项：
```CS
grep "^menuentry" /boot/efi/EFI/redhat/grub.cfg
# 需要以menuentry开头

$ sudo grub-set-default 0
上面这条语句将会持续有效，直到下一次修改；下面的命令则只有下一次启动的时候生效：

$ sudo grub-reboot 0
将下次选择的启动项设为默认
只需要在/etc/default/grub中添加这行

GRUB_SAVEDEFAULT=true
```
/boot/efi/EFI/redhat/grub.cfg  由grub2-mkconfig使用/etc/grub.d 下的模板和  /etc/default/grub中的配置创建

grub官方文档：
https://www.gnu.org/software/grub/manual/grub/grub.html#Introduction