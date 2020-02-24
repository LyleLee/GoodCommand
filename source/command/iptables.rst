****************************
iptables
****************************

iptables 是管理防火墙规则的工具，由iptables管理的规则会下发到netfiter进行应用。

.. code-block:: shell

    iptables -L INPUT           #查看INPUT链的规则
    iptables -L FORWARD
    iptables -L OUTPUT
    iptables -L
    iptables -t filter -L
    iptables -t raw -L
    iptables -t security -L
    iptables -t mangle -L
    iptables -t nat -L -n -v    #查看nat表的规则， -v带数据包统计

    iptables -S                 #查看添加的iptables规则
    ufw status                  #查看防火墙规则
    iptables -S                 #To list all IPv4 rules
    ip6tables -S                #To list all IPv6 rules
    iptables -L INPUT -v -n     #To list all rules for INPUT tables
    iptables -S INPUT           #To list all rules for INPUT tables

iptables和ufw的关系
=================================

ufw是ubuntu的防火墙工具 :doc: `ufw`

ufw的设置会转变为iptables规则， iptables的规则ufw并不会管理。

执行ufw命令

.. code-block:: shell

    ufw allow 22/tcp

查看添加的iptables规则

.. code-block:: shell

    iptables -S

.. code-block:: shell

    -A ufw-user-input -p tcp -m tcp --dport 22 -j ACCEPT

执行ufw命令

.. code-block:: shell

    ufw allow 2222

查看iptables规则，端口2222的tcp和udp流量会被允许

.. code-block:: shell

    -A ufw-user-input -p tcp -m tcp --dport 2222 -j ACCEPT
    -A ufw-user-input -p udp -m udp --dport 2222 -j ACCEPT

反过来，手动添加iptables规则，并不会影响ufw

.. code-block:: shell

    -A ufw-user-input -p tcp -m tcp --dport 3333 -j ACCEPT
    -A ufw-user-input -p udp -m udp --dport 3333 -j ACCEPT


    root@server:~/play_iptables# iptables -A ufw-user-input -p tcp -m tcp --dport 3333 -j ACCEPT
    root@server:~/play_iptables#
    root@server:~/play_iptables# ufw status
    Status: active

    To                         Action      From
    --                         ------      ----
    22/tcp                     ALLOW       Anywhere
    2222                       ALLOW       Anywhere
    33222                      ALLOW       Anywhere
    33000                      ALLOW       Anywhere
    22/tcp (v6)                ALLOW       Anywhere (v6)
    2222 (v6)                  ALLOW       Anywhere (v6)


执行成功，



iptables -A ufw-user-input -p tcp -m tcp --dport 3333 -j ACCEPT



NAT转换, 注意，这两条规则在CentOS上，``firewall-cmd --reload`` 的 时候会失效

.. code-block:: console

    iptables -t nat -A PREROUTING -p tcp --dport 3212 -j DNAT --to-destination 10.1.1.1:312
    iptables -t nat -A POSTROUTING -p tcp -d 10.1.1.1 -j SNAT --to-source 10.1.1.5

    firewall-cmd --zone=public --add-masquerade --permanent #目前需要添加这条才能工作，原因未知。

.. Nat 设置 https://www.cnblogs.com/Cherry-Linux/p/9369012.html
.. iptables 四表五链 https://liqiang.io/post/dive-in-iptables
.. 如何重置iptables https://kerneltalks.com/virtualization/how-to-reset-iptables-to-default-settings/
