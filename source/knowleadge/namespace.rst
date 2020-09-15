******************************
namespace
******************************

namespace 是实现进程资源隔离的技术。 目前linux支持的namespace有cgroup_namespaces、ipc_namespaces、network_namespaces、
mount_namespaces、pid_namespaces、time_namespaces、user_namespaces、uts_namespaces。

这里记录一下mount_namespace ::

    sudo unshare -m --propagation unchanged

上述在shell中创建并进入新的mount namespace。 这个时候执行unmount和mount操作，在其他namespace中不会察觉到。