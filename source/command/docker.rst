**************
docker
**************

操作系统级别的虚拟化技术，用于实现应用的快速自动化部署。 [#docker-doc]_

docker安装
==============
按照官网提供的安装办法，在centos上 [#docker_install]_

.. code-block:: shell

    # Use the following command to set up the stable repository.
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install containerd.io docker-ce docker-ce-cli
    sudo systemctl start docker
    sudo docker run hello-world

docker service文件的地址是： /usr/lib/systemd/system/docker.service


docker常用命令
==============

完整的文档在 docker run reference [#docker_run_reference]_

.. code-block:: shell

   docker run -it ubuntu bash  #前台运行容器并且进入， 只有一个进程bash
   exit                        #退出bash， 容器停止运行。 可以使用如下命令
   ctrl + p + q                #退出容器，bash不退出， 容器继续运行

   docker exec -it 35dfs bash  #进入已经在运行程序，启动一个bash进程，这个时候系统一共有两个bash
   exit                        #退出bash，因为还有一个bash已经在运行，所以容器不会停止运行。

   sudo usermod -a -G docker user1     #把user1添加到docker组中， 这样就可以执行docker命令时不需要sudo了。docker以root权限运行
   sudo systemctl enable docker        #开机自启动
   docker start {ID}                   #重新启动停止的容器

   docker run  -i                      #interative 交互式应用
               -t                      #tty 虚拟终端
               --name webserver        #指定容器名字
               --rm                    #容器停止后自动删除容器
               -d                      #以detach方式，也就是分离方式连接终端，以便在关闭终端时不影响容器的运行。
               -P 80                   #不带参数，发布所有容器内的端口到主机随机端口，使用docker port CONTAINER 可以查询。
               -p 8888:80              #8888:88 主机的8888端口为容器88端口的映射。
               -v %PWD/web:/var/www/html/web:ro    #指定本地主机路径%PWD/web映射到目的路径/var/www/html/web
               --restart=always        #无论退出代码是什么，自动重启
               --restart=on-failure:5  #失败时重启，最多重启5次

   docker inspect ubuntu               #查看容器运行的信息
   docker inspect --format='{{.State.Running}}' ubuntu #格式化查询
   docker history e5c51ef702d4         #查看docker 镜像的构建历史
   docker port 774b2f613874            #显示容器端口->主机端口

删除停止的容器

::

   docker rm $(docker ps -a -q -f status=exited)
   docker container prune

.. caution:: 容器无法联网怎么办，考虑添加NAT， 参考理解 :ref:`the_veth`

   iptables -t nat -A POSTROUTING -o eno3 -s 172.17.0.0/16 -j MASQUERADE

问题记录
=============

docker ps Got permission denied
----------------------------------

.. code-block:: console

    [user1@centos leetcode]$ docker ps
    Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.40/containers/json: dial unix /var/run/docker.sock: connect: permission denied
    [user1@centos leetcode]$ sudo usermod -aG docker $USER
    [user1@centos leetcode]$

CentOS 8 none of the providers can be installed
-----------------------------------------------------

.. code-block:: console

   [root@ref-controller ~]# sudo yum install containerd.io docker-ce docker-ce-cli
   Last metadata expiration check: 0:04:44 ago on Wed 25 Mar 2020 09:45:26 AM CST.
   Error:
   Problem: package docker-ce-3:19.03.8-3.el7.aarch64 requires containerd.io >= 1.2.2-3, but none of the providers can be installed
   - cannot install the best candidate for the job
   - package containerd.io-1.2.10-3.2.el7.aarch64 is excluded
   - package containerd.io-1.2.13-3.1.el7.aarch64 is excluded
   - package containerd.io-1.2.2-3.3.el7.aarch64 is excluded
   - package containerd.io-1.2.2-3.el7.aarch64 is excluded
   - package containerd.io-1.2.4-3.1.el7.aarch64 is excluded
   - package containerd.io-1.2.5-3.1.el7.aarch64 is excluded
   - package containerd.io-1.2.6-3.3.el7.aarch64 is excluded
   (try to add '--skip-broken' to skip uninstallable packages or '--nobest' to use not only best candidate packages)


其实软件源里面有containerd.io-1.2.6-3.3.el7.aarch64，但是为什么提示被排除，有可能是没有为8版本设置软件源的原因。

解决办法：

.. code-block:: console

   yum install -y https://download.docker.com/linux/centos/7/aarch64/stable/Packages/containerd.io-1.2.6-3.3.el7.aarch64.rpm



.. [#docker_install] 安装docker https://docs.docker.com/install/linux/docker-ce/centos/
.. [#docker_run_reference] docker run 参数。 https://docs.docker.com/engine/reference/run/
.. [#docker-doc] 一个docker教程参考 https://yeasy.gitbooks.io/docker_practice/image/list.html
