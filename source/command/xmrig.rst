***************
xmrig
***************

.. code-block:: console

    [root@ceph-test ~]# top
    top - 09:51:07 up 96 days, 18:41,  5 users,  load average: 33.12, 33.05, 32.70
    Tasks: 502 total,   1 running, 501 sleeping,   0 stopped,   0 zombie
    %Cpu(s): 80.6 us,  0.2 sy,  0.0 ni, 19.2 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
    KiB Mem : 13145172+total, 12133246+free,  6652620 used,  3466644 buff/cache
    KiB Swap:  4194300 total,  4194300 free,        0 used. 12382584+avail Mem

      PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
    19448 root      20   0 7414624  19448   4052 S  3202  0.0  46611,49 xmrig
    12776 polkitd   20   0  619916  16748   5368 S  11.3  0.0   9696:38 polkitd
    12805 dbus      20   0   71044   4492   1940 S   7.9  0.0   7093:01 dbus-daemon
    12771 root      20   0  396456   4432   3292 S   7.6  0.0   6953:54 accounts-daemon
    16853 root      20   0  456840   3812   2876 S   3.0  0.0   2515:04 gsd-account
    16832 root      20   0  648660  32244   9184 S   0.7  0.0 207:15.28 gsd-color
       95 root      20   0       0      0      0 S   0.3  0.0   0:52.62 ksoftirqd/17
    30552 root      20   0  162408   2768   1632 R   0.3  0.0   0:00.73 top
        1 root      20   0  196624   9832   4208 S   0.0  0.0   9:27.29 systemd
        2 root      20   0       0      0      0 S   0.0  0.0   0:02.33 kthreadd
        3 root      20   0       0      0      0 S   0.0  0.0   0:01.32 ksoftirqd/0
        5 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/0:0H
        8 root      rt   0       0      0      0 S   0.0  0.0   0:00.62 migration/0
        9 root      20   0       0      0      0 S   0.0  0.0   0:00.00 rcu_bh
       10 root      20   0       0      0      0 S   0.0  0.0  77:39.05 rcu_sched
       11 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 lru-add-drain
       12 root      rt   0       0      0      0 S   0.0  0.0   0:14.34 watchdog/0
       13 root      rt   0       0      0      0 S   0.0  0.0   0:13.84 watchdog/1


怀疑是挖矿程序