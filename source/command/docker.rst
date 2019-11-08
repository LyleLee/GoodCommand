docker
======

操作系统级别的虚拟化技术，用于实现应用的快速自动化部署。

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
