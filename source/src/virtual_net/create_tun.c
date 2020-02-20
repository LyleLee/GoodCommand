#include <net/if.h> /**/
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <fcntl.h>  /*oflag values: O_RDONLY O_RDWR */
#include <sys/types.h>
#include <linux/if_tun.h>
#include <unistd.h> /*close*/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int tun_alloc(char *dev)
{
	struct ifreq ifr;
	int fd, err;

	if ((fd = open("/dev/net/tun", O_RDWR)) < 0)
	{
		printf("open /dev/net/tun fail\n");
		return fd;
	}

	memset(&ifr, 0, sizeof(ifr));

	/* Flags: IFF_TUN   - TUN device (no Ethernet headers) 
	 * IFF_TAP   		- TAP device  
	 * IFF_NO_PI 		- Do not provide packet information  
	 */
	ifr.ifr_flags = IFF_TUN;

	if (*dev)
		strncpy(ifr.ifr_name, dev, IFNAMSIZ);

	if ((err = ioctl(fd, TUNSETIFF, (void *)&ifr)) < 0)
	{
		close(fd);
		return err;
	}
	strcpy(dev, ifr.ifr_name);
	return fd;
}

int main()
{
	char dev[100] = "tun-default";
	int fd = tun_alloc(dev);

	if (fd == -1)
	{
		printf("create error: %d\n", fd);
		return -1;
	}

	while (1)
	{
		sleep(1000);
	}
	return 0;
}
