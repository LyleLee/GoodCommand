********************
parted
********************

parted /dev/sdv mkpart primary 0.0GB 30.0GB
parted /dev/sdv mkpart primary 30.0GB 60.0GB
parted /dev/sdv mkpart primary 60.0GB 75.0GB
parted /dev/sdv mkpart primary 75.0GB 90.0GB
parted /dev/sdv mkpart primary 90.0GB 490.0GB
parted /dev/sdv mkpart primary 490.0GB 890.0GB

warning the resulting partition is not properly aligned for best performance


如何获得扇区最好性能
====================


# cat /sys/block/sdb/queue/optimal_io_size
1048576
# cat /sys/block/sdb/queue/minimum_io_size
262144
# cat /sys/block/sdb/alignment_offset
0
# cat /sys/block/sdb/queue/physical_block_size
512
Add optimal_io_size to alignment_offset and divide the result by physical_block_size. In my case this was (1048576 + 0) / 512 = 2048.
This number is the sector at which the partition should start. Your new parted command should look like
mkpart primary 2048s 100%


https://rainbow.chard.org/2013/01/30/how-to-align-partitions-for-best-performance-using-parted/


parted -a optimal /dev/sda mkpart primary 0% 4096MB