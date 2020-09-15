*************************
put a program in jail
*************************

思路是：

1. 创建namespace
2. 创建veth pair， 一个放到namespace里面， 一个在默认的root namespace
3. 两个veth都配上ip
4. root namespace的iptables上添加规则。
5. 从veth捕捉来自namespace中的流量


::

    sudo ip link add vetha type veth peer name vethb
    sudo ip link set vethb netns test
    sudo ip netns exec test ip link add 10.8.8.2/24 dev vethb
    sudo ip netns exec test ip link set vethb up
    sudo ip netns exec test ip link set lo up
    sudo ip netns exec test ip route add default via 10.8.8.1 dev vethb
    sudo ip addr add  10.8.8.1/24 dev vetha
    sudo ip link set vetha up

    sudo iptables -t nat -A POSTROUTING -s 10.10.10.0/24 ! -o vetha -j MASQUERADE
    sudo iptables -A FORWARD -i vetha -j ACCEPT
    sudo iptables -A FORWARD -o vetha -j ACCEPT


reexec is part of the Docker codebase and provides a convenient way for an executable to “re-exec” itself

reexec [#reexec]_ 是一个Docker基础代码中进程重新执行自己的方便方式。

.. code-block:: go

    cmd := exec.Command("/bin/echo", "Process already running")
    cmd.SysProcAttr = &syscall.SysProcAttr{
        Cloneflags: syscall.CLONE_NEWUTS,
    }
    cmd.Run()

Once cmd.Run() is called, the namespaces get cloned and then the process gets started straight away.
There’s no hook or anything here that allows us to run code after the namespace creation but before the process starts.
This is where reexec comes in.

这是我们创建进程通常的方式，问题是，一旦 cmd.Run() 被调用，新的命名空间就会被创建，进程/bin/echo开始在新的命名空间中执行，这里没有回调或者什么东西可以
让我们可以在namspace创建之后，进程没有执行之前执行我们想要执行的代码， 比如设置新的hostname。

.. [#namespace_jail] capture all packets inside namespace https://blogs.igalia.com/dpino/2016/04/10/network-namespaces/
.. [#create_veth] create veth pair with go https://medium.com/@teddyking/namespaces-in-go-network-fdcf63e76100
.. [#netns] https://pkg.go.dev/github.com/vishvananda/netns?tab=overview
.. [#teddyking] https://github.com/teddyking/ns-process
.. [#how_to_save] https://golangnews.org/2020/03/network-namespaces-from-go/
.. [#gopacket] https://www.devdungeon.com/content/packet-capture-injection-and-analysis-gopacket
.. [#reexec] https://medium.com/@teddyking/namespaces-in-go-reexec-3d1295b91af8