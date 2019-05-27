## 编译时出错: __alloca问题

```
./glob/glob.c: In function 'glob':
./glob/glob.c:576:23: warning: implicit declaration of function '__alloca'; did you mean 'alloca'? [-Wimplicit-function-declaration]
       newp = (char *) __alloca (dirlen + 1);
                       ^~~~~~~~
                       alloca
./glob/glob.c:576:14: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
       newp = (char *) __alloca (dirlen + 1);
              ^
./glob/glob.c:704:15: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
        newp = (char *) __alloca (home_len + dirlen);
               ^
./glob/glob.c:727:15: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
        newp = (char *) __alloca (end_name - dirname);
               ^
./glob/glob.c:778:15: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
        newp = (char *) __alloca (home_len + rest_len + 1);
               ^
./glob/glob.c:809:11: warning: implicit declaration of function '__stat'; did you mean '__xstat'? [-Wimplicit-function-declaration]
         : __stat (dirname, &st)) == 0
           ^~~~~~
           __xstat
./glob/glob.c: In function 'glob_in_dir':
./glob/glob.c:1251:21: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    char *fullname = (char *) __alloca (dirlen + 1 + patlen + 1);
                     ^
./glob/glob.c:1278:12: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    names = (struct globlink *) __alloca (sizeof (struct globlink));
            ^
./glob/glob.c:1336:32: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
         struct globlink *new = (struct globlink *)
                                ^
./glob/glob.c:1362:15: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
       names = (struct globlink *) __alloca (sizeof (struct globlink));
               ^
linking make...
glob.o: In function `glob':
linking make...                                                                                                                                                        [0/776]
glob.o: In function `glob':
glob.c:(.text+0x520): undefined reference to `__alloca'
glob.c:(.text+0x72c): undefined reference to `__alloca'
glob.c:(.text+0x7a8): undefined reference to `__alloca'
glob.c:(.text+0x858): undefined reference to `__alloca'
glob.o: In function `glob_in_dir':
glob.c:(.text+0x15b0): undefined reference to `__alloca'
glob.o:glob.c:(.text+0x1688): more undefined references to `__alloca' follow
collect2: error: ld returned 1 exit status
+ testordie error building make with build.sh
+ test 1 -ne 0
+ echo !!! error building make with build.sh
!!! error building make with build.sh
+ kill -TERM 36346
+ exit 1
!!!!! buildtools killed
/home/me/cpu2006
```
## 执行450时出错
```
./runspec -c ../config/lemon-2cpu.cfg 450 --rate 1 -noreportable
```
```
mpsinput.cc:75:52: error: no match for 'operator==' (operand types are 'std::basic_istream<char>::__istream_type {aka std::basic_istream<char>}' and 'int')
          if (m_input.getline(m_buf, sizeof(m_buf)) == 0)
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
mpsinput.cc:75:52: note: candidate: operator==(int, int) <built-in>
mpsinput.cc:75:52: note:   no known conversion for argument 1 from 'std::basic_istream<char>::__istream_type {aka std::basic_istream<char>}' to 'int'
In file included from /usr/include/c++/7/bits/locale_conv.h:41:0,
                 from /usr/include/c++/7/locale:43,
                 from /usr/include/c++/7/iomanip:43,
                 from spxlp.h:28,
                 from mpsinput.h:25,
                 from mpsinput.cc:29:
/usr/include/c++/7/bits/unique_ptr.h:694:5: note: candidate: template<class _Tp, class _Dp> bool std::operator==(std::nullptr_t, const std::unique_ptr<_Tp, _Dp>&)
     operator==(nullptr_t, const unique_ptr<_Tp, _Dp>& __x) noexcept
     ^~~~~~~~
/usr/include/c++/7/bits/unique_ptr.h:694:5: note:   template argument deduction/substitution failed:
mpsinput.cc:75:55: note:   mismatched types 'const std::unique_ptr<_Tp, _Dp>' and 'int'
          if (m_input.getline(m_buf, sizeof(m_buf)) == 0)
                                                       ^
In file included from /usr/include/c++/7/bits/locale_conv.h:41:0,
                 from /usr/include/c++/7/locale:43,
                 from /usr/include/c++/7/iomanip:43,
                 from spxlp.h:28,
                 from mpsinput.h:25,
                 from mpsinput.cc:29:


/usr/include/c++/7/bits/stl_pair.h:443:5: note:   template argument deduction/substitution failed:
mpsinput.cc:75:55: note:   'std::basic_istream<char>::__istream_type {aka std::basic_istream<char>}' is not derived from 'const std::pair<_T1, _T2>'
          if (m_input.getline(m_buf, sizeof(m_buf)) == 0)
                                                       ^
