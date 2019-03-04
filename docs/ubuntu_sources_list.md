ubuntu 软件源配置
===========================
这里以18.04.1 LTS (Bionic Beaver)为例介绍软件源的配置。配置国内软件源，可以在安装/更新软件的时候获得更快的速度。

## 备份软件源
自带的软件源一般是美国的地址，但是书写规范，在实在没有办法的时候可以恢复成默认的源，慢一点但是可用。
```
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
```

## 使用华为镜像站。
镜像站地址是：[https://mirrors.huaweicloud.com/](https://mirrors.huaweicloud.com/)上面有各种开源软件的下载地址。  
替换sources.list当中的url为华为镜像站的url。本人使用ARM平台，所以使用ubuntu-ports的镜像地址。  
例如：

```
deb http://us.ports.ubuntu.com/ubuntu-ports/ bionic main restricted
deb http://ports.ubuntu.com/ubuntu-ports bionic-security main restricted
```
替换为
```
deb https://mirrors.huaweicloud.com/ubuntu-ports/ bionic main restricted
deb https://mirrors.huaweicloud.com/ubuntu-ports/ bionic-security main restricted
```
可以使用命令行替换
```shell-session
sed -i "s@http://us.ports.ubuntu.com/ubuntu-ports/@https://mirrors.huaweicloud.com/ubuntu-ports/@g" /etc/apt/sources.list
sed -i "s@http://ports.ubuntu.com/ubuntu-ports@https://mirrors.huaweicloud.com/ubuntu-ports/@g" /etc/apt/sources.list
```
这里有一份完成文件：[sources.list](resources/sources.list)
## 执行更新
```shell-session
sudo apt update
```
出现类似输出证明软件源配置成功
```shell-session
root@ubuntu:~# apt update
Get:1 https://mirrors.huaweicloud.com/ubuntu-ports bionic InRelease [242 kB]
Get:2 https://mirrors.huaweicloud.com/ubuntu-ports bionic-updates InRelease [88.7 kB]
Get:3 https://mirrors.huaweicloud.com/ubuntu-ports bionic-backports InRelease [74.6 kB]
Get:4 https://mirrors.huaweicloud.com/ubuntu-ports bionic-security InRelease [88.7 kB]
Get:5 https://mirrors.huaweicloud.com/ubuntu-ports bionic/main arm64 Packages [975 kB]
Get:6 https://mirrors.huaweicloud.com/ubuntu-ports bionic/main Translation-en [516 kB]
Get:7 https://mirrors.huaweicloud.com/ubuntu-ports bionic/restricted arm64 Packages [664 B]
Get:8 https://mirrors.huaweicloud.com/ubuntu-ports bionic/restricted Translation-en [3,584 B]
Get:9 https://mirrors.huaweicloud.com/ubuntu-ports bionic/universe arm64 Packages [8,316 kB]
```
