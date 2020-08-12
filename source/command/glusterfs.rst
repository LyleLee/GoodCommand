*******************
glusterfs
*******************

一种网络文件系统

性能优化方法 [#glusterfs_tunning]_
性能优化方法，优化小文件存储

.. code-block:: shell

    gluster volume set [VOLUME] [OPTION] [PARAMETER]
    gluster volume get performance.io-thread-count
    vi /etc/glusterfs/glusterfs.vol                     #或者在文件中配置。

.. [#glusterfs_tunning] https://www.jamescoyle.net/how-to/559-glusterfs-performance-tuning
.. [#gluster_tunning_event] https://access.redhat.com/documentation/en-us/red_hat_gluster_storage/3/html/administration_guide/small_file_performance_enhancements
