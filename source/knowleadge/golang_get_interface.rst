***********************************
golang 列出网络接口
***********************************

在golang中如何列出主机上的所有网络接口，一个方法是使用net包

.. code-block:: go

	package main

	import (
		"fmt"
		"net"
	)

	func main() {
		ifaces, err := net.Interfaces()
		if err != nil {
			fmt.Print(fmt.Errorf("localAddresses: %+v\n", err.Error()))
			return
		}
		for _, iface := range ifaces {
			fmt.Printf("interfaces is : %v\n", iface)
		}
	}


::

	interfaces is : {1 65536 lo  up|loopback}
	interfaces is : {2 1500 eno1 cc:64:a6:5c:d0:d3 up|broadcast|multicast}
	interfaces is : {3 1500 eno2 cc:64:a6:5c:d0:d4 up|broadcast|multicast}
	interfaces is : {4 1500 eno3 cc:64:a6:5c:d0:d5 up|broadcast|multicast}
	interfaces is : {5 1500 eno4 cc:64:a6:5c:d0:d6 up|broadcast|multicast}
	interfaces is : {6 1500 ens3f0 28:41:c6:aa:53:34 up|broadcast|multicast}
	interfaces is : {7 1500 ens3f1 28:41:c6:aa:53:35 up|broadcast|multicast}
	interfaces is : {8 1500 docker0 02:42:34:eb:e9:e1 up|broadcast|multicast}
	interfaces is : {14 1500 vethf0cc960 d2:24:7c:67:95:d2 up|broadcast|multicast}
	interfaces is : {20 1500 veth17de1fd 0a:8f:dc:9e:fc:3b up|broadcast|multicast}
	interfaces is : {44 1500 vetha43a667 72:ce:b7:51:25:50 up|broadcast|multicast}


或者使用netlink包

.. code-block:: go

	package main

	import (
		"fmt"
		"github.com/vishvananda/netlink"
	)

	func main() {
		enos, err := netlink.LinkList()
		if err != nil {
			fmt.Println("get link list error")
			fmt.Println(err)
			return
		}
		for _, eno := range enos {
			attr := eno.Attrs()
			fmt.Println("interface is ", eno.Type(), attr.Index, attr.MTU, attr.Name, attr.HardwareAddr, attr.HardwareAddr)
		}
	}
