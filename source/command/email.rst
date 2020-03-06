******************
email
******************

怎么安全的在网上刘邮箱而不会机器人抓取

.. code-block:: shell

    #编码
    echo someone@gmail.com | base64
    c29tZW9uZUBnbWFpbC5jb20K

    #解码
    echo c29tZW9uZUBnbWFpbC5jb20K | base64 -d
    someone@gmail.com

