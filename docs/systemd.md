systemd
============
系统启动服务器，通常，原来设置开机启动我们经常在init.d下放置启动脚本，主流的发行版逐渐使用systemd替代了这种方式。


### 配置文件路径
一个任务由一个.service文件表示，.service文件可以启动多个程序、脚本、命令作为任务的一部分。  
用户创建的.service任务，建议放置在：`/usr/lib/systemd/system/`  
系统创建的.service任务，防止在：`/lib/systemd/system/`  
文件防止到相应路径后，需要执行enable命令，这样systemd才开始加载任务，在重启时也会自动加载。
```
systemctl enable xxx.service
```
命令的作用是会在路径 `/etc/systemd/system`创建符号链接指向 `/lib/systemd/system/`中的.service文件，如：
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

或者由.service文件的install字段指定。例如在用户创建的re.service文件中有如下字段
```
[Install]
WantedBy=multi-user.target
```
则enable之后，会创建如下链接。
```
/etc/systemd/system/multi-user.target.wants/re.service → /usr/lib/systemd/system/re.service.
```

### 参考样例
假设这样一个需求，需要对服务器进行不断重启，以测试服务器500次重启会不会产生异常。  
为此我们编写一个脚本，还没有到500次的时候，就重启服务器。并把脚本做成.service文件。

restart_mission.sh如下：
```
counter_file="/home/cou.txt"
max_reboot_times=500
reboot_times=0

if [ ! -f "$counter_file" ]; then
        touch $counter_file
        echo 0 > $counter_file
else
        reboot_times=$(cat "$counter_file")
        if (($reboot_times < $max_reboot_times)); then
                nowdate=`date "+%Y-%m-%d %H:%M:%S"`
                echo "$nowdate $reboot_times again reboot"
                let reboot_times=$reboot_times+1
                echo $reboot_times > $counter_file
                wait
                /bin/sleep 30
                /sbin/reboot
        fi
fi
```
脚本中使用文件保存了计数，设置sleep的原因是给机会停住脚本。

re.service如下：
```
[Unit]
Description=restart_mission

[Service]
Type=oneshot
ExecStart=/root/restart_mission.sh
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```
ExecStart指定了执行的脚本。

### 安装执行
```
cp re.service /usr/lib/systemd/system/frpc.service
systemctl enable re.service
```
如果中途修改了文件，
```
systemctl daemon-reload
```
这样系统就会不断重启了。
