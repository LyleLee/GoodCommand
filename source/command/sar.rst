*******************
sar
*******************


查看网络性能
========================


.. code-block:: shell
    
    sar -n DEV 1


.. code-block:: console

    Average:        IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s   rxcmp/s   txcmp/s  rxmcst/s   %ifutil
    Average:     enp139s0    531.83    543.08    701.08    695.39      0.00      0.00      0.00      0.06
    Average:    enp125s0f2      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
    Average:    enp125s0f3      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
    Average:    enp125s0f1      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
    Average:    enp125s0f0     27.57     48.99      1.96      5.88      0.00      0.00      0.00      0.00
    Average:     enp131s0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
    Average:     enp138s0  32810.45  19189.66   3207.88 685787.70      0.00      0.00      0.00     56.18
    Average:     enp140s0    500.32    513.04    667.00    663.98      0.00      0.00      0.00      0.05
    Average:        bond1   1032.14   1056.12   1368.08   1359.36      0.00      0.00      0.00      0.06
    Average:           lo     98.53     98.53    244.92    244.92      0.00      0.00      0.00      0.00
    Average:        bond0  66661.68  39426.31   6489.19 1411346.36      0.00      0.00      0.00     57.81
    Average:     enp134s0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
    Average:     enp137s0  33851.24  20236.65   3281.31 725558.67      0.00      0.00      0.00     59.44
    Average:     enp133s0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
    Average:     enp132s0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00


查看缺页中断
========================

.. code-block:: shell
    
    sar -B 1

.. code-block:: console

    12:44:19 AM  pgpgin/s pgpgout/s   fault/s  majflt/s  pgfree/s pgscank/s pgscand/s pgsteal/s    %vmeff
    12:44:21 AM      0.00      0.00   1567.50      0.00  10067.50      0.00      0.00      0.00      0.00
    12:44:23 AM      0.00      0.00    308.00      0.00  57089.50      0.00      0.00      0.00      0.00
    12:44:25 AM      0.00      0.00   1854.00      0.00  58106.00      0.00      0.00      0.00      0.00
    12:44:27 AM      0.00      0.00    681.50      0.00 136089.50      0.00      0.00      0.00      0.00
    12:44:29 AM      0.00      0.00    395.00      0.00  84721.00      0.00      0.00      0.00      0.00
    12:44:31 AM      0.00      0.00   1826.00      0.00  92157.00      0.00      0.00      0.00      0.00
    12:44:33 AM      0.00      0.00    307.00      0.00   9526.50      0.00      0.00      0.00      0.00
    12:44:35 AM      0.00      0.00   1136.50      0.00   9094.00      0.00      0.00      0.00      0.00
    12:44:37 AM      0.00     12.00    684.50      0.00   7098.00      0.00      0.00      0.00      0.00
    12:44:39 AM      0.00      0.00   1980.50      0.00  59208.00      0.00      0.00      0.00      0.00


Where,

3 = interval
10 = count

To view process creation statistics, enter:
# sar -c 3 10

To view I/O and transfer rate statistics, enter:
# sar -b 3 10

To view paging statistics, enter:
# sar -B 3 10

To view block device statistics, enter:
# sar -d 3 10

To view statistics for all interrupt statistics, enter:
# sar -I XALL 3 10

To view device specific network statistics, enter:
# sar -n DEV 3 10
# sar -n EDEV 3 10

To view CPU specific statistics, enter:
# sar -P ALL
# Only 1st CPU stats
# sar -P 1 3 10

To view queue length and load averages statistics, enter:
# sar -q 3 10

To view memory and swap space utilization statistics, enter:
# sar -r 3 10
# sar -R 3 10

To view status of inode, file and other kernel tables statistics, enter:
# sar -v 3 10

To view system switching activity statistics, enter:
# sar -w 3 10

To view swapping statistics, enter:
# sar -W 3 10

To view statistics for a given process called Apache with PID # 3256, enter:
# sar -x 3256 3 10


.. [#sar_ksar] https://www.cyberciti.biz/tips/identifying-linux-bottlenecks-sar-graphs-with-ksar.html
