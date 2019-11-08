iperf
**********************

网络吞吐量测试

测试TCP带宽
===========

.. code::

   # 服务器
   iperf -s                #默认是TCP
   # 客户端
   iperf -c 192.168.1.166 

测试UDP带宽
===========

.. code::

   # 服务器
   iperf -u -s             #如果不设置-u选项，服务器默认是tcp，会出现read failed: Connection refused
   # 客户端
   iperf -u -c 192.168.1.166 
