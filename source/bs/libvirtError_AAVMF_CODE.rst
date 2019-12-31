*****************************************
libvirtError: unable to find any master
*****************************************


安装虚拟机提示：

.. code-block:: console

    libvirtError: operation failed: unable to find any master var store for loader: /usr/share/AAVMF/AAVMF_CODE.fd


解决办法：

把libvirt配置改成/usr/share/AAVMF/AAVMF_CODE.fd:/usr/share/AAVMF/AAVMF_VARS.fd 这个就好了


参考一个虚拟机的xml

.. code-block:: xml

    <domain type='kvm'>
      <name>CentOS7.6</name>
      <uuid>52f824a5-f3bf-4322-a81c-cd9557d0decb</uuid>
      <memory unit='KiB'>8388608</memory>
      <currentMemory unit='KiB'>8388608</currentMemory>
      <vcpu placement='static'>4</vcpu>
      <os>
        <type arch='aarch64' machine='virt-rhel7.6.0'>hvm</type>
        <loader readonly='yes' type='pflash'>/usr/share/AAVMF/AAVMF_CODE.fd</loader>
        <nvram>/home/user1/.config/libvirt/qemu/nvram/CentOS7.6_VARS.fd</nvram>
        <boot dev='hd'/>
      </os>


参考一个qemu.conf [#qemu.conf]_ 的配置

.. code-block:: ini

    nvram = ["/usr/share/AAVMF/AAVMF_CODE.fd:/usr/share/AAVMF/AAVMF_VARS.fd"]

.. [#qemu.conf] https://github.com/libvirt/libvirt/blob/8e681cdab9a0c93208bbd7f1c8e82998356f4019/src/qemu/qemu.conf

