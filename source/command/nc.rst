*************************
nc
*************************

使用nc测试端口可用性

.. code-block:: shell

    nc -l 5000      #监听5000端口
    nc -k -l 5000   #有客户端接入后不断开

.. code-block:: console

    Example of successful connection:
    # nc -z -v 192.168.10.12 22
    Connection to 192.118.20.95 22 port [tcp/ssh] succeeded!
    Example of unsuccessful connection:

    # nc -z -v 192.168.10.12 22
    nc: connect to 192.118.20.95 port 22 (tcp) failed: No route to host

    Example of successful connection:

    # nc -z -v -u 192.168.10.12 123
    Connection to 192.118.20.95 123 port [udp/ntp] succeeded!