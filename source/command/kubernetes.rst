*******************
kubernetes
*******************


下载安装kubectl [#download_kubectl]_

如果是和 :doc: `minikube <./minikube>` 一起使用的话，只需要下载client端就可以了。 ::

    curl -OL https://dl.k8s.io/v1.18.0/kubernetes-client-linux-arm64.tar.gz


常用命令
======================


.. code-block:: console

    kubectl cluster-info        # 查看集群信息
    kubectl config view         #
    -------------------
    kubectl get                 # 列出资源
    kubectl get nodes           # 查看节点信息
    kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1 # 创建deployments
    kubectl get deployments     # 查看deployments
    kubectl get pods            # 查看pods
    kubectl get events          # 查看事件， 操作出错记录
    kubectl get services        # 查看服务
    ---------------------
    kubectl describe            # 显示资源详情
    ---------------------
    kubectl logs                # 打印容器的日志
    ---------------------
    kubectl exec                # 在一个容器中执行命令
    ---------------------
    kubectl -n service rollout restart deployment <name>    # 重启服务



也可以设置命令自动补全 [#kubernetes_auto_completion]_ ::

    kubectl completion bash >/etc/bash_completion.d/kubectl
    kubeadm completion bash >/etc/bash_completion.d/kubeadm


minikube [#install-minikube]_ 官方未支持aarch64


简单概念
========================

+ Matser 负责管理集群 [#kubernetes_master]_
+ Node 是一个VM或者是物理机， kubernetes 集群的 worker [#kubernetes_node]_ 一个Node至少要运行
    + Kubelet 一个在Node上负责和Master沟通的进程，管理运行在Node上的容器。
    + 容器引擎，如Docker，拉取镜像，运行容器
+ Deployments 一个部署， 描述使用什么镜像，多少个副本容器等配置。通过过Kubernetes API告诉集群执行部署。


.. code-block:: console

    * Creating kvm2 VM (CPUs=2, Memory=2000MB, Disk=20000MB) ...
    E0421 09:15:04.389896   79372 cache_images.go:86] CacheImage k8s.gcr.io/coredns-arm64:1.6.5 -> /home/user1/.minikube/cache/images/k8s.gcr.io/coredns-arm64_1.6.5 failed: write: MANIFEST_UNKNOWN: "fetch \"1.6.5\" from request \"/v2/coredns-arm64/manifests/1.6.5\"."
    *
    X Unable to start VM. Please investigate and run 'minikube delete' if possible
    * Error: [DRIVER_CORRUPT] new host: Error attempting to get plugin server address for RPC: Failed to dial the plugin server in 10s
    * Suggestion: The VM driver exited with an error, and may be corrupt. Run 'minikube start' with --alsologtostderr -v=8 to see the error
    * Documentation: https://minikube.sigs.k8s.io/docs/reference/drivers/


安装部署集群
======================

添加kubernetes软件源 ::

    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
    deb https://apt.kubernetes.io/ kubernetes-xenial main
    EOF

检查所需的镜像是否能获得 ::

    kubeadm config images pull

    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

安装网络插件 ::

    sudo kubeadm init
    kubectl apply -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml

    kubectl get nodes #确认master ready

    kubeadm token create --print-join-command



workder
------------------

手动部署： [#kubeadm_install]_

加载br_netfilter ::

    lsmod | grep br_netfilter
    sudo modprobe br_netfilter

设置操作系统参数，br_netfilter没有加载的话时没有这两个变量的 ::

    cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
    net.bridge.bridge-nf-call-ip6tables = 1
    net.bridge.bridge-nf-call-iptables = 1
    EOF
    sudo sysctl --system    # 应用到系统

添加kubernetes软件源 ::

    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
    deb https://apt.kubernetes.io/ kubernetes-xenial main
    EOF


加入集群 ::

    sudo kubeadm join 192.168.1.180:6443 --token yzep8d.7svs6hvljrhqk562 \
        --discovery-token-ca-cert-hash sha256:83e29e1b29c1a11cdcb067c5da9ae58d9e11c2c15dfaa092f5b0ce3aa625b0f9



haproxy
=====================

编辑配置文件

.. code-block:: yaml

    global
            daemon
    defaults
            mode http

    frontend k8s-api-server-in
            bind 0.0.0.0:8443
            mode tcp
            default_backend k8s-api-server-host

    backend k8s-api-server-host
            balance roundrobin
            server master1 192.168.122.100:6443
            server master2 192.168.122.101:6443
            server master3 192.168.122.102:6443


启动服务 ::

    docker run -d --name my-haproxy \
        -v /etc/haproxy:/usr/local/etc/haproxy:ro \
        -p 8443:8443 \
        -p 1080:1080 \
        --restart always \
        haproxy:latest


kubernetes yaml
=====================

yaml文件描述：

:apiVersion: api版本
:kind: 资源类型。可以是pod， node， configMap
:metadata: 元数据。 名称，标签，注解
:spec: 规格。 容器列表，volume
:status: 状态。 内部详细状态


问题记录
=====================

running with swap on is not supported. Please disable swap
----------------------------------------------------------------

::

    user1@Arm64-server:~$ sudo kubeadm init --pod-network-cidr=10.244.0.0/16
    I0510 21:10:40.951053   25602 version.go:240] remote version is much newer: v1.18.2; falling back to: stable-1.14
    [init] Using Kubernetes version: v1.14.10
    [preflight] Running pre-flight checks
            [WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
            [WARNING SystemVerification]: this Docker version is not on the list of validated versions: 19.03.8. Latest validated version: 18.09
    error execution phase preflight: [preflight] Some fatal errors occurred:
            [ERROR Swap]: running with swap on is not supported. Please disable swap
    [preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`


解决办法 ::

    sudo swapoff -a


WARNING: kubeadm cannot validate component configs for API group
------------------------------------------------------------------

::

    user1@Arm64-server:~$ kubeadm config images pull
    W0511 23:20:25.155396   59650 configset.go:202] WARNING: kubeadm cannot validate component configs for API groups [kubelet.config.k8s.io kubeproxy.config.k8s.io]
    [config/images] Pulled k8s.gcr.io/kube-apiserver:v1.18.2
    [config/images] Pulled k8s.gcr.io/kube-controller-manager:v1.18.2
    [config/images] Pulled k8s.gcr.io/kube-scheduler:v1.18.2
    [config/images] Pulled k8s.gcr.io/kube-proxy:v1.18.2
    [config/images] Pulled k8s.gcr.io/pause:3.2
    [config/images] Pulled k8s.gcr.io/etcd:3.4.3-0
    [config/images] Pulled k8s.gcr.io/coredns:1.6.7


Public key for is not installed
--------------------------------

::

    Public key for fdd1728b8dd0026e64a99ebb87d5b7a6c026a8e2f4796e383cc7ac43e7d7ccf2-kubelet-1.18.2-0.aarch64.rpm is not installed
    Public key for 98b57cf856484f0d15a58705136d9319e57c5b80bea2eea93cf02bb2365651dc-kubernetes-cni-0.7.5-0.aarch64.rpm is not installed
    Public key for socat-1.7.3.2-6.el8.aarch64.rpm is not installed. Failing package is: socat-1.7.3.2-6.el8.aarch64
    GPG Keys are configured as: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
    Public key for conntrack-tools-1.4.4-9.el8.aarch64.rpm is not installed. Failing package is: conntrack-tools-1.4.4-9.el8.aarch64
    GPG Keys are configured as: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
    Public key for iptables-1.8.2-16.el8.aarch64.rpm is not installed. Failing packa


Failed to set locale, defaulting to C.UTF-8” in CentOS 8
-----------------------------------------------------------

解决办法 ::

    dnf install langpacks-en glibc-all-langpacks -y


UnicodeEncodeError: 'ascii' codec can't encode character u'\u2013'
-----------------------------------------------------------------------

::

    [root@localhost ~]# dnf install -y kubelet kubeadm kubectl –disableexcludes=kubernetes
    Last metadata expiration check: 0:00:07 ago on Mon 08 Jun 2020 07:56:12 PM CST.
    No match for argument: kubelet
    No match for argument: kubeadm
    No match for argument: kubectl

    File "/usr/lib/python2.7/site-packages/dnf/cli/commands/install.py", line 180, in _install_packages
        logger.info(msg, self.base.output.term.bold(pkg_spec))
    File "/usr/lib/python2.7/site-packages/dnf/cli/term.py", line 247, in bold
        return self.color('bold', s)
    File "/usr/lib/python2.7/site-packages/dnf/cli/term.py", line 243, in color
        return (self.MODE[color] + str(s) + self.MODE['normal'])
    UnicodeEncodeError: 'ascii' codec can't encode character u'\u2013' in position 0: ordinal not in range(128)


我的情况是kubenetes.yaml含有中文字符，修改exclude之后成功 ::

    dnf install -y kubelet kubeadm kubectl


.. [#download_kubectl] https://kubernetes.io/docs/setup/release/notes/#downloads-for-v1-18-0
.. [#kubeadm_install] https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
.. [#kubernetes_master] https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/
.. [#kubernetes_node] https://kubernetes.io/docs/tutorials/kubernetes-basics/explore/explore-intro/
.. [#install-minikube] https://kubernetes.io/docs/tasks/tools/install-minikube/
.. [#kubernetes_auto_completion] https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion
.. [#google_public_images] https://console.cloud.google.com/gcr/images/google-containers/GLOBAL
.. [#ha-topology] https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ha-topology/