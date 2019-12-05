*********************
arping
*********************

发送ARP请求数据包

.. code-block:: console

    [user1@centos ~]$ arping -I enp189s0f0 -c 3 192.168.1.002
    ARPING 192.168.1.002 from 192.168.1.122 enp189s0f0
    Unicast reply from 192.168.1.002 [C0:A8:02:81:00:04]  0.611ms
    Unicast reply from 192.168.1.002 [C0:A8:02:81:00:04]  0.607ms
    Unicast reply from 192.168.1.002 [C0:A8:02:81:00:04]  0.594ms
    Sent 3 probes (1 broadcast(s))
    Received 3 response(s)
