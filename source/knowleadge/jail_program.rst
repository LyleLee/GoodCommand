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


.. [#namespace_jail] capture all packets inside namespace https://blogs.igalia.com/dpino/2016/04/10/network-namespaces/
.. [#create_veth] create veth pair with go https://medium.com/@teddyking/namespaces-in-go-network-fdcf63e76100
.. [#netns] https://pkg.go.dev/github.com/vishvananda/netns?tab=overview
.. [#teddyking] https://github.com/teddyking/ns-process
.. [#how_to_save] https://golangnews.org/2020/03/network-namespaces-from-go/
.. [#gopacket] https://www.devdungeon.com/content/packet-capture-injection-and-analysis-gopacket
