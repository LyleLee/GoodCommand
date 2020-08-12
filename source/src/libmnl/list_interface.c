#include <libmnl/libmnl.h>
#include <linux/netlink.h> //NETLINK_ROUTE


int main()
{
    //打开socket，传入 netlink socket bus ID 具体可以查看 include/linux/netlink.h中的定义
    struct mnl_socket *nl_sock = mnl_socket_open(NETLINK_ROUTE);//

}