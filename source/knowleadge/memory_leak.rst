******************
内存泄露
******************


app内存泄露
slab内存泄露
kmalloc




申请4k以上的内存 vmalloc

申请内存不释放，不叫泄露。 申请了内存没有referrence才是泄露。



内存泄露无法实时检测

kmemleak

asan


内存corruption是可以实时检测的


SLUB_DEBUG， 扫描内存的redzone或者pedding是不是原来的magic值， 如果不是，会打印调用栈， 能知道有没有corruption，但是不知道谁搞的

ASAN： 需要编译器支持。 把ldr store替换层了san_ldr, san_store。 建立申请内存的shadow， 描述原来的内存能不能访问之类的。 所以ASAN
需要消耗多个内存。程序访问内存的时候， asan检测要访问的内存是不是合法的。 is_valid_addr(p).