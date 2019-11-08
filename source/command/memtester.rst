memtester
**********************

内存压力测试工具

安装
====

.. code::

   wget http://pyropus.ca/software/memtester/old-versions/memtester-4.3.0.tar.gz
   make
   #如果需要安装
   make install

使用
====

.. code::

   #无限次数循环测试
   ./memtester 10G
   #测试两次
   ./memtester 10G 2
