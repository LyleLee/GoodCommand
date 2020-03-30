***********************
ceph 优化
***********************


修改bluestore_cache_size_ssd翻倍
-----------------------------------

.. code-block:: console

    [root@ceph1 ceph]# ceph --show-config | grep ssd
    bluestore_cache_size_ssd = 3221225472


.. code-block:: ini

    [osd]
    bluestore_cache_size_ssd = 6442450944


osd绑核
----------------------------------

每个ceph节点上，一个OSD进程绑两个核


MD绑核
----------------------------------

每个ceph节点上， 一个MDS进程一个核，固定未40核



修改SSD调度模式
----------------------------------

在此处修改固态盘调度模式为none

.. code-block:: shell

    for f in `ls -d /sys/block/sd[v-y]`;do echo none > $f/queue/scheduler;done


清除缓存
---------------------------------

.. code-block:: shell

    echo 3 > /proc/sys/vm/drop_caches

PG 均衡未知
--------------

其中一个办法是使用umap [#ceph_forum]_


问题记录
----------------------

1. 在预热过程中发现， 预热一段时间后， SSD的读带宽无法无法上去， 一直停留在200MB/s的水平， svctm（服务时间）超过2ms，通常情况下是小于1ms。 在一次测试中发现和测试结果无关，带有读操作之后，服务时间恢复正常的零点几毫秒。



.. [#ceph_forum] `华为cloud论坛上的鲲鹏优化讨论 <https://bbs.huaweicloud.com/forum/thread-26303-1-1.html>`