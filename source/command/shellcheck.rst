ShellCheck
==========

ShellCheck 是一个shell脚本静态分析工具

写个脚本，一直要到运行时才能知道是什么错误，
不知道会在调试过程要反复执行多少次。
中途还可能产生中间文件，命令不正确很多文件，所以，写完后检查一下吧

.. code-block:: console

   me@ubuntu:~/virtual_machine$ shellcheck get_vm_ip.sh

   In get_vm_ip.sh line 8:
                   mac=$(virsh domiflist $vm | awk 'NR !=1 {print $5}')
                                         ^-- SC2086: Double quote to prevent globbing and word splitting.


   In get_vm_ip.sh line 9:
                   ip_match=$(arp -na | grep $mac | awk '{print $2}')
                                             ^-- SC2086: Double quote to prevent globbing and word splitting.
