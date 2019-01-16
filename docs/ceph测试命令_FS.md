
ceph相关软件包下载地址  
https://download.ceph.com/debian-luminous/pool/main/c/ceph/ceph-fuse_12.2.8-1xenial_arm64.deb

1. node1（官方文档中也叫做admin节点）
	```ssh
	ceph osd pool create cephfs_data 8
	ceph osd pool create cephfs_metadata 8
	ceph osd  pool ls
	ceph fs new fs_on_ceph cephfs_metadata cephfs_data
	ceph fs ls
	ceph mds stat
	```
2. ceph-client
	```sh
	mkdir /mnt/mycephfs
	#不指定secret会失败
	root@ceph-client:/etc/ceph# mount -t ceph 192.168.1.152:6789:/ /mnt/mycephfs
	mount error 22 = Invalid argument
	root@ceph-client:/etc/ceph# mount -t ceph 192.168.1.152:6789:/ /mnt/mycephfs -o name=admin,secretfile=admin.secret
	unable to read secretfile: No such file or directory
	error reading secret file
	failed to parse ceph_options
	#创建secret文件
	root@ceph-client:/etc/ceph# cat ceph.client.admin.keyring
	[client.admin]
			key = AQD3Lzhc5CFsKhAAc96tJ1+b4iTQ+UCOa0By5g==
	root@ceph-client:/etc/ceph# echo "AQD3Lzhc5CFsKhAAc96tJ1+b4iTQ+UCOa0By5g==" > admin.secret
	root@ceph-client:/etc/ceph# ls
	admin.secret  ceph.client.admin.keyring  ceph.conf  rbdmap  tmpqWQidh
	root@ceph-client:/etc/ceph# cat admin.secret
	AQD3Lzhc5CFsKhAAc96tJ1+b4iTQ+UCOa0By5g==
	root@ceph-client:/etc/ceph#
	#挂在为内核驱动
	root@ceph-client:/etc/ceph# mount -t ceph 192.168.1.152:6789:/ /mnt/mycephfs -o name=admin,secretfile=admin.secret
	root@ceph-client:/etc/ceph#
	#查看挂在好的文件系统
	root@ceph-client:/etc/ceph# df -h
	Filesystem            Size  Used Avail Use% Mounted on
	udev                  1.9G     0  1.9G   0% /dev
	tmpfs                 395M  2.6M  392M   1% /run
	/dev/vda2              49G  4.6G   42G  10% /
	tmpfs                 2.0G     0  2.0G   0% /dev/shm
	tmpfs                 5.0M     0  5.0M   0% /run/lock
	tmpfs                 2.0G     0  2.0G   0% /sys/fs/cgroup
	/dev/vda1             512M  264K  512M   1% /boot/efi
	tmpfs                 395M     0  395M   0% /run/user/0
	/dev/rbd0             3.9G   16M  3.9G   1% /mnt/ceph-block-device
	/dev/rbd1              20G   11G  9.6G  52% /mnt/ceph-block-device-foo3
	192.168.1.152:6789:/   84G     0   84G   0% /mnt/mycephfs
	
	```