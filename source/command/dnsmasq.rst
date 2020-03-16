***************
dnsmasq
***************

是一个dns服务器和dhcp服务器


.. code-block:: shell

    apt install dnsmasq
    sudo vim /etc/dnsmasq.conf
    sudo systemctl start dnsmasq

.. code-block:: ini
    :caption: 我只修改/etc/dnsmasq.conf默认监听端口和为百度指明特定dns服务器

    # Listen on this specific port instead of the standard DNS port
    # (53). Setting this to zero completely disables DNS function,
    # leaving only DHCP and/or TFTP.
    port=5353


    #server=/localnet/192.168.0.1
    server=/www.baidu.com/114.114.114.114

    #如果需要指定上有服务器的端口
    server=100.100.1.1#5353

    #记录dns请求日志，并且保存到文件
    log-queries
    log-facility=/tmp/dnsmasq.log


.. [#hilinux] https://www.hi-linux.com/posts/30947.html

