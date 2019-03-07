wget linux下载工具
======================
wget是一个linux系统普遍提供的一个下载工具。常用于在命令行下载文件。  

使用方法：
```shell
wget url
```
```shell
wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c
```
使用代理：
处于内网环境，需要使用代理：
```shell-session
wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c -e "https_proxy=https://用户名:密码@代理服务器:端口" --no-check-certificate
```
例如：用户名是sam，密码是pc_123,代理服务器是10.10.98.1，端口是8080
```shell-session
wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c -e "https_proxy=https://sam:pc_123@10.10.98.1:8080" --no-check-certificate
```
>
户密码带有特殊字符时，需要使用百分号编码替代，例如密码是tom@7642，应该写成tom%407642,更多字符替换请参考[维基百科](https://zh.wikipedia.org/wiki/%E7%99%BE%E5%88%86%E5%8F%B7%E7%BC%96%E7%A0%81)  
代理服务器可以是一个域名。例如：proxy.tunnel.com。
