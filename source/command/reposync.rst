*********************
reposync 
*********************

启动容器用于同步 ::

    docker run -itd --rm --name reposync -v /mnt/repo/:/mnt/repo/ centos8-reposync

centos8-reposync 是已经配置好软件源的centos8镜像


.. code-block:: shell

    reposync -p /mnt/repo --download-metadata --repo=epel

这样会在/mnt/repo/下面生成一个子目录epel


https://www.jianshu.com/p/6c3090968d71