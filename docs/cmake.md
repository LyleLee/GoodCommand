cmake
================
cmake to build a project

+ INCLUDE_DIRECTORY 添加头文件目录
    
    相当于-I 或者 CPLUS_INCLUDE_PATH

+ LINK_DIRECTORIES 添加需要链接的库文件目录
    
    相当于-L

+ LINK_LIBRARIES 添加需要练级额度莪哭文件路径，完整路径

    ```
    LINK_LIBRARIES("/opt/MATLAB/R2012a/bin/glnxa64/libeng.so")
    ```
+ TARGET_LINK_LIBRARIES 设置需要链接的库文件名称

[【https://www.hahack.com/codes/cmake/】](https://www.hahack.com/codes/cmake/)

#使用cmake 检测X86还是ARM

https://stackoverflow.com/questions/26657082/detect-x86-architecture-in-cmake-file

# 设置C flags和C++ flags
```
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g -O2 -Wall -Wno-sign-compare -Wno-unused-result")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O2 -Wall")
```

# cmake 设置make的时候显示具体编译命令,可以看到CC命令
```
set(CMAKE_VERBOSE_MAKEFILE on)
```

cmake中变量遇到的坑
https://cslam.cn/archives/c9f565b5.html
https://murphypei.github.io/blog/2018/10/cmake-variable.html
https://xyz1001.xyz/articles/53989.html
