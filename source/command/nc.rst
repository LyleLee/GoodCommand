*************************
nc
*************************

使用nc测试端口TCP可用情况

TCP服务端 ::

    nc -l 5000      #监听5000端口
    nc -k -l 5000   #有客户端接入后不断开

TCP客户端 ::

    # nc -v  192.168.10.12 5000     #输入文字可以再服务端看到

    Example of successful connection:
    # nc -z -v 192.168.10.12 22
    Connection to 192.118.20.95 22 port [tcp/ssh] succeeded!
    Example of unsuccessful connection:

    # nc -z -v 192.168.10.12 22
    nc: connect to 192.118.20.95 port 22 (tcp) failed: No route to host

    Example of successful connection:

    # nc -z -v -u 192.168.10.12 123
    Connection to 192.118.20.95 123 port [udp/ntp] succeeded!


UDP服务端 ::

    nc -u -l 7778

UDP客户端 ::

    nc -u 192.168.1.201 7778