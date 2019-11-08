ebbchar error
===================

::

   [Tue Aug  6 20:51:23 2019] EBBChar: Initializing the EBBChar LKM
   [Tue Aug  6 20:51:23 2019] EBBChar: registered correctly with major number 240
   [Tue Aug  6 20:51:23 2019] EBBChar: device class registered correctly
   [Tue Aug  6 20:51:23 2019] EBBChar: device class created correctly
   [Tue Aug  6 20:51:38 2019] EBBChar: Device has been opened 1 time(s)
   [Tue Aug  6 20:51:51 2019] Internal error: Accessing user space memory outside uaccess.h routines: 96000004 [#3] SMP
   [Tue Aug  6 20:51:51 2019] Modules linked in: ebbchar(OE) binfmt_misc nls_iso8859_1 joydev input_leds ipmi_ssif shpchp ipmi_si ipmi_devintf ipmi_msghandler sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi nfsd auth_rpcgss nfs_acl lockd grace sunrpc ppdev lp parport ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear hid_generic ses enclosure usbhid hid marvell hibmc_drm ttm aes_ce_blk drm_kms_helper aes_ce_cipher crc32_ce syscopyarea crct10dif_ce sysfillrect ghash_ce sysimgblt sha2_ce fb_sys_fops sha256_arm64 sha1_ce drm hisi_sas_v2_hw hisi_sas_main ehci_platform libsas scsi_transport_sas hns_dsaf hns_enet_drv hns_mdio hnae aes_neon_bs aes_neon_blk
   [Tue Aug  6 20:51:51 2019]  crypto_simd cryptd aes_arm64 [last unloaded: ebbchar]
   [Tue Aug  6 20:51:51 2019] CPU: 51 PID: 20412 Comm: test Tainted: G      D W  OE    4.15.0-29-generic #31-Ubuntu
   [Tue Aug  6 20:51:51 2019] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.58 10/24/2018
   [Tue Aug  6 20:51:51 2019] pstate: 20400005 (nzCv daif +PAN -UAO)
   [Tue Aug  6 20:51:51 2019] pc : string+0x28/0xa0
   [Tue Aug  6 20:51:51 2019] lr : vsnprintf+0x5d4/0x730
   [Tue Aug  6 20:51:51 2019] sp : ffff00001c013c90
   [Tue Aug  6 20:51:51 2019] x29: ffff00001c013c90 x28: ffff000000b650b2
   [Tue Aug  6 20:51:51 2019] x27: ffff000000b650b2 x26: ffff000000b66508
   [Tue Aug  6 20:51:51 2019] x25: 00000000ffffffd8 x24: 0000000000000020
   [Tue Aug  6 20:51:51 2019] x23: 000000007fffffff x22: ffff0000094f8000
   [Tue Aug  6 20:51:51 2019] x21: ffff000008c54b00 x20: ffff000080b66507
   [Tue Aug  6 20:51:51 2019] x19: ffff000000b66508 x18: 0000ffff7f758a70
   [Tue Aug  6 20:51:51 2019] x17: 0000ffff7f6c7b80 x16: ffff0000082e3a80
   [Tue Aug  6 20:51:51 2019] x15: 0000000000000000 x14: 0000000000000001
   [Tue Aug  6 20:51:51 2019] x13: 726576726573204d x12: 5241206e6f207473
   [Tue Aug  6 20:51:51 2019] x11: ffff00001c013dd0 x10: ffff00001c013dd0
   [Tue Aug  6 20:51:51 2019] x9 : 00000000ffffffd0 x8 : fffffffffffffffe
   [Tue Aug  6 20:51:51 2019] x7 : ffff000000b66508 x6 : 0000ffffee48e258
   [Tue Aug  6 20:51:51 2019] x5 : 0000000000000000 x4 : 0000000000000043
   [Tue Aug  6 20:51:51 2019] x3 : ffff0a00ffffff04 x2 : ffff000080b66507
   [Tue Aug  6 20:51:51 2019] x1 : ffff000080b66507 x0 : ffffffffffffffff
   [Tue Aug  6 20:51:51 2019] Process test (pid: 20412, stack limit = 0x00000000c3b1dafa)
   [Tue Aug  6 20:51:51 2019] Call trace:
   [Tue Aug  6 20:51:51 2019]  string+0x28/0xa0
   [Tue Aug  6 20:51:51 2019]  vsnprintf+0x5d4/0x730
   [Tue Aug  6 20:51:51 2019]  sprintf+0x68/0x88
   [Tue Aug  6 20:51:51 2019]  dev_write+0x3c/0xb0 [ebbchar]
   [Tue Aug  6 20:51:51 2019]  __vfs_write+0x48/0x80
   [Tue Aug  6 20:51:51 2019]  vfs_write+0xac/0x1b0
   [Tue Aug  6 20:51:51 2019]  SyS_write+0x6c/0xd8
   [Tue Aug  6 20:51:51 2019]  el0_svc_naked+0x30/0x34
   [Tue Aug  6 20:51:51 2019] Code: f13ffcdf d1000408 540002c9 b4000320 (394000c5)
