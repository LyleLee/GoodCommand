nmap
======================
Network Mapper，开源的网络工具，用于网络探测和安全审计。可以扫描大规模网络

## 安装
```
sudo apt install nmap
```

## 扫描局域网
```
nmap -sP 192.168.1.*
```
出现如下结果，可以知道一共扫描了256个IP，有69个主机在线
```cs
Starting Nmap 7.60 ( https://nmap.org ) at 2019-04-03 14:26 CST
Nmap scan report for 192.168.1.1
Host is up (0.034s latency).
Nmap scan report for 192.168.1.4
Host is up (0.020s latency).
Nmap scan report for 192.168.1.6
Host is up (0.0060s latency).
Nmap scan report for 192.168.1.7
Host is up (0.083s latency).
Nmap scan report for 192.168.1.13
Host is up (0.0029s latency).
Nmap scan report for 192.168.1.40
Host is up (0.00024s latency).
Nmap scan report for 192.168.1.42
Host is up (0.00019s latency).
Nmap scan report for 192.168.1.44
Host is up (0.00013s latency).
Nmap scan report for 192.168.1.80
Host is up (0.00036s latency).
Nmap scan report for 192.168.1.81
Host is up (0.00034s latency).
Nmap scan report for test-network (192.168.1.83)
Host is up (0.00029s latency).
Nmap scan report for 192.168.1.84
Host is up (0.00027s latency).
Nmap scan report for ref-compute-1 (192.168.1.85)
Host is up (0.00016s latency).
Nmap scan report for 192.168.1.87
Host is up (0.00018s latency).
Nmap scan report for 192.168.1.90
Host is up (0.00016s latency).
Nmap scan report for test-compute-1 (192.168.1.94)
Host is up (0.00029s latency).
Nmap scan report for 192.168.1.95
......
Nmap done: 256 IP addresses (69 hosts up) scanned in 1.90 seconds
```

扫描某台主机打开的tcp端口，猜测主机OS版本
```cs
me@ubuntu:$ sudo nmap -O -sV 192.168.1.211
[sudo] password for me:

Starting Nmap 7.60 ( https://nmap.org ) at 2019-04-03 14:56 CST
Nmap scan report for ubuntu (192.168.1.201)
Host is up (0.000010s latency).
Not shown: 993 closed ports
PORT     STATE SERVICE       VERSION
22/tcp   open  ssh           OpenSSH 7.6p1 Ubuntu 4 (Ubuntu Linux; protocol 2.0)
25/tcp   open  smtp          Postfix smtpd
111/tcp  open  rpcbind       2-4 (RPC #100000)
139/tcp  open  netbios-ssn   Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp  open  netbios-ssn   Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
2049/tcp open  nfs_acl       3 (RPC #100227)
3389/tcp open  ms-wbt-server xrdp
Device type: general purpose
Running: Linux 3.X|4.X
OS CPE: cpe:/o:linux:linux_kernel:3 cpe:/o:linux:linux_kernel:4
OS details: Linux 3.8 - 4.9
Network Distance: 0 hops
Service Info: Host:  ubuntu; OS: Linux; CPE: cpe:/o:linux:linux_kernel

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 15.80 seconds
me@ubuntu:$
```
