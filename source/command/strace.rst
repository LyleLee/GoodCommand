**********************
strace
**********************

strace 跟踪程序的系统调用

有几个参数

-t      来显示每个调用执行的时间
-T      来显示调用中花费的时间


strace 可以指定事件 [#namespace-ip-netns]_ ::

    strace -e open,unshare,setns,mount,umount2 ip netns exec ns1 cat /etc/whatever 2>&1

.. [#namespace-ip-netns] https://unix.stackexchange.com/questions/471122/namespace-management-with-ip-netns-iproute2/471214#471214
