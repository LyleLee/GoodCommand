**************
docker
**************

操作系统级别的虚拟化技术，用于实现应用的快速自动化部署。 [#docker-doc]_

常用命令
==============

.. code-block:: shell

    docker run -it ubuntu bash  #前台运行容器并且进入， 只有一个进程bash
    exit                        #退出bash， 容器停止运行。 可以使用如下命令
    ctrl + p + q                #退出容器，bash不退出， 容器继续运行

    docker exec -it 35dfs bash  #进入已经在运行程序，启动一个bash进程，这个时候系统一共有两个bash
    exit                        #退出bash，因为还有一个bash已经在运行，所以容器不会停止运行。


docker安装
==============

.. code-block:: shell

    # Use the following command to set up the stable repository.
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo docker run hello-world


删除停止的容器

::

   docker rm $(docker ps -a -q -f status=exited)
   docker container prune

容器停止后自动删除容器

::

   docker run --rm USER/CONTAINER

交互式运行容器

::

   docker run -it busybox sh
   -i interative
   -t tty

docker run 的其他参数

::

   -d  以detach方式，也就是分离方式连接终端，以便在关闭终端时不影响容器的运行。
   -P  不带参数，发布所有容器内的端口到主机随机端口，使用docker port CONTAINER 可以查询。
   -p 8888:88 主机的8888端口为容器88端口的映射。


问题记录
=============

docker ps Got permission denied
----------------------------------

.. code-block:: console

    [user1@centos leetcode]$ docker ps
    Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.40/containers/json: dial unix /var/run/docker.sock: connect: permission denied
    [user1@centos leetcode]$ sudo usermod -aG dockerroot $USER
    [user1@centos leetcode]$

.. [#docker-doc] https://yeasy.gitbooks.io/docker_practice/image/list.html
