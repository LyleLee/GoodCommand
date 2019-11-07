lustre
=================
编译安装lustre


### taishan-arm-cpu08上的安装过程

```
[root@taishan-arm-cpu08 ~]# history
    1  vi /etc/sysconfig/network-scripts/ifcfg-enp189s0f0
    2  vi /etc/hostname
    3  vi /etc/selinux/config
    4  systemctl disable firewalld
    5  reboot
    6  getenforce
    7  systemctl disable firewalld
    8  systemctl stop firewalld
    9  systemctl status firewalld
   10  exit
   11  ./arm_install.sh
   12   yum install ntpdate -y
   13  /usr/sbin/ntpdate 192.168.6.30
   14  exit
   15  cd kernel/
   16  yum localinstall ./*
   17  grub2-editenv list
   18  reboot
   19  ping 192.168.6.30
   20  mount /root/CentOS-7-aarch64-Everything-1810.iso /var/ftp/pub/
   21  yum install lsof gtk2 atk cairo tcl tcsh tk -y
   22  rpm -e chess-monitor-gmond-python-modules
   23  tar xf MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext.tgz
   24  cd MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext
   25  ./mlnxofedinstall
   26  reboot
   27  cat  > /etc/sysconfig/network-scripts/ifcfg-ib0 << EOF
   28  TYPE=InfiniBand
   29  BOOTPROTO=none
   30  NAME=ib0
   31  UUID=04237ab5-2ac9-4ca0-90ae-15ac3cbe09e5
   32  DEVICE=ib0
   33  ONBOOT=yes
   34  IPADDR=192.168.11.20
   35  NETMASK=255.255.255.0
   36  EOF
   37   vi /etc/sysconfig/network-scripts/ifcfg-ib0
   38  systemctl restart network
   39  exit
   40  rpm -ivh libaec-1.0.4-1.el7.aarch64.rpm  munge-libs-0.5.11-3.el7.aarch64.rpm hdf5-1.8.12-11.el7.aarch64.rpm
   41  yum install munge -y
   42  df -h
   43  mount /root/CentOS-7-aarch64-Everything-1810.iso /var/ftp/pub/
   44  yum install munge -y
   45   yum install slurm-slurmd slurm slurm-pam_slurm slurm-contribs slurm-perlapi -y
   46  exit
   47  rpm -qa|grep kernnel
   48  rpm -qa|grep kernel
   49  exit
   50  rpm -ivh  munge-libs-0.5.11-3.el7.aarch64.rpm hdf5-1.8.12-11.el7.aarch64.rpm  libaec-1.0.4-1.el7.aarch64.rpm
   51  mount /root/CentOS-7-aarch64-Everything-1810.iso /var/ftp/pub/
   52  exit
   53  rpm -ivh  munge-libs-0.5.11-3.el7.aarch64.rpm hdf5-1.8.12-11.el7.aarch64.rpm  libaec-1.0.4-1.el7.aarch64.rpm
   54  df -h
   55  exit
   56  cd MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext
   57  ./uninstall.sh
   58   rpm -e chess-monitor-gmond-python-modules-5.3.0-release.el7.aarch64
   59  ./uninstall.sh
   60  rpm -e kernel-debuginfo-4.14.0-115.el7a.aarch64 kernel-debuginfo-common-aarch64-4.14.0-115.el7a.aarch64 kernel-4.14.0-115.el7a.aarch64 kernel-devel-4.14.0-115.el7a.aarch64
   61  tar xf MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext.tgz && cd MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6alternate-aarch64-ext && ./mlnxofedinstall
   62   reboot
   63  ip a
   64  cd lustre-arm/ &&  rpm -ivh --nodeps kmod-lustre-client-2.12.2-1.el7.aarch64.rpm  lustre-client-2.12.2-1.el7.aarch64.rpm lustre-iokit-2.12.2-1.el7.aarch64.rpm  lustre-client-debuginfo-2.12.2-1.el7.aarch64.rpm
   65   lustre_rmmod
   66  cat  >  /etc/modprobe.d/lnet.conf  << EOF
   67  options lnet networks="o2ib0(ib0)"
   68  EOF
   69  modprobe lustre && modprobe lnet
   70  lctl network up
   71  lctl ping 192.168.11.21@o2ib0
   72  umount /home/
   73  mount.lustre 192.168.11.21@o2ib0:192.168.11.22@o2ib0:/lustre /home/
   74  exit
   75  vi /etc/sysconfig/network-scripts/ifcfg-enp189s0f0
   76  systemctl restart network
   77   mount -a
   78  df -h
   79  yum -y install bison  cppunit-devel flex git gsl-devel htop  libffi-devel log4cxx-devel  openblas-devel  openssl-devel   patch readline-devel svn  xerces-c-devel
   80  exit
   81  cpupower frequency-set -g performance
   82  exit
   83  vi /etc/rc.local
   84  reboot
   85   rpm --import /etc/pki/rpm-gpg/*
   86   yum install -y epel-release iotop tmux htop perf iostat dstat netstat tree nload
   87  yum install -y epel-release iotop tmux htop perf iostat dstat netstat tree nload
   88  yum -y install wget
   89   wget http://mirrors.sohu.com/fedora-epel/epel-release-latest-7.noarch.rpm
   90  rpm -ivh epel-release-latest-7.noarch.rpm
   91  rpm --import /etc/pki/rpm-gpg/*
   92  yum install -y epel-release wget iotop tmux htop perf sysstat dstat net-tools tree nload
   93  visudo
   94  exit
   95  history | grep configure
   96  history
[root@taishan-arm-cpu08 ~]#

```


下面是我所用的一个名为8021q.modules的脚本，用来在我的CentOS 5.3中自动加载802.1Q模块：

```
#! /bin/sh

/sbin/modinfo -F filename 8021q > /dev/null 2>&1
if [ $? -eq 0 ]; then
    /sbin/modprobe 8021q
fi
``` 