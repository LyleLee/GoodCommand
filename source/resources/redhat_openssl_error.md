[编译内核](../redhat_build_kernel_zh.md)时缺少openssl库：
```shell-session
scripts/extract-cert.c:21:25: fatal error: openssl/bio.h: No such file or directory
 #include <openssl/bio.h>
                         ^
compilation terminated.
scripts/sign-file.c:25:30: fatal error: openssl/opensslv.h: No such file or directory
 #include <openssl/opensslv.h>
                              ^
compilation terminated.
  CHK     scripts/mod/devicetable-offsets.h
make[1]: *** [scripts/extract-cert] Error 1
make[1]: *** Waiting for unfinished jobs....
make[1]: *** [scripts/sign-file] Error 1
make: *** [scripts] Error 2
make: *** Waiting for unfinished jobs....
```



只有epel软件源时的情况
```
[root@localhost linux]# yum search openssl
Loaded plugins: langpacks, product-id, search-disabled-repos, subscription-manager
This system is not registered with an entitlement server. You can use subscription-manager to register.
=========================================================================== N/S matched: openssl ===========================================================================
globus-gsi-openssl-error.aarch64 : Grid Community Toolkit - Globus OpenSSL Error Handling
globus-gsi-openssl-error-devel.aarch64 : Grid Community Toolkit - Globus OpenSSL Error Handling Development Files
globus-gsi-openssl-error-doc.noarch : Grid Community Toolkit - Globus OpenSSL Error Handling Documentation Files
globus-openssl-module.aarch64 : Grid Community Toolkit - Globus OpenSSL Module Wrapper
globus-openssl-module-devel.aarch64 : Grid Community Toolkit - Globus OpenSSL Module Wrapper Development Files
globus-openssl-module-doc.noarch : Grid Community Toolkit - Globus OpenSSL Module Wrapper Documentation Files
mingw32-openssl.noarch : MinGW port of the OpenSSL toolkit
mingw32-openssl-static.noarch : Static version of the MinGW port of the OpenSSL toolkit
mingw64-openssl.noarch : MinGW port of the OpenSSL toolkit
mingw64-openssl-static.noarch : Static version of the MinGW port of the OpenSSL toolkit
openssl-pkcs11.aarch64 : A PKCS#11 engine for use with OpenSSL
perl-Crypt-OpenSSL-X509.aarch64 : Perl interface to OpenSSL for X509
pyOpenSSL.aarch64 : Python wrapper module around the OpenSSL library
python36-pyOpenSSL.noarch : Python 3 wrapper module around the OpenSSL library
rubygem-openssl_cms_2_0_0.aarch64 : OpenSSL with CMS functions for Ruby 2.0.0
rubygem-openssl_cms_2_0_0-doc.noarch : Documentation for rubygem-openssl_cms
lua-sec.aarch64 : Lua binding for OpenSSL library
m2crypto.aarch64 : Support for using OpenSSL in python scripts
openssl.aarch64 : Utilities from the general purpose cryptography library with TLS implementation
openssl-libs.aarch64 : A general purpose cryptography lib
```
添加本地ISO软件源之后的情况
```
[root@localhost linux]# yum search openssl
Loaded plugins: langpacks, product-id, search-disabled-repos, subscription-manager
This system is not registered with an entitlement server. You can use subscription-manager to register.
=========================================================================== N/S matched: openssl ===========================================================================
globus-gsi-openssl-error.aarch64 : Grid Community Toolkit - Globus OpenSSL Error Handling
globus-gsi-openssl-error-devel.aarch64 : Grid Community Toolkit - Globus OpenSSL Error Handling Development Files
globus-gsi-openssl-error-doc.noarch : Grid Community Toolkit - Globus OpenSSL Error Handling Documentation Files
globus-openssl-module.aarch64 : Grid Community Toolkit - Globus OpenSSL Module Wrapper
globus-openssl-module-devel.aarch64 : Grid Community Toolkit - Globus OpenSSL Module Wrapper Development Files
globus-openssl-module-doc.noarch : Grid Community Toolkit - Globus OpenSSL Module Wrapper Documentation Files
mingw32-openssl.noarch : MinGW port of the OpenSSL toolkit
mingw32-openssl-static.noarch : Static version of the MinGW port of the OpenSSL toolkit
mingw64-openssl.noarch : MinGW port of the OpenSSL toolkit
mingw64-openssl-static.noarch : Static version of the MinGW port of the OpenSSL toolkit
openssl-devel.aarch64 : Files for development of applications which will use OpenSSL
openssl-pkcs11.aarch64 : A PKCS#11 engine for use with OpenSSL
perl-Crypt-OpenSSL-Bignum.aarch64 : Perl interface to OpenSSL for Bignum
perl-Crypt-OpenSSL-RSA.aarch64 : Perl interface to OpenSSL for RSA
perl-Crypt-OpenSSL-Random.aarch64 : Perl interface to OpenSSL for Random
perl-Crypt-OpenSSL-X509.aarch64 : Perl interface to OpenSSL for X509
pyOpenSSL.aarch64 : Python wrapper module around the OpenSSL library
python36-pyOpenSSL.noarch : Python 3 wrapper module around the OpenSSL library
rubygem-openssl_cms_2_0_0.aarch64 : OpenSSL with CMS functions for Ruby 2.0.0
rubygem-openssl_cms_2_0_0-doc.noarch : Document
```