CentOS Pakages
===================
设置CentOS软件源

# 本地软件源设置和redhat相同
请参考：[[redhat 软件源设置]](redhat_package.md)

# 在线源

直接下载到本地即可
```
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.huaweicloud.com/repository/conf/CentOS-7-anon.repo
```
# 直接下载CentOS源配置文件到本地

前面的下载方式下载到的不是alt-aarch64这里提供一份下载[[CentOS7.6repo]](resources/CentOS7.6repo/CentOS-Base.repo)

# 配置epel源
方法1：参考[Redhat的配置](redhat_package.md)
方法2：CentOS的本地源或者在线源配置好之后，就可以直接安装epel源：
```
yum install epel-release
```

## 问题解决
如果出现repodata/repomd.xml Error 404
```
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * epel: fedora.cs.nctu.edu.tw
https://mirrors.huaweicloud.com/centos/7/os/aarch64/repodata/repomd.xml: [Errno 14] HTTPS Error 404 - Not Found
Trying other mirror.
To address this issue please refer to the below wiki article

https://wiki.centos.org/yum-errors

If above article doesn't help to resolve this issue please use https://bugs.centos.org/.

https://mirrors.huaweicloud.com/centos/7/extras/aarch64/repodata/repomd.xml: [Errno 14] HTTPS Error 404 - Not Found
Trying other mirror.
https://mirrors.huaweicloud.com/centos/7/updates/aarch64/repodata/repomd.xml: [Errno 14] HTTPS Error 404 - Not Found
```
解决办法修改CentOS-Base.repo, baseurl中的$releasever替换为7，centos替换为centos-altarch
```
baseurl=https://mirrors.huaweicloud.com/centos/$releasever/os/$basearch/
修改为：
baseurl=https://mirrors.huaweicloud.com/centos-altarch/7/updates/$basearch/
```

