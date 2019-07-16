ceph ntp问题
====================

# 问题描述
ceph集群出现时间不同步问题

```
[root@ceph-node00 ~]# ceph -s
  cluster:
    id:     6534efb5-b842-40ea-b807-8e94c398c4a9
    health: HEALTH_WARN
            clock skew detected on mon.ceph-node01, mon.ceph-node06, mon.ceph-node07, mon.ceph-node02
```

# 定位过程
查看系统的ntp服务，没有启动。一般CentOS、redhat上ntp使用ntpd或者chrony提供时钟同步服务。

```
[root@ceph-node00 ~]# ntp
ntpd        ntpdate     ntpdc       ntp-keygen  ntpq        ntpstat     ntptime
[root@ceph-node00 ~]# ntp
ntpd        ntpdate     ntpdc       ntp-keygen  ntpq        ntpstat     ntptime
[root@ceph-node00 ~]# ps aux | grep ntpd
root     2529479  0.0  0.0 109656  1876 pts/2    S+   11:36   0:00 grep --color=auto ntpd
[root@ceph-node00 ~]#
[root@ceph-node00 ~]# systemctl | grep ntpd
[root@ceph-node00 ~]#
[root@ceph-node00 ~]# systemctl | grep chrony
[root@ceph-node00 ~]#

```
ceph 默认配置允许最大50ms漂移 
```
cepph --admin-daemon ./ceph-mon.ceph-node01.asok config show | grep clock
 "mon_clock_drift_allowed": "0.050000",
 "mon_clock_drift_warn_backoff": "5.000000",
```

# 建议措施

1. 启动ntpd
```
service start ntpd
```
2. 若现象未消失：将时钟写到物理时钟。
```
timedatectl set-local-rtc 1
```
3. 若无法解决，可以考虑设置ceph允许的最大时钟漂移

```
[mon]
mon_clock_drift_allowed = 0.10
mon clock drift warn backoff = 10
```