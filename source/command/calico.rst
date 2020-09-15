********************
calico
********************


::

    [root@master1 ~]# ./calicoctl-linux-arm64 node status
    Calico process is running.

    IPv4 BGP status
    +-----------------+-------------------+-------+----------+-------------+
    |  PEER ADDRESS   |     PEER TYPE     | STATE |  SINCE   |    INFO     |
    +-----------------+-------------------+-------+----------+-------------+
    | 192.168.122.103 | node-to-node mesh | up    | 01:38:37 | Established |
    | 192.168.122.104 | node-to-node mesh | up    | 01:39:00 | Established |
    +-----------------+-------------------+-------+----------+-------------+

    IPv6 BGP status
    No IPv6 peers found.

    [root@master1 ~]#



问题： /bin/sh: clang: not found
====================================

::

    [WARN  tini (6)] Tini is not running as PID 1 and isn't registered as a child subreaper.
    Zombie processes will not be re-parented to Tini, so zombie reaping won't work.
    To fix the problem, use the -s option or set the environment variable TINI_SUBREAPER to register Tini as a child subreaper, or run Tini as PID 1.
    Starting with UID : 1000
    make: Entering directory '/go/src/github.com/projectcalico/node/bin/bpf/bpf-apache'
    /bin/sh: clang: not found
    make: *** [Makefile:52: sockops.d] Error 127
    make: *** Waiting for unfinished jobs....
    /bin/sh: clang: not found
    make: *** [Makefile:52: redir.d] Error 127
    /bin/sh: clang: not found
    make: *** [Makefile:52: filter.d] Error 127
    make: Leaving directory '/go/src/github.com/projectcalico/node/bin/bpf/bpf-apache'
    Makefile:150: recipe for target 'remote-deps' failed
    make: *** [remote-deps] Error 2

::

    apt install clang


问题： <built-in>'/include/generated/uapi/linux/version.h' file not found
============================================================================

::

    set -e; rm -f connect_balancer.d; \
            clang -M -x c -D__KERNEL__ -D__ASM_SYSREG_H -D__LINUX_BPF_H__ -Wno-unused-value -Wno-pointer-sign -Wno-compare-distinct-pointer-types -Wunused -Wall -fno-stack-protector -O2 -emit-llvm --include=/usr/src/linux-headers-5.6.0-0.bpo.2-common/include/uapi/linux/bpf.h --include=/include/generated/uapi/linux/version.h connect_balancer.c > connect_balancer.d.$$ || { rm -f connect_balancer.d.$$; false; } ; \
            sed 's,\(connect_balancer\)\.o[ :]*,\1.o connect_balancer.d : ,g' < connect_balancer.d.$$ > connect_balancer.d; \
            rm -f connect_balancer.d.$$
    set -e; rm -f tc.d; \
            clang -M -x c -D__KERNEL__ -D__ASM_SYSREG_H -D__LINUX_BPF_H__ -Wno-unused-value -Wno-pointer-sign -Wno-compare-distinct-pointer-types -Wunused -Wall -fno-stack-protector -O2 -emit-llvm --include=/usr/src/linux-headers-5.6.0-0.bpo.2-common/include/uapi/linux/bpf.h --include=/include/generated/uapi/linux/version.h tc.c > tc.d.$$ || { rm -f tc.d.$$; false; } ; \
            sed 's,\(tc\)\.o[ :]*,\1.o tc.d : ,g' < tc.d.$$ > tc.d; \
            rm -f tc.d.$$
    <built-in>:2:10: fatal error: <built-in>'/include/generated/uapi/linux/version.h' file not found:
    2:10: fatal error: '/include/generated/uapi/linux/version.h' file not found
    #include "/include/generated/uapi/linux/version.h"
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #include "/include/generated/uapi/linux/version.h"
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1 error generated.
    make: *** [Makefile:105: tc.d] Error 1
    make: *** Waiting for unfinished jobs....
    1 error generated.
    make: *** [Makefile:105: connect_balancer.d] Error 1
    make: Leaving directory '/go/src/github.com/projectcalico/node/bin/bpf/bpf-gpl'
    Makefile:150: recipe for target 'remote-deps' failed
    make: *** [remote-deps] Error 2
