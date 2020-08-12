********************
calico
********************


::

    [root@master1 ~]# ./calicoctl-linux-arm64 node status
    Calico process is running.

    IPv4 BGP status
    +-----------------+-------------------+-------+----------+-------------+
    |  PEER ADDRESS   |     PEER TYPE     | STATE |  SINCE   |    INFO     |
    +-----------------+-------------------+-------+----------+-------------+
    | 192.168.122.103 | node-to-node mesh | up    | 01:38:37 | Established |
    | 192.168.122.104 | node-to-node mesh | up    | 01:39:00 | Established |
    +-----------------+-------------------+-------+----------+-------------+

    IPv6 BGP status
    No IPv6 peers found.

    [root@master1 ~]#
