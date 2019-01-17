KVM list
=====================
1. 查看当前虚拟机  
    virsh list -all
2. 通过串口登录虚拟机  
    virsh console ubuntu_1
3. 链接到虚拟机接口  
    virsh connect ubuntu1  
4. 停止VM，启动VM 
    ```sh
    virsh shutdown ubuntu_2  
    virsh start ubuntu_2
    ```
5. 删除VM  
    ```sh
    virsh destroy ubuntu_2  
    virsh undefine ubuntu_2    
    virsh undefine ubuntu_2 --nvram
    ```
6. 克隆VM
    ```sh
    sudo virt-clone \
            --original ubuntu_1     \
            --name ubuntu_7         \
            --auto-clone

    ```
7. 查看网络信息
    ```shell
    virsh net-list
    virsh net-info default
    virsh net-dhcp-leases default
    ```
4. kvm 部署  
[参考地址](https://www.sysgeek.cn/install-configure-kvm-ubuntu-18-04/)
5. kvm网络配置介绍  
[参考地址](https://segmentfault.com/a/1190000015418876)  
6. 查看
7. 部署Ceph
    ```sh
    su -s
    sudo passwd root
    lxf
    su me
    sudo useradd -s /bin/bash -m tom
    sudo passwd tom
    lxf
    echo "tom ALL =(root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/tom
    sudo chmod 0440 /etc/sudoers.d/tom
    ```
8. 添加或者卸载硬盘
    ```sh
    sudo qemu-img create -f qcow2 ubuntu_vm7_disk_100G 100G
    virsh attach-disk ubuntu_7 /var/lib/libvirt/images/ubuntu_vm7_disk_100G vdb --subdriver=qcow2
    qemu-img info ubuntu_vm7_disk_100G
    virsh detach-disk ubuntu_7 /var/lib/libvirt/images/ubuntu_vm7_disk_100G
    fdisk -l
    lsblk

    挂载qcow2类型的磁盘需要使用--subdir
    virsh attach-disk ubuntu_1 /var/lib/libvirt/images/ubuntu_vm1_disk_100G vdb --subdriver=qcow2
    virsh attach-disk ubuntu_2 /var/lib/libvirt/images/ubuntu_vm2_disk_100G vdb --subdriver=qcow2
    virsh attach-disk ubuntu_3 /var/lib/libvirt/images/ubuntu_vm3_disk_100G vdb --subdriver=qcow2
    virsh attach-disk ubuntu_4 /var/lib/libvirt/images/ubuntu_vm4_disk_100G vdb --subdriver=qcow2
    virsh attach-disk ubuntu_5 /var/lib/libvirt/images/ubuntu_vm5_disk_100G vdb --subdriver=qcow2
    virsh attach-disk ubuntu_6 /var/lib/libvirt/images/ubuntu_vm6_disk_100G vdb --subdriver=qcow2
    ```