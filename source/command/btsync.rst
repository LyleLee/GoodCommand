############################
btsync
############################

P2P同步工具，用 Docker 来运行还是比较方便的。

.. code:: shell

    DATA_FOLDER=/path/to/data/folder/on/the/host
    WEBUI_PORT=<port to access the webui on the host>

    mkdir -p $DATA_FOLDER

    docker run -d --name Sync \
            -p 127.0.0.1:$WEBUI_PORT:8888 \
            -p 55555 \
            -v $DATA_FOLDER:/mnt/sync \
            --restart on-failure \
            resilio/sync


打开 web UI 输入key就可以开始同步了。 比如 B7P64IMWOCXWEYOXIMBX6HN5MHEULFS4V 。