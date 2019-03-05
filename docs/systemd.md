systemd
============
系统启动服务器，通常，原来设置开机启动我们经常在init.d下放置启动脚本，主流的发行版逐渐使用systemd替代了这种方式。


### 配置文件路径
通常一个服务由一个.service文件指示，路径放置在：`/lib/systemd/system/`  
由用户创建的.service文件，路径放置在：`/usr/lib/systemd/system/frpc.service`  
执行命令，设置开机启动
```
systemctl enable xxx.service
```
会在路径 `/etc/systemd/system`创建符号链接指向 `/lib/systemd/system/`中的.service文件，如：
```
me@ubuntu:/etc/systemd/system$ tree --charset ascii
.
|-- dbus-org.freedesktop.resolve1.service -> /lib/systemd/system/systemd-resolved.service
|-- default.target.wants
|   `-- ureadahead.service -> /lib/systemd/system/ureadahead.service
|-- emergency.target.wants
|   `-- friendly-recovery.service -> /lib/systemd/system/friendly-recovery.service
|-- final.target.wants
|   `-- snapd.system-shutdown.service -> /lib/systemd/system/snapd.system-shutdown.service
|-- getty.target.wants
|   `-- getty@tty1.service -> /lib/systemd/system/getty@.service
|-- graphical.target.wants
|   `-- accounts-daemon.service -> /lib/systemd/system/accounts-daemon.service
|-- iscsi.service -> /lib/systemd/system/open-iscsi.service
|-- libvirt-bin.service -> /lib/systemd/system/libvirtd.service
|-- multi-user.target.wants
|   |-- atd.service -> /lib/systemd/system/atd.service
|   |-- bind9.service -> /lib/systemd/system/bind9.service
|   |-- console-setup.service -> /lib/systemd/system/console-setup.service
|   |-- cron.service -> /lib/systemd/system/cron.service
|   |-- ebtables.service -> /lib/systemd/system/ebtables.service
|   |-- irqbalance.service -> /lib/systemd/system/irqbalance.service
|   |-- libvirtd.service -> /lib/systemd/system/libvirtd.service
|   |-- libvirt-guests.service -> /lib/systemd/system/libvirt-guests.service
|   |-- lxcfs.service -> /lib/systemd/system/lxcfs.service
```

### 服务迟执行
在service文件中添加ExecStartPre字段内容调用bash的sleep命令
```config
[Service]
ExecStartPre=/bin/sleep 30
```