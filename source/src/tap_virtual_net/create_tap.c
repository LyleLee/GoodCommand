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
    ifr.ifr_flags = IFF_TAP;

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
    int nread;
    char buffer[1500];
    char dev[100] = "tap-default";
    int tun_fd = tun_alloc(dev);

    if (tun_fd == -1)
    {
        printf("create error: %d\n", tun_fd);
        return -1;
    }

    while (1) {
        nread = read(tun_fd, buffer, sizeof(buffer));
        if (nread < 0) {
            perror("Reading from interface");
            close(tun_fd);
            exit(1);
        }
        printf("Read %d bytes from tap device\n", nread);
    }
    return 0;
}
