firewall
=====================
CentOS和redhat使用firewall作为防火墙
```CS
systemctl status firewalld.service #查看防火墙服务运行状态，systemctl 也可以用来启动关闭，重启防火墙
firewall-cmd --state               #查看防火墙是否在运行
firewall-cmd --get-log-denied      #查看防火墙是否记录已拒绝的数据包
firewall-cmd --set-log-denied=all  #记录所有拒绝的请求， 设置之后可以在/var/log/messages看到所拒绝的请求log
```
由于命令行可能不熟悉，可以使用图形界面进行设置。
```
firewall-config
```

封锁一个IP
```
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='192.168.1.1' reject"
```
封锁一个IP段
```
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='192.168.1.0/24' reject"
```
添加一条rich rule
```
sudo firewall-cmd --zone=public --add-rich-rule="rule family="ipv4" source address="198.51.100.0/32" port protocol="tcp" port="10000" log prefix="test-firewalld-log" level="info" accept"
firewall-cmd --add-rich-rule='rule family="ipv4" source address="139.159.243.11" destination address="192.168.100.12" protocol value="tcp" log prefix="upnpc" level="warning" accept'
```

# 防火墙开放80端口防火墙。
开放前，发起80端口的http请求会失败
```
me@ubuntu:~$ curl -X GET http://192.168.1.112/
curl: (7) Failed to connect to 192.168.1.112 port 80: No route to host
me@ubuntu:~$
```
可以观察/var/log/messages可以看到拒绝日志
```
Jun  7 23:29:25 localhost kernel: FINAL_REJECT: IN=enahisic2i0 OUT= MAC=c0:a8:02:ba:00:04:c0:a8:02:81:00:04:08:00 SRC=192.168.1.201 DST=192.168.1.112 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=26463 DF PROTO=TCP SPT=47840 DPT=80 WINDOW=29200 RES=0x00 SYN URGP=0
Jun  7 23:29:26 localhost kernel: FINAL_REJECT: IN=enahisic2i0 OUT= MAC=c0:a8:02:ba:00:04:c0:a8:02:81:00:04:08:00 SRC=192.168.1.201 DST=192.168.1.112 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=54899 DF PROTO=TCP SPT=47842 DPT=80 WINDOW=29200 RES=0x00 SYN URGP=0
```

防火墙允许80端口接收请求
```
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload       #重要， 否则不起作用，在firewall-cmd --list-all也无法看到
```
开放后：
```
me@ubuntu:~$ curl -X GET http://192.168.1.112/
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
        <head>
                <title>Test Page for the Apache HTTP Server on Red Hat Enterprise Linux</title>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                <style type="text/css">
                        /*<![CDATA[*/
                        body {
                                background-color: #fff;
                                color: #000;
                                font-size: 0.9em;
                                font-family: sans-serif,helvetica;
                                margin: 0;
                                padding: 0;

```
