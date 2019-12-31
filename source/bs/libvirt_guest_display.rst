***************************
libvirt guest display
***************************

.. image:: ../customer/images/科大讯飞3_libvirt.png


解决办法：

.. code-block:: shell

    virt-install \
      --name CentOS7.6 \
      --os-variant "centos7.0" \
      --memory 8192 \
      --vcpus 4 \
      --disk size=20 \
      --graphics vnc,listen=0.0.0.0,keymap=en-us \
      --location /home/user1/CentOS-7-aarch64-Minimal-1810.iso \
      --extra-args console=ttyS0


.. code-block:: xml

    <graphics type='vnc' port='5904' autoport='no' listen='0.0.0.0'>

      <listen type='address' address='0.0.0.0'/>
      </graphics>
