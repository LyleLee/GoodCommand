查看内存大小
===================
# 总核数
总核数 = 物理CPU个数 X 每颗物理CPU的核数

# 总逻辑CPU数 
总逻辑CPU数 = 物理CPU个数 X 每颗物理CPU的核数 X 超线程数

# 查看物理CPU个数
cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l

# 查看每个物理CPU中core的个数(即核数)
cat /proc/cpuinfo| grep "cpu cores"| uniq

# 查看逻辑CPU的个数
cat /proc/cpuinfo| grep "processor"| wc -l



网上显示是32核的
processor:64

BoardSerer

物理核数量是2个。
每个物理核中的核数是18
逻辑CPU数量是72