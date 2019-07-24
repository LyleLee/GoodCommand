hostnamectl
=======================
修改设置系统的hostname
```
hostnamectl --static set-hostname ceph1
```
查看hostname，设置hostname，重新登陆生效。
```shell-session
[root@localhost home]# hostnamectl
   Static hostname: localhost.localdomain
         Icon name: computer-server
           Chassis: server
        Machine ID: b4dddad914c64fe7a35349040093ae45
           Boot ID: 58dff55183954147b79a39d4273f8c54
  Operating System: Red Hat Enterprise Linux 8.0 Beta (Ootpa)
       CPE OS Name: cpe:/o:redhat:enterprise_linux:8.0:beta
            Kernel: Linux 4.18.0-68.el8.aarch64
      Architecture: arm64

[root@localhost home]# hostnamectl set-hostname redhat80
[root@localhost home]# exit

[root@redhat80 ~]# hostnamectl
   Static hostname: redhat80
         Icon name: computer-server
           Chassis: server
        Machine ID: b4dddad914c64fe7a35349040093ae45
           Boot ID: 58dff55183954147b79a39d4273f8c54
  Operating System: Red Hat Enterprise Linux 8.0 Beta (Ootpa)
       CPE OS Name: cpe:/o:redhat:enterprise_linux:8.0:beta
            Kernel: Linux 4.18.0-68.el8.aarch64
      Architecture: arm64
[root@redhat80 ~]#
```