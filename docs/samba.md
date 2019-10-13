samba
======================
win10无法发现samba参考

```
今天遇到了同样的问题，查了很久资料，试了几种方法。
最后通过改注册表的方法解决了

参考文章：https://www.getnas.com/2015/11/2090.html

方法
注册表定位到
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters
右边新建 → DWORD (32位) 值，新建项命名为 AllowInsecureGuestAuth ，将该项的值设置为 1。

实测改完后正常访问，可以无密码访问，win10可以微软账户，也可以pin，都不影响
```