**********************
bcache
**********************

bcache的回写模式：

writethrough
    既写SSD也写HDD， 读如果命中，就可以直接从SSD中读，适用于读多写少的场景

writearound
    绕过SSD直接写HDD。

writeback
    全部写SSD，后台刷脏数据。



删除bcache之后重新写一遍硬盘dd_wipe_disk.sh

.. code-block:: shell

    #!/bin/bash

    for i in {a..t};
    do
            echo sd$i
            dd if=/dev/zero of=/dev/sd$i bs=1M count=1
    done

    for ssd in v w x y;
    do
            for i in {11..15};
            do
                    echo sd$ssd$i
                    dd if=/dev/zero of=/dev/sd"$ssd""$i" bs=1M count=1
            done
    done



6.2.1        划分db、wal分区
每个NVME盘划分为8个60G分区，分布4个用来作为db分区，4个用来作为wal分区。命令如下。

parted -s /dev/nvme0n1  mklabel gpt
parted -s /dev/nvme1n1  mklabel gpt

 

start=0

# 划分为八个60G分区

.. code-block:: shell

    end=`expr $start + 60000`
    parted /dev/nvme0n1 mkpart primary xfs 2048s $end
    parted /dev/nvme1n1 mkpart primary xfs 2048s $end
    start=$end
    for i in {1..7}
    do
        end=`expr $start + 60000`
        parted /dev/nvme0n1 mkpart primary xfs $start $end
        parted /dev/nvme1n1 mkpart primary xfs $start $end
        start=$end
    done 


6.2.2        划分bcache分区
每个NVME盘划分为4个680G分区，用来作为bcache分区。

命令如下，由于分区的起始点设置，该命令必须接上面命令执行，否则会出错。

code-block:: shell

    for i in {1..4}

    do

        end=`expr $start + 680000`

        parted /dev/nvme0n1 mkpart primary xfs $start $end

        parted /dev/nvme1n1 mkpart primary xfs $start $end

        start=$end

    done

 

6.3      配置bcache
NVME0盘作为sda、sdb、sdc、sdd四个数据盘的cache，而NVME1作为sde、sdf、sdg、sdh四个数据盘的cache。

在四个节点中执行如下命令，完成bcache的配置。

for i in {0..7}

do

 

        temp=`expr $i % 8 + 97`

        diskID=$(printf \\x`printf %x ${temp}`)

 

        temp=`expr $i % 4  + 9`

        #echo $temp

 

        if (( $i < 4 ))

        then

                bcacheID="/dev/nvme0n1p${temp}"

        else

                bcacheID="/dev/nvme1n1p${temp}"

        fi

 

        #echo $diskID,$bcacheID

        make-bcache --wipe-bcache -B /dev/sd${diskID} -C ${bcacheID}

 

done

       以上make-bcache命令中的-B选项后面对应的是后置的数据盘，-C选项后面对应的是作为数据盘的缓存盘。

对所有的bcache分区需要格式化，命令如下。

for i in {0..7}

do

       mkfs.xfs  /dev/bcache$i

done

可通过lsblk命令查看bcache是否创建成功。

bcache默认策略是writethrough，需修改为writeback，可提升写性能，命令如下。

for i in `ls /dev/ | grep -i bcache`; do echo writeback > /sys/block/$i/bcache/cache_mode ; done;






https://ypdai.github.io/2018/07/13/bcache%E9%85%8D%E7%BD%AE%E4%BD%BF%E7%94%A8/

https://www.kernel.org/doc/Documentation/bcache.txt
