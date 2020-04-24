**************************
docker swarm
**************************

docker swarm 常用命令
======================

.. code-block:: shell

    docker service create --replicas 1 --name pingthem busybox ping baidu.com
    docker service ps pingthem
    docker service inspect pingthem
    docker service scale pingthem=5
    docker service ls
    docker service rm pingthem


创建manager

.. code-block:: console

    [user1@centos86 ~]$ docker swarm init --advertise-addr 192.168.1.203
    Swarm initialized: current node (4nj18pipvg0rg4879psiql8xe) is now a manager.

    To add a worker to this swarm, run the following command:

        docker swarm join --token SWMTKN-1-5i86qowshahqf67m0a2569i2y6pnpo25muu1ne5hn3eeo3k9bi-3efz4kdw8ol43nj4nw23ckv17 192.168.1.203:2377

    To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

一台主机加入swarm

.. code-block:: shell

    docker swarm join --token SWMTKN-1-5i86qowshahqf67m0a2569i2y6pnpo25muu1ne5hn3eeo3k9bi-3efz4kdw8ol43nj4nw23ckv17 192.168.1.203:2377

另一台主机加入swarm

.. code-block:: shell

    docker swarm join --token SWMTKN-1-5i86qowshahqf67m0a2569i2y6pnpo25muu1ne5hn3eeo3k9bi-3efz4kdw8ol43nj4nw23ckv17 192.168.1.203:2377


创建完毕查看集群状态，已经加入了三个节点。

.. code-block:: console

    [user1@intel6248 ~]$ docker node ls
    ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
    4nj18pipvg0rg4879psiql8xe *   intel6248           Ready               Active              Leader              19.03.7
    jle3s6my1znz1yg9z4o450kkp     kunpeng916          Ready               Active                                  19.03.8
    k7cndxruwpyjcauxxdlc83b3t     kunpeng920          Ready               Active                                  19.03.8


创建一个工作任务

