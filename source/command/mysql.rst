****************************
mysql
****************************

运行docker mysql [#mysql-docker]_


MySQL Server Docker 镜像包含  mysqld , mysql client, mysqladmin, mysqldump [#mysql-server-products]_

简单运行mysql ::

    docker run --name=mysql80 -d mysql/mysql-server:8.0


自定义配置文件和配置目录运行mysql ::

    docker run --name=mysql80 \
    --mount type=bind,src=/path-on-host-machine/my.cnf,dst=/etc/my.cnf \
    --mount type=bind,src=/path-on-host-machine/datadir,dst=/var/lib/mysql \
    -d mysql/mysql-server:8.0

获取密码

查看mysql-docker [#mysql-docker]_

修改密码::

    ALTER USER 'root'@'localhost' IDENTIFIED BY 'password'

查看docker容器内的mysql数据 [#mysql-data]_ ::

    docker exec -it mysql1 bash
    ls /var/lib/mysql


组复制教程 [#group-replication]_



No match for argument: mysql-community-server
-----------------------------------------------------

在CentOS8上安装mysql8 ::

    Last metadata expiration check: 0:08:03 ago on Mon 13 Jul 2020 04:21:47 PM CST.
    No match for argument: mysql-community-server
    Error: Unable to find a match: mysql-community-server

解决办法 ::

    sudo yum module disable mysql
    sudo yum install mysql-community-server


This member has more executed transactions than those present in the group
-----------------------------------------------------------------------------

::

    mysql> START GROUP_REPLICATION USER='rpl_user', PASSWORD='Huawei12#$';
    ERROR 3092 (HY000): The server is not configured properly to be an active member of the group. Please see more details on error log.
    mysql> exit
    Bye
    [root@s2 ~]# tail -f /var/log/mysqld.log
    2020-07-21T03:00:35.741951Z 31 [System] [MY-011566] [Repl] Plugin group_replication reported: 'Setting super_read_only=OFF.'
    2020-07-21T03:24:50.791249Z 30 [System] [MY-010597] [Repl] 'CHANGE MASTER TO FOR CHANNEL 'group_replication_recovery' executed'. Previous state master_host='', master_port= 3306, master_log_file='', master_log_pos= 4, master_bind=''. New state master_host='', master_port= 3306, master_log_file='', master_log_pos= 4, master_bind=''.
    2020-07-21T03:25:25.119886Z 30 [System] [MY-013587] [Repl] Plugin group_replication reported: 'Plugin 'group_replication' is starting.'
    2020-07-21T03:25:25.124377Z 38 [System] [MY-011565] [Repl] Plugin group_replication reported: 'Setting super_read_only=ON.'
    2020-07-21T03:25:25.150122Z 39 [System] [MY-010597] [Repl] 'CHANGE MASTER TO FOR CHANNEL 'group_replication_applier' executed'. Previous state master_host='', master_port= 3306, master_log_file='', master_log_pos= 4, master_bind=''. New state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''.
    2020-07-21T03:25:27.235240Z 0 [ERROR] [MY-011526] [Repl] Plugin group_replication reported: 'This member has more executed transactions than those present in the group. Local transactions: f73f5131-c736-11ea-b750-5254009f4811:1 > Group transactions: aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa:1-4'
    2020-07-21T03:25:27.235409Z 0 [ERROR] [MY-011522] [Repl] Plugin group_replication reported: 'The member contains transactions not present in the group. The member will now exit the group.'
    2020-07-21T03:25:27.235543Z 0 [System] [MY-011503] [Repl] Plugin group_replication reported: 'Group membership changed to s1:3306, s2:3306 on view 15953009400073079:2.'
    2020-07-21T03:25:30.773866Z 0 [System] [MY-011504] [Repl] Plugin group_replication reported: 'Group membership changed: This member has left the group.'
    2020-07-21T03:25:30.780621Z 38 [System] [MY-011566] [Repl] Plugin group_replication reported: 'Setting super_read_only=OFF.'
    ^C


解决办法 ::

    mysql > reset master;
    mysql > START GROUP_REPLICATION USER='rpl_user', PASSWORD='Huawei12#$';


.. [#mysql-docker] https://github.com/mysql/mysql-docker
.. [#mysql-server-products] https://github.com/mysql/mysql-docker#user-content-products-included-in-the-container:~:text=A%20number%20of%20MySQL
.. [#mysql-data] https://dev.mysql.com/doc/refman/8.0/en/docker-mysql-getting-started.html#docs-body:~:text=in%20the-,server's%20data%20directory
.. [#group-replication] https://dev.mysql.com/doc/refman/8.0/en/group-replication-getting-started-deploying-instances.html