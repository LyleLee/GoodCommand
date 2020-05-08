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


也可以设置命令自动补全 [#kubernetes_auto_complement]_

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

.. [#download_kubectl] https://kubernetes.io/docs/setup/release/notes/#downloads-for-v1-18-0
.. [#kubernetes_master] https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/
.. [#kubernetes_node] https://kubernetes.io/docs/tutorials/kubernetes-basics/explore/explore-intro/
.. [#install-minikube] https://kubernetes.io/docs/tasks/tools/install-minikube/
.. [#kubernetes_auto_complement] https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion
