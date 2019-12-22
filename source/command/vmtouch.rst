*********************
vmtouch
*********************

把一些文件加载的内存buffer

.. code-block:: shell
    
    vmtouch -tv files




缓存cephfs文件

.. code-block:: shell

    for i in {1..25}; do
        ./vmtouch -tv /mnt/cephfs/vdb.1_$i.dir
    done



    for i in {26..50}; do
        ./vmtouch -tv /mnt/cephfs/vdb.1_$i.dir
    done




    for i in {51..75}; do
        ./vmtouch -tv /mnt/cephfs/vdb.1_$i.dir
    done



    for i in {76..100}; do
        ./vmtouch -tv /mnt/cephfs/vdb.1_$i.dir
    done
