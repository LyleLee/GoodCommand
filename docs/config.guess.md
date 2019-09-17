config.guess
================
config.guess可以生成

很多工程的configure脚本会检测系统环境生成makefile, configure 用到的一部分脚本就是config.guess.

```
[me@centos]$ ./config.guess
aarch64-unknown-linux-gnu

root@192e168e100e118 ~/config# ./config.guess
x86_64-pc-linux-gnu

pi@raspberrypi:~/code/config $ ./config.guess
armv7l-unknown-linux-gnueabihf
```