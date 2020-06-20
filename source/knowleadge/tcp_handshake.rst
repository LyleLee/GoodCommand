***************************
tcp 三次握手
***************************


访问百度的情况

::

    curl www.baidu.com


::

    user1@intel6248:~/jail-program/pcab/decode_fast$ sudo tcpdump -i eno3 tcp and not port 22 -n
    tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
    listening on eno3, link-type EN10MB (Ethernet), capture size 262144 bytes
    03:37:03.032235 IP 192.168.1.203.40534 > 103.235.46.39.80: Flags [S], seq 245004369, win 64240, options [mss 1460,sackOK,TS val 2783094696 ecr 0,nop,wscale 7], length 0
    03:37:03.039428 IP 103.235.46.39.80 > 192.168.1.203.40534: Flags [S.], seq 1556435673, ack 245004370, win 8192, options [mss 1436,sackOK,nop,nop,nop,nop,nop,nop,nop,nop,nop,nop,nop,wscale 5], length 0
    03:37:03.039489 IP 192.168.1.203.40534 > 103.235.46.39.80: Flags [.], ack 1, win 502, length 0
    03:37:03.039540 IP 192.168.1.203.40534 > 103.235.46.39.80: Flags [P.], seq 1:78, ack 1, win 502, length 77: HTTP: GET / HTTP/1.1
    03:37:03.046848 IP 103.235.46.39.80 > 192.168.1.203.40534: Flags [.], ack 78, win 776, length 0
    03:37:03.057934 IP 103.235.46.39.80 > 192.168.1.203.40534: Flags [P.], seq 1:1449, ack 78, win 776, length 1448: HTTP: HTTP/1.1 200 OK
    03:37:03.057958 IP 192.168.1.203.40534 > 103.235.46.39.80: Flags [.], ack 1449, win 495, length 0
    03:37:03.058520 IP 103.235.46.39.80 > 192.168.1.203.40534: Flags [.], seq 1449:2749, ack 78, win 776, length 1300: HTTP
    03:37:03.058561 IP 192.168.1.203.40534 > 103.235.46.39.80: Flags [.], ack 2749, win 501, length 0
    03:37:03.058582 IP 103.235.46.39.80 > 192.168.1.203.40534: Flags [P.], seq 2749:2782, ack 78, win 776, length 33: HTTP
    03:37:03.058590 IP 192.168.1.203.40534 > 103.235.46.39.80: Flags [.], ack 2782, win 501, length 0
    03:37:03.058718 IP 192.168.1.203.40534 > 103.235.46.39.80: Flags [F.], seq 78, ack 2782, win 501, length 0
    03:37:03.065788 IP 103.235.46.39.80 > 192.168.1.203.40534: Flags [.], ack 79, win 776, length 0
    03:37:03.065912 IP 103.235.46.39.80 > 192.168.1.203.40534: Flags [F.], seq 2782, ack 79, win 776, length 0
    03:37:03.065939 IP 192.168.1.203.40534 > 103.235.46.39.80: Flags [.], ack 2783, win 501, length 0
    ^C
    15 packets captured
    15 packets received by filter
    0 packets dropped by kernel



TCP 建立连接

1. 客户端发送SYN数据包  [S], seq 245004369
2. 服务器发送SYN数据包  [S.], seq 1556435673, ack 245004370,
3. 客户端发送确认数据包  [.], ack 1


TCP 结束

1. 客户端发送关闭请求 [F.], seq 78, ack 2782
2. 服务端发送确认关闭 [.], ack 79, win 776, length 0
3. 服务端发送关闭请求 [F.], seq 2782, ack 79,
4. 客户端发送确认关闭 [.], ack 2783,