In file included from /usr/include/c++/7/iosfwd:40:0,
```

解决办法：
CXXPORTABILITY = -std=c++03

## 只跑单项测试不允许report，指定`--noreport`，指定`--noreportable`
```
Individual benchmark selection is not allowed for a reportable run
```
```
./bin/runspec -c ts2280-2cpu.cfg 450 --rate 1
改成
./runspec -c ../config/lemon-2cpu.cfg 450 --rate 1 --noreportable
```

## 执行install报错
```
We do not appear to have working vendor-supplied binaries for your
architecture.  You will have to compile the tool binaries by
yourself.  Please read the file

    /home/me/syncfile/cputool/speccpu2006/Docs/tools-build.html

for instructions on how you might be able to build them.

Please only attempt this as a last resort.
```
也就是没有预编译好的二进制文件可以安装，需要我们自行编译
同时在"tools/bin/"也可以看到哪些体系结果有编译好的二进制用于安装。


## 执行416.gamess base时报错
```
*** Miscompare of cytosine.2.out; for details see
    /home/me/syncfile/cputool/speccpu2006/benchspec/CPU2006/416.gamess/run/run_base_ref_gcc43-64bit.0082/cytosine.2.out.mis

*** Miscompare of h2ocu2+.gradient.out; for details see
    /home/me/syncfile/cputool/speccpu2006/benchspec/CPU2006/416.gamess/run/run_base_ref_gcc43-64bit.0082/h2ocu2+.gradient.out.mis

*** Miscompare of triazolium.out; for details see
    /home/me/syncfile/cputool/speccpu2006/benchspec/CPU2006/416.gamess/run/run_base_ref_gcc43-64bit.0083/triazolium.out.mis

*** Miscompare of cytosine.2.out; for details see
    /home/me/syncfile/cputool/speccpu2006/benchspec/CPU2006/416.gamess/run/run_base_ref_gcc43-64bit.0083/cytosine.2.out.mis

*** Miscompare of h2ocu2+.gradient.out; for details see
    /home/me/syncfile/cputool/speccpu2006/benchspec/CPU2006/416.gamess/run/run_base_ref_gcc43-64bit.0083/h2ocu2+.gradient.out.mis

*** Miscompare of triazolium.out; for details see
    /home/me/syncfile/cputool/speccpu2006/benchspec/CPU2006/416.gamess/run/run_base_ref_gcc43-64bit.0084/triazolium.out.mis

*** Miscompare of cytosine.2.out; for details see
    /home/me/syncfile/cputool/speccpu2006/benchspec/CPU2006/416.gamess/run/run_base_ref_gcc43-64bit.0084/cytosine.2.out.mis

*** Miscompare of h2ocu2+.gradient.out; for details see
    /home/me/syncfile/cputool/speccpu2006/benchspec/CPU2006/416.gamess/run/run_base_ref_gcc43-64bit.0084/h2ocu2+.gradient.out.mis

*** Miscompare of cytosine.2.out; for details see
    /home/me/syncfile/cputool/speccpu2006/benchspec/CPU2006/416.gamess/run/run_base_ref_gcc43-64bit.0085/cytosine.2.out.mis
Error: 3x416.gamess
Producing Raw Reports
mach: default
  ext: gcc43-64bit
    size: ref
      set: int
      set: fp
        format: raw -> /home/me/syncfile/cputool/speccpu2006/result/CFP2006.014.ref.rsf
Parsing flags for 416.gamess base: done
Doing flag reduction: done
        format: flags -> /home/me/syncfile/cputool/speccpu2006/result/CFP2006.014.ref.flags.html
        format: ASCII -> /home/
```

解决办法：
在config文件中,例如我使用的confi文件为：config/d05-2cpu.cfg，修改
```
416.gamess=default=default=default:
FOPTIMIZE = -O0
```

## 执行.buildtoos报错
```
You are not allowed to write into /home/me/tmp_from_iso2/config.
That may be because you are attempting to source the shrc on your distribution
media.

It may also be that a different user installed the benchmark tree and
has not set permissions that allow you to use it for runs.  See the
output_root section of runspec.html for information on how an installed
benchmark tree may be used by multiple users.

Please try again after correcting the problem.
Top of SPEC benchmark tree is '/home/me/tmp_from_iso2'
Can't open MANIFEST for writing: Permission denied
Uhoh! I appear to have had problems relocating the tree.
Once you fix the problem (is your SPEC environment variable set?) you can make
the tools work by sourcing the shrc and running /bin/relocate by hand.
```
解决办法：
```
chmod +w config -R
chmod +w MANIFEST

```


## 执行./bin/runspec不成功
两个perl脚本执行报错
```
t/uni/write.................ok
t/lib/1_compile.............ok
t/lib/commonsense...........ok
Failed 2 tests out of 217, 99.08% okay.
        op/magic.t
        op/numconvert.t
### Since not all tests were successful, you may want to run some of
### them individually and examine any diagnostic messages they produce.
### See the INSTALL document's section on "make test".
### You have a good chance to get more information by running
###   specperl harness
```
可以单独重现这个错误：
```shell
cd tools/src/perl-5.12.3
./perl t/op/magic.t
./perl t/op/numconvert
```
解决办法：

