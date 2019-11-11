********************************
ceph-volume failed
********************************

::

   [root@hadoop00 ceph]# ceph-deploy osd create --data /dev/sdg ceph-node04
   [ceph_deploy.conf][DEBUG ] found configuration file at: /root/.cephdeploy.conf
   [ceph_deploy.cli][INFO  ] Invoked (2.0.1): /bin/ceph-deploy osd create --data /dev/sdg ceph-node04
   [ceph_deploy.cli][INFO  ] ceph-deploy options:
   [ceph_deploy.cli][INFO  ]  verbose                       : False
   [ceph_deploy.cli][INFO  ]  bluestore                     : None
   [ceph_deploy.cli][INFO  ]  cd_conf                       : <ceph_deploy.conf.cephdeploy.Conf instance at 0x400020f504d0>
   [ceph_deploy.cli][INFO  ]  cluster                       : ceph
   [ceph_deploy.cli][INFO  ]  fs_type                       : xfs
   [ceph_deploy.cli][INFO  ]  block_wal                     : None
   [ceph_deploy.cli][INFO  ]  default_release               : False
   [ceph_deploy.cli][INFO  ]  username                      : None
   [ceph_deploy.cli][INFO  ]  journal                       : None
   [ceph_deploy.cli][INFO  ]  subcommand                    : create
   [ceph_deploy.cli][INFO  ]  host                          : ceph-node04
   [ceph_deploy.cli][INFO  ]  filestore                     : None
   [ceph_deploy.cli][INFO  ]  func                          : <function osd at 0x400020ee7d70>
   [ceph_deploy.cli][INFO  ]  ceph_conf                     : None
   [ceph_deploy.cli][INFO  ]  zap_disk                      : False
   [ceph_deploy.cli][INFO  ]  data                          : /dev/sdg
   [ceph_deploy.cli][INFO  ]  block_db                      : None
   [ceph_deploy.cli][INFO  ]  dmcrypt                       : False
   [ceph_deploy.cli][INFO  ]  overwrite_conf                : False
   [ceph_deploy.cli][INFO  ]  dmcrypt_key_dir               : /etc/ceph/dmcrypt-keys
   [ceph_deploy.cli][INFO  ]  quiet                         : False
   [ceph_deploy.cli][INFO  ]  debug                         : False
   [ceph_deploy.osd][DEBUG ] Creating OSD on cluster ceph with data device /dev/sdg
   [ceph-node04][DEBUG ] connected to host: ceph-node04
   [ceph-node04][DEBUG ] detect platform information from remote host
   [ceph-node04][DEBUG ] detect machine type
   [ceph-node04][DEBUG ] find the location of an executable
   [ceph_deploy.osd][INFO  ] Distro info: CentOS Linux 7.6.1810 AltArch
   [ceph_deploy.osd][DEBUG ] Deploying osd to ceph-node04
   [ceph-node04][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
   [ceph-node04][DEBUG ] find the location of an executable
   [ceph-node04][INFO  ] Running command: /usr/sbin/ceph-volume --cluster ceph lvm create --bluestore --data /dev/sdg
   [ceph-node04][WARNIN] -->  RuntimeError: command returned non-zero exit status: 5
   [ceph-node04][DEBUG ] Running command: /bin/ceph-authtool --gen-print-key
   [ceph-node04][DEBUG ] Running command: /bin/ceph --cluster ceph --name client.bootstrap-osd --keyring /var/lib/ceph/bootstrap-osd/ceph.keyring -i - osd new b45fb23e-6ece-4167-b77f-ce641a09afc4
   [ceph-node04][DEBUG ] Running command: /usr/sbin/vgcreate -s 1G --force --yes ceph-23bda46f-44e4-4eb5-85f0-d57d7f6ea07f /dev/sdg
   [ceph-node04][DEBUG ]  stderr: Physical volume '/dev/sdg' is already in volume group 'ceph-0a29c94d-5e18-4821-969f-5094af730297'
   [ceph-node04][DEBUG ]   Unable to add physical volume '/dev/sdg' to volume group 'ceph-0a29c94d-5e18-4821-969f-5094af730297'
   [ceph-node04][DEBUG ]   /dev/sdg: physical volume not initialized.
   [ceph-node04][DEBUG ] --> Was unable to complete a new OSD, will rollback changes
   [ceph-node04][DEBUG ] Running command: /bin/ceph --cluster ceph --name client.bootstrap-osd --keyring /var/lib/ceph/bootstrap-osd/ceph.keyring osd purge-new osd.31 --yes-i-really-mean-it
   [ceph-node04][DEBUG ]  stderr: 2019-07-25 00:33:16.572 ffff6fd0c200 -1 auth: unable to find a keyring on /etc/ceph/ceph.client.bootstrap-osd.keyring,/etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin,: (2) No such file or directory
   [ceph-node04][DEBUG ] 2019-07-25 00:33:16.572 ffff6fd0c200 -1 AuthRegistry(0xffff68063c48) no keyring found at /etc/ceph/ceph.client.bootstrap-osd.keyring,/etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin,, disabling cephx
   [ceph-node04][DEBUG ]  stderr: purged osd.31
   [ceph-node04][ERROR ] RuntimeError: command returned non-zero exit status: 1
   [ceph_deploy.osd][ERROR ] Failed to execute command: /usr/sbin/ceph-volume --cluster ceph lvm create --bluestore --data /dev/sdg
   [ceph_deploy][ERROR ] GenericError: Failed to create 1 OSDs

解决办法
https://docs.oracle.com/cd/E52668_01/E96266/html/ceph-luminous-issues-27748402.html
