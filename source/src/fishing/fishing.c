/*
 * hello.c __The Hello, World丨我们的第一个内核模块
 */
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/delay.h>
#include <linux/types.h>

/*
 * * hello_init-初始化函数，当模块装栽时被调用，如果成功装栽返回零，否
 * *則返冋非零值
 * 
 */

static int get_mem(void)
{
	int i = 0;
	int a = 0;
	int mem_size = 1*1024*1024;
	char *kernel_mem = NULL;
	kernel_mem = kmalloc(mem_size , GFP_KERNEL);

	if(!kernel_mem)
	{
		printk("kmalloc fail!\n");
		return 0;
	}

	for(i =0; i<mem_size; i++)
	{
		*(kernel_mem+i)=(char)(a+97);
		a++;
		a=a%26;
	}
	printk("Address:%p\n",kernel_mem);

	return 0;
}

static int hello_init(void)
{
	printk(KERN_ALERT "I bear a charmed life.\n");

	get_mem();

	return 0;
}
/*
 * hello_exit—退出函数，当摸块卸栽时被调用
 * */
static void hello_exit(void)
{
	printk(KERN_ALERT "Out, out, brief candle!\n");
}

module_init(hello_init);
module_exit(hello_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Shakespeare");
MODULE_DESCRIPTION("A Hello, World Module");


