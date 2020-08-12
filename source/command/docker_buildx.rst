***************************
docker buildx
***************************

image 构建工具，用于构建多种架构的镜像

安装buildx
=====================

开启实验室特性
--------------------

docker客户端 ::

    user1@intel6248:~$ cat ~/.docker/config.json
    {
    "experimental": "enabled"
    }


docker 服务端 ::

    user1@intel6248:~$ cat /etc/docker/daemon.json
    {
    "experimental": true
    }

    systemctl daemon-reload
    systemctl restart docker


确认配置成功， `Experimental:     true` ::

    docker version


安装 docker buildx
-----------------------

如果是 19.03.8， 安装完docker之后就包含了。

如果没有可以直接下载二进制 [#gitbuh_buildx]_ , 并放到指定目录 ::

    mkdir -p ~/.docker/cli-plugins
    mv buildx ~/.docker/cli-plugins/docker-buildx

确认安装成功 ::

    docker buildx ls
    docker buildx create --name mybuilder --use
    docker buildx inspect --bootstrap


安装模拟器
--------------------

如果上面的步骤没有显示多种平台的支持，那么就需要安装模拟器，现在dockers 官方文档只说明了，
buildx会包含再docker destop for MAC & windows默认包含buildx， 对于community 版本，
我参考这两篇文章进行设置 [#blog_multi_arch]_ [#arm_multi_arch]_ ::

    user1@intel6248:~$ docker buildx ls
    NAME/NODE         DRIVER/ENDPOINT             STATUS  PLATFORMS
    mybuilder *       docker-container
    mybuilder0      unix:///var/run/docker.sock running linux/amd64, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v7, linux/arm/v6
    default           docker
    default         default                     running linux/amd64, linux/386

最简单的办法就是 ::

    docker run --rm --privileged docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad64

其中tag可以到这里查询最新的。 [#binfmt]_


build多平台image
=============================

这里我使用了来自 [#arm_multi_arch]_ 的hello.c [#dockerfile_multi_arch]_ ::

    docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 --push -t lixianfadocker/hello .


运行多平台image
=============================

运行命令 ::

    docker run --rm --name hello lixianfadocker/hello

在X86上的运行输出是 ::

    user1@intel6248:~/Dockerfile_kunpeng/Dockerfile_multi_arch$ docker run --rm --name hello lixianfadocker/hello

    Status: Downloaded newer image for lixianfadocker/hello:latest
    Hello, my architecture is Linux buildkitsandbox 4.15.0-99-generic #100-Ubuntu SMP Wed Apr 22 20:32:56 UTC 2020 x86_64 Linux


在Kunpeng920上的运行输出是 ::

    user1@Arm64-server:~$ docker run --rm --name hello lixianfadocker/hello

    Status: Downloaded newer image for lixianfadocker/hello:latest
    Hello, my architecture is Linux buildkitsandbox 4.15.0-99-generic #100-Ubuntu SMP Wed Apr 22 20:32:56 UTC 2020 aarch64 Linux


使用build farm
===========================

在单台设备上使用build farm的问题是，用模拟指令的方式， 会非常慢。

::

    # 创建一个上下文环境
    docker context create --docker "host=ssh://user1@192.168.1.203" intel6248

    # assuming contexts node-amd64 and node-arm64 exist in "docker context ls"
    $ docker buildx create --use --name mybuild node-amd64
    mybuild
    $ docker buildx create --append --name mybuild node-arm64
    $ docker buildx build --platform linux/amd64,linux/arm64 .

创建



.. [#blog_multi_arch] https://jite.eu/2019/10/3/multi-arch-docker/
.. [#arm_multi_arch] https://community.arm.com/developer/tools-software/tools/b/tools-software-ides-blog/posts/getting-started-with-docker-for-arm-on-linux
.. [#gitbuh_buildx] https://github.com/docker/buildx/releases
.. [#binfmt] https://hub.docker.com/r/docker/binfmt/tags?page=1&ordering=last_updated
.. [#dockerfile_multi_arch] https://github.com/LyleLee/Dockerfile_kunpeng/tree/master/Dockerfile_multi_arch