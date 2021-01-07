*********************************
nginx
*********************************

优秀的反向代理服务器

端口转发
=================================


访问 ``http://localhost:8080``  会被转发到 ``http://localhost:1234`` 这里定义一个cutomed_http实际提供内容的服务器。定义了proxy_set_header，proxy_set_header，proxy_pass，这里不清楚实际含义，注意proxy_pass写对前面定义的cutomed_http就可以了。
后面的用户认证可忽略。

.. code-block:: ini

    upstream cutomed_http{
        server 127.0.0.1:1234;
    }

    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    server {
        listen       8080;
        server_name  localhost;

        location / {
            proxy_set_header Host $host;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass http://cutomed_http;

            auth_basic             "admin";
            auth_basic_user_file    htpasswd;
        }
    }


两个端口上上运行服务
========================

定义两个server字段

.. code-block:: ini

 server {
        listen       8080;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   "D:\doc\GoodCommand\build\html";
            index  index.html index.htm;
            autoindex   on;
            autoindex_localtime on;
            charset utf-8;
            auth_basic             "admin";
            auth_basic_user_file    htpasswd;
        }
 server {
    listen       8088;
    server_name  localhost;

    location / {
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://moba_http;
        auth_basic             "admin";
        auth_basic_user_file    htpasswd;
    }
}

添加密码
=======================

.. code:: bash

     htpasswd -bc publishpdf a pdf

在nginx.conf中指明文件

.. code:: conf

    	server {
            listen		80;
            server_name  your.domain.com;
            auth_basic "Please input password"; #这里是验证时的提示信息 
            auth_basic_user_file publishpdf; # 指定文件
            # ...
        }
