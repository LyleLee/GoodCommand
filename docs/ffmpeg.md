ffmpeg
=============
某一客户需要使用ffmpeg生成串流，需要编辑安装ffmpeg以及ffmpeg的组件。


# 软件列表

+ gcc 7.3.0
+ cmake 3.15.1
+ ffmpeg 4.2
+ x264 代码仓只有一个版本
+ x265 3.1_RC2
+ fdk_acc v2.0.0

## 编译安装

安装必要编译工具：

```
sudo yum install autoconf automake bzip2 bzip2-devel cmake freetype-devel gcc gcc-c++ git libtool make mercurial pkgconfig zlib-devel
sudo yum groupinstall "Development Tools"
#如果出现没有汇编器
sudo yum install nasm -y
```

#### 切换gcc
客户使用的gcc版本是7.3，如果没有特殊需求，可以默认。
```
scl enable devtoolset-7 bash
```
#### 克隆工程
耗时比较长，可能需要1个小时
```
git clone https://github.com/mirror/x264.git
git clone https://github.com/videolan/x265.git
git clone https://github.com/mstorsjo/fdk-aac.git
git clone https://git.ffmpeg.org/ffmpeg.git
```

#### X264

```
cd x264
PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
make
make install
```

#### X265
```
cd x265
git checkout -b 3.1_wangda_build 3.1
cd x265/build/arm-linux
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
make
make install
```

#### fdk-aac
```
git checkout -b v2.0.0_wangda_build v2.0.0
autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
```

#### ffmpeg

```
cd ffmpeg
git checkout -b n4.2_wangda_build n4.2

PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --extra-libs=-lpthread \
  --extra-libs=-lm \
  --bindir="$HOME/bin" \
  --enable-gpl \
  --enable-libfdk_aac \
  --enable-libfreetype \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree
  
make
make install
```

## 执行

输入视频：
```
/home/me/video/FM_1080p.mp4
```

```
ffmpeg  -y  -re  -itsoffset 0.5  -stream_loop -1   -i '/home/me/video/FM_1080p.mp4'   -c:v  libx264 -s 1920x1080  -refs 4 -preset medium -profile:v high -x264-params keyint=50:scenecut=0 -pix_fmt yuv420p  -b:v 3000k  -vsync cfr -bufsize 3000k -maxrate 4500k -c:a  libfdk_aac -profile:a aac_low  -b:a 128k  -ac 2.0 -ar 44100.0 -sn -dn -ignore_unknown  -metadata service_provider='WONDERTEK' -metadata service_name='Service01' -mpegts_service_id '1' -mpegts_pmt_start_pid 4096 -streamid 0:256 -mpegts_start_pid 256 -pcr_period 20 -f mpegts  -max_interleave_delta 1000M  -mpegts_flags +latm 'udp://237.0.1.1:1511?ttl=255&pkt_size=1316&fifo_size=10000000&overrun_nonfatal=0'  -c:v  libx264  -s 1280x720 -refs 4 -preset medium -profile:v high -x264-params keyint=50:scenecut=0 -pix_fmt yuv420p  -b:v 2000k  -vsync cfr -bufsize 2000k -maxrate 3000k -c:a  libfdk_aac -profile:a aac_low  -b:a 128k  -ac 2.0 -ar 44100.0 -sn -dn -ignore_unknown  -metadata service_provider='WONDERTEK' -metadata service_name='Service01' -mpegts_service_id '1' -mpegts_pmt_start_pid 4096 -streamid 0:256 -mpegts_start_pid 256 -pcr_period 20 -f mpegts  -max_interleave_delta 1000M  -mpegts_flags +latm 'udp://237.0.1.1:1521?ttl=255&pkt_size=1316&fifo_size=10000000&overrun_nonfatal=0'   -c:v  libx264 -s 960x540  -refs 4 -preset medium -profile:v high -x264-params keyint=50:scenecut=0 -pix_fmt yuv420p  -b:v 1000k  -vsync cfr -bufsize 1000k -maxrate 1500k -c:a  libfdk_aac -profile:a aac_low  -b:a 128k  -ac 2.0 -ar 44100.0 -sn -dn -ignore_unknown  -metadata service_provider='WONDERTEK' -metadata service_name='Service01' -mpegts_service_id '1' -mpegts_pmt_start_pid 4096 -streamid 0:256 -mpegts_start_pid 256 -pcr_period 20 -f mpegts  -max_interleave_delta 1000M  -mpegts_flags +latm 'udp://237.0.1.1:1531?ttl=255&pkt_size=1316&fifo_size=10000000&overrun_nonfatal=0' 
```
命令
[run_ffmpeg](script/run_ffmpeg.sh)

