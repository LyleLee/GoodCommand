*************
curl
*************

url访问工具

.. code-block:: shell
    
    curl www.baidu.com


通过http代理访问
.. code-block:: shell

    curl -x http://128.5.65.193:8080 -v www.baidu.com

通过ssh tunnel代理访问

.. code-block:: shell

    ssh -D localhost:9999 me@192.168.1.201
    curl -x socks5://127.0.0.1:9999 cip.cc