************************
LDD3 linux设备驱动
************************


主设备号，次设备号
==========================

主设备号一般用来标识设备的驱动。 次设备号内核用来区分实际设备。


printk 不支持浮点数

::

 The printk function used in hello.c earlier, for example, is the version of printf defined within the kernel and exported to modules. It behaves similarly to the original function, with a few minor differences, the main one being lack of floating-point suppor



代表内核中每一个被打开的文件， 而inode节点代表每一个存在的文件， 很多打开的文件可以指向同一个inode

.. c:type:: struct file

.. code-block:: c

        struct file {
            union {
                    struct llist_node       fu_llist;
                    struct rcu_head         fu_rcuhead;
            } f_u;
            struct path             f_path;
            struct inode            *f_inode;       /* cached value */
            const struct file_operations    *f_op;
            spinlock_t              f_lock;
            enum rw_hint            f_write_hint;
            atomic_long_t           f_count;
            unsigned int            f_flags;
            fmode_t                 f_mode;
            struct mutex            f_pos_lock;
            loff_t                  f_pos;
            struct fown_struct      f_owner;
            const struct cred       *f_cred;
            struct file_ra_state    f_ra;
            u64                     f_version;
    }

.. c:member:: struct inode;

.. code-block:: c

    struct inode {
        dev_t                   i_rdev;      /*inode中代表设备文件*/
        loff_t                  i_size;
        struct timespec64       i_atime;
        struct timespec64       i_mtime;
        struct timespec64       i_ctime;
        union {
                    struct pipe_inode_info  *i_pipe;
                    struct block_device     *i_bdev;
                    struct cdev             *i_cdev;    /*inode中代表字符设备*/
                    char                    *i_link;
                    unsigned                i_dir_seq;
            };
    }


在inode节点中的设备文件


创建设备文件有两种方式：

1. 使用 mknod，然后可以直接用rm删除

.. code-block:: shell

    mknod  filename type  major  minor

        filename :  设备文件名
        type        :  设备文件类型
        major      :   主设备号
        minor      :   次设备号

2. 在代码中手动创建

.. code-block:: shell

    struct class *cdev_class;
    cdev_class = class_create(owner,name)
    device_create(_cls,_parent,_devt,_device,_fmt)

    device_destroy(_cls,_device)
    class_destroy(struct class * cls)


引用空指针， 通常会导致oops。
