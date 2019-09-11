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


cmake中变量遇到的坑
https://cslam.cn/archives/c9f565b5.html
https://murphypei.github.io/blog/2018/10/cmake-variable.html
https://xyz1001.xyz/articles/53989.html