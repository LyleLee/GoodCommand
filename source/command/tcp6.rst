***************************
tcp6
***************************

为什么 :doc:`netstat` 只显示ipv6的监听， 实际上也可以通过ipv4访问？ [#chengweiyang]_

例如frps， 只设置了frps的ipv6监听端口， 实际上也可以通过过ipv4地址访问。

.. code-block:: console

    tcp6       0      0 :::22     :::*     LISTEN      3281/frps


.. [#chengweiyang] https://www.chengweiyang.cn/2017/03/05/why-netstat-not-showup-tcp4-socket/