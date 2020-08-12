****************************
go images
****************************

如何生成golang镜像，包含编译程序所需的依赖。


程序需要依赖pcap。 如果用官方的golang镜像， 默认不会包含pcap，所以会报错

::

    pcap.h: No such file or directory


这个时候基于官方依赖，把依赖打包进去。

.. code-block:: dockerfile

    FROM golang:1.14-alpine

    WORKDIR /go/src/app
    RUN cp -a /etc/apk/repositories /etc/apk/repositories.bak && \
        sed -i "s@http://dl-cdn.alpinelinux.org/@https://mirrors.huaweicloud.com/@g" /etc/apk/repositories
    RUN apk update && apk add libpcap-dev && apk add git && apk add gcc && apk add g++ && apk add openssh-client

    VOLUME /go/src/app


    CMD ["/bin/sh"]


构建镜像

::

    user@server:~/Dockerfile_kunpeng/Dockerfile_golang_build$ docker build -t compiler .
    Sending build context to Docker daemon  2.048kB
    Step 1/9 : FROM golang:1.14-alpine
    ---> 3289bf11c284
    Step 2/9 : WORKDIR /go/src/app
    ---> Using cache
    ---> 3a90cbce712d

    ......

    Step 9/9 : CMD ["/bin/sh"]
    ---> Running in 289b9617108f
    Removing intermediate container 289b9617108f
    ---> 5c4471bf0685
    Successfully built 5c4471bf0685
    Successfully tagged compiler:latest


之后就可以在容器里对工程进行编译了，指定ld是为了静态链接依赖库，要不然运行环境也需要有依赖库::

    docker run --rm -it --name compiler -v "$(pwd):/go/src/app" compiler

    /go/src/app # go build -a -ldflags '-extldflags "-static"' -o app.out .



在宿主机的目录下生成了目标文件 ::

    user@server:~/program/pcabapp$ ls app.out -lh
    -rwxr-xr-x 1 root root 4.6M Jun 18 09:14 app.out
