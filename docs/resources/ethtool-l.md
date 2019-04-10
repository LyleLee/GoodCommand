以下是ethtool在不同设备上的输出结果。

**board1**
```
Pre-set maximums:
RX:             4
TX:             4
Other:          0
Combined:       0
Current hardware settings:
RX:             4
TX:             1
Other:          0
Combined:       0
```
**board1-mainboard**
```
me@ubuntu:~$ ethtool -l enahisic2i0
Channel parameters for enahisic2i0:
Pre-set maximums:
RX:             16
TX:             16
Other:          0
Combined:       0
Current hardware settings:
RX:             16
TX:             16
Other:          0
Combined:       0
```
**board3**
```
[root@localhost ~]# ethtool -l enahisic2i0
Channel parameters for enahisic2i0:
Pre-set maximums:
RX:             16
TX:             16
Other:          0
Combined:       0
Current hardware settings:
RX:             16
TX:             16
Other:          0
Combined:       0
```

**board4**
```
root@ubuntu:~# ethtool -l enahisic2i1
Channel parameters for enahisic2i1:
Pre-set maximums:
RX:             16
TX:             16
Other:          0
Combined:       0
Current hardware settings:
RX:             16
TX:             16
Other:          0
Combined:       0
```

**board5-x86**
```
root@ubuntu:~# ethtool -l enp2s0f0
Channel parameters for enp2s0f0:
Pre-set maximums:
RX:             0
TX:             0
Other:          1
Combined:       63
Current hardware settings:
RX:             0
TX:             0
Other:          1
Combined:       63

```