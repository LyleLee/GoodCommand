**********************
UOS
**********************
UOS是 unity operating system 的简称，统一操作系统。有国内多家公司联名筹备

UOS目前可以再Taishan服务（鲲鹏920）上运行。

UOS 软件源配置
======================
UOS基于debian， 其实也可以使用ubuntu的软件源。

下载软件源文件到指定目录，添加公钥， 公钥3B4FE6ACC0B21F32可以先不添加，apt update会自己报错提示。

.. code-block:: shell

    sudo wget -O /etc/apt/sources.list.d/Ubuntu-Ports-bionic.list https://mirrors.huaweicloud.com/repository/conf/Ubuntu-Ports-bionic.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
    sudo apt update

设置之后可以看到更新结果

.. code-block:: console

    uos@uos-PC:/etc/apt/sources.list.d$
    uos@uos-PC:/etc/apt/sources.list.d$ sudo apt update
    获取:1 https://mirrors.huaweicloud.com/ubuntu-ports bionic InRelease [242 kB]
    获取:2 https://mirrors.huaweicloud.com/ubuntu-ports bionic-security InRelease [88.7 kB]
    获取:3 https://mirrors.huaweicloud.com/ubuntu-ports bionic-updates InRelease [88.7 kB]
    获取:4 https://mirrors.huaweicloud.com/ubuntu-ports bionic-backports InRelease [74.6 kB]
    获取:5 https://mirrors.huaweicloud.com/ubuntu-ports bionic/multiverse Sources [181 kB]
    获取:6 https://mirrors.huaweicloud.com/ubuntu-ports bionic/main Sources [829 kB]
    获取:7 https://mirrors.huaweicloud.com/ubuntu-ports bionic/universe Sources [9,051 kB]



问题记录
======================

.. code-block:: console

    uos@uos-PC:/etc/apt/sources.list.d$ sudo apt update
    获取:1 https://mirrors.huaweicloud.com/ubuntu-ports bionic InRelease [242 kB]
    获取:2 https://mirrors.huaweicloud.com/ubuntu-ports bionic-security InRelease [88.7 kB]
    错误:1 https://mirrors.huaweicloud.com/ubuntu-ports bionic InRelease
      由于没有公钥，无法验证下列签名： NO_PUBKEY 3B4FE6ACC0B21F32
    获取:3 https://mirrors.huaweicloud.com/ubuntu-ports bionic-updates InRelease [88.7 kB]
    获取:4 https://mirrors.huaweicloud.com/ubuntu-ports bionic-backports InRelease [74.6 kB]
    错误:2 https://mirrors.huaweicloud.com/ubuntu-ports bionic-security InRelease
      由于没有公钥，无法验证下列签名： NO_PUBKEY 3B4FE6ACC0B21F32
    错误:3 https://mirrors.huaweicloud.com/ubuntu-ports bionic-updates InRelease
      由于没有公钥，无法验证下列签名： NO_PUBKEY 3B4FE6ACC0B21F32
    错误:4 https://mirrors.huaweicloud.com/ubuntu-ports bionic-backports InRelease
      由于没有公钥，无法验证下列签名： NO_PUBKEY 3B4FE6ACC0B21F32
    正在读取软件包列表... 完成
    N: 忽略‘ubuntu-archive-keyring.gpg’(于目录‘/etc/apt/sources.list.d/’)，鉴于它的文件扩展名无效
    W: GPG 错误：https://mirrors.huaweicloud.com/ubuntu-ports bionic InRelease: 由于没有公钥，无法验证下列签名： NO_PUBKEY 3B4FE6ACC0B21F32
    E: 仓库 “https://mirrors.huaweicloud.com/ubuntu-ports bionic InRelease” 没有数字签名。
    N: 无法安全地用该源进行更新，所以默认禁用该源。
    N: 参见 apt-secure(8) 手册以了解仓库创建和用户配置方面的细节。
    W: GPG 错误：https://mirrors.huaweicloud.com/ubuntu-ports bionic-security InRelease: 由于没有公钥，无法验证下列签名： NO_PUBKEY 3B4FE6ACC0B21F32
    E: 仓库 “https://mirrors.huaweicloud.com/ubuntu-ports bionic-security InRelease” 没有数字签名。
    N: 无法安全地用该源进行更新，所以默认禁用该源。
    N: 参见 apt-secure(8) 手册以了解仓库创建和用户配置方面的细节。
    W: GPG 错误：https://mirrors.huaweicloud.com/ubuntu-ports bionic-updates InRelease: 由于没有公钥，无法验证下列签名： NO_PUBKEY 3B4FE6ACC0B21F32
    E: 仓库 “https://mirrors.huaweicloud.com/ubuntu-ports bionic-updates InRelease” 没有数字签名。
    N: 无法安全地用