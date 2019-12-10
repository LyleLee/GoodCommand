************************
pssh
************************

常用命令如下

.. code-block:: shell

    pssh -i -h client_hosts.txt "cat /sys/class/net/bond0/mtu"
    pssh -h hosts.txt -A -l ben -P -I<./uptime.sh


-i            指的是把每一个远程主机的输出合并后输出 对应 ``-P`` 参数
-P            远程主机有输出时马上打印
-A            提示输入密码
-h            指定主机列表文件
-l            指定用户名
-I            读取标准输入


client_hosts.txt的格式如下

.. code-block:: console

    root@client1:22
    root@client2:22
    root@client3:22
    root@client4:22

其它常用选项：
    
