**********************
minikube
**********************

The very simple way [#minikube_start]_ to start a :doc:`kubernetes` cluster

在鲲鹏上安装
===================


x86上 ::

    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    rm -rf ~/.minikube
    # 设置代理
    minikube start

官网的文档还没有介绍如何下载ARM64的版本， 这里给出下载办法 ::

    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-arm64
    sudo install minikube-linux-arm6  /usr/local/bin/
    sudo ln -s /usr/local/bin/minikube-linux-arm64 /usr/local/bin/minikube      # 为了方便


问题记录
==================================

无法从https://gcr.io/v2/拉取镜像
----------------------------------

::

    user1@Arm64-server:~/opensoftware/minikube/out$ docker pull gcr.io/k8s-minikube/kicbase:v0.0.10
    Error response from daemon: Get https://gcr.io/v2/: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)

解决办法: 设置proxy [#docker_systemd]_ ::

    sudo mkdir -p /etc/systemd/system/docker.service.d
    sudo vim /etc/systemd/system/docker.service.d/http-proxy.conf

    [Service]
    Environment="HTTP_PROXY=http://proxy.example.com:80/" "NO_PROXY=localhost,127.0.0.1,docker-registry.example.com,.corp"

或者使用cn镜像 [#minikube_aliyun]_ ::

    minikube delete
    minikube start --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers


.. [#docker_systemd] https://docs.docker.com/config/daemon/systemd/
.. [#minikube_start] https://minikube.sigs.k8s.io/docs/start/
.. [#minikube_aliyun] https://github.com/kubernetes/minikube/issues/3860