运行结果：
```
[libx264 @ 0x22869630] profile Progressive High, level 3.1, 4:2:0, 8-bit
Output #2, mpegts, to 'udp://237.0.1.1:1531?ttl=255&pkt_size=1316&fifo_size=10000000&overrun_nonfatal=0':
  Metadata:
    major_brand     : mp42
    minor_version   : 0
    compatible_brands: mp42mp41
    service_provider: WONDERTEK
    service_name    : Service01
    encoder         : Lavf58.29.100
    Stream #2:0(eng): Video: h264 (libx264), yuv420p, 960x540, q=-1--1, 1000 kb/s, 25 fps, 90k tbn, 25 tbc (default)
    Metadata:
      creation_time   : 2018-04-17T10:04:47.000000Z
      handler_name    : ?Mainconcept Video Media Handler
      encoder         : Lavc58.54.100 libx264
    Side data:
      cpb: bitrate max/min/avg: 1500000/0/1000000 buffer size: 1000000 vbv_delay: -1
    Stream #2:1(eng): Audio: aac (libfdk_aac) (LC), 44100 Hz, stereo, s16, 128 kb/s (default)
    Metadata:
      creation_time   : 2018-04-17T10:04:47.000000Z
      handler_name    : #Mainconcept MP4 Sound Media Handler
      encoder         : Lavc58.54.100 libfdk_aac
frame= 3084 fps= 25 q=31.0 q=29.0 q=31.0 size=   48914kB time=00:02:03.70 bitrate=3239.2kbits/s dup=39 drop=0 speed=0.998x
```
speed运行5分钟左右会稳定在0.998x，最终达到1X


可以打开4个窗口执行正常，但是第五个窗口会出现报错：
```
[me@centos ~]$ ~/bin/run_ffmpeg.sh
ffmpeg version n4.2 Copyright (c) 2000-2019 the FFmpeg developers
  built with gcc 7 (GCC)
  configuration: --prefix=/home/me/ffmpeg_build --pkg-config-flags=--static --extra-cflags=-I/home/me/ffmpeg_build/include --extra-ldflags=-L/home/me/ffmpeg_build/lib --ex
tra-libs=-lpthread --extra-libs=-lm --bindir=/home/me/bin --enable-gpl --enable-libfdk_aac --enable-libfreetype --enable-libx264 --enable-libx265 --enable-nonfree
  libavutil      56. 31.100 / 56. 31.100
  libavcodec     58. 54.100 / 58. 54.100
  libavformat    58. 29.100 / 58. 29.100
  libavdevice    58.  8.100 / 58.  8.100
  libavfilter     7. 57.100 /  7. 57.100
  libswscale      5.  5.100 /  5.  5.100
  libswresample   3.  5.100 /  3.  5.100
  libpostproc    55.  5.100 / 55.  5.100
Input #0, mov,mp4,m4a,3gp,3g2,mj2, from '/home/me/video/FM_1080p.mp4':
  Metadata:
    major_brand     : mp42
    minor_version   : 0
    compatible_brands: mp42mp41
    creation_time   : 2018-04-17T10:04:47.000000Z
  Duration: 00:02:00.09, start: 0.000000, bitrate: 10658 kb/s
    Stream #0:0(eng): Video: h264 (Main) (avc1 / 0x31637661), yuv420p(tv, bt709), 1920x1080, 10533 kb/s, 25 fps, 25 tbr, 25k tbn, 50 tbc (default)
    Metadata:
      creation_time   : 2018-04-17T10:04:47.000000Z
      handler_name    : ?Mainconcept Video Media Handler
      encoder         : AVC Coding
    Stream #0:1(eng): Audio: aac (LC) (mp4a / 0x6134706D), 44100 Hz, stereo, fltp, 125 kb/s (default)
    Metadata:
      creation_time   : 2018-04-17T10:04:47.000000Z
      handler_name    : #Mainconcept MP4 Sound Media Handler
Stream mapping:
  Stream #0:0 -> #0:0 (h264 (native) -> h264 (libx264))
  Stream #0:1 -> #0:1 (aac (native) -> aac (libfdk_aac))
  Stream #0:0 -> #1:0 (h264 (native) -> h264 (libx264))
  Stream #0:1 -> #1:1 (aac (native) -> aac (libfdk_aac))
  Stream #0:0 -> #2:0 (h264 (native) -> h264 (libx264))
  Stream #0:1 -> #2:1 (aac (native) -> aac (libfdk_aac))
Press [q] to stop, [?] for help
[libx264 @ 0x326eb320] using cpu capabilities: ARMv8 NEONe=-577014:32:22.77 bitrate=  -0.0kbits/s speed=N/A
Error initializing output stream 0:0 -- Error while opening encoder for output stream #0:0 - maybe incorrect parameters such as bit_rate, rate, width or height
[libfdk_aac @ 0x326ed290] 2 frames left in the queue on closing
[libfdk_aac @ 0x327425f0] 2 frames left in the queue on closing
[libfdk_aac @ 0x32745360] 2 frames left in the queue on closing
Conversion failed!
 
```
定位过程：ffmpeg的每个进程生成了很多线程，CentOS默认普通用户的最大线程数量是4096，root用户的是不受限。
```
[me@centos ffmpeg]$ ulimit -a

max user processes              (-u) 4096
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
```
使用ulimit -u 设置最大进程数量
```

max user processes              (-u) 65535
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
```
修改后不再报错。

注意ulimit -u仅对当前窗口有效，需要永久改变的，需要写到文件当中
```
[me@centos ffmpeg]$ cat /etc/security/limits.d/20-nproc.conf
# Default limit for number of user's processes to prevent
# accidental fork bombs.
# See rhbz #432903 for reasoning.

*          soft    nproc     65535
root       soft    nproc     unlimited
[me@centos ffmpeg]$

```


# 问题记录

```
ERROR: freetype2 not found using pkg-config

If you think configure made a mistake, make sure you are using the latest
version from Git.  If the latest version fails, report the problem to the
ffmpeg-user@ffmpeg.org mailing list or IRC #ffmpeg on irc.freenode.net.
Include the log file "ffbuild/config.log" produced by configure as this will help
solve the problem.
```



