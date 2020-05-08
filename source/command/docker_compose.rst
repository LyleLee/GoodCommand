*********************
docker compose
*********************

编译docker-compose

https://github.com/docker/compose/issues/6831


No module named 'pkg_resources.py2_warn'
---------------------------------------------

已经在github进行讨论 [#pkg_resources]_


.. code-block:: console

    35612 INFO: Building EXE from EXE-00.toc
    35613 INFO: Appending archive to ELF section in EXE /code/dist/docker-compose
    35785 INFO: Building EXE from EXE-00.toc completed successfully.
    + ls -la dist/
    total 16460
    drwxrwxrwx    2 root     root          4096 Mar 28 18:17 .
    drwxr-xr-x    1 root     root          4096 Mar 28 18:16 ..
    -rwxr-xr-x    1 root     root      16839184 Mar 28 18:17 docker-compose
    + ldd dist/docker-compose
            /lib/ld-musl-aarch64.so.1 (0xffffb4c50000)
            libz.so.1 => /lib/libz.so.1 (0xffffb4bff000)
            libc.musl-aarch64.so.1 => /lib/ld-musl-aarch64.so.1 (0xffffb4c50000)
    + mv dist/docker-compose /usr/local/bin
    + docker-compose version
    [996] Failed to execute script pyi_rth_pkgres
    Traceback (most recent call last):
    File "site-packages/PyInstaller/loader/rthooks/pyi_rth_pkgres.py", line 11, in <module>
    File "/code/.tox/py37/lib/python3.7/site-packages/PyInstaller/loader/pyimod03_importers.py", line 627, in exec_module
        exec(bytecode, module.__dict__)
    File "site-packages/pkg_resources/__init__.py", line 86, in <module>
    ModuleNotFoundError: No module named 'pkg_resources.py2_warn'
    The command '/bin/sh -c script/build/linux-entrypoint' returned a non-zero code: 255
    me@ubuntu:~/code/compose$ vim script/^C


.. code-block:: console

    docker-compose version
    docker-compose version 1.25.0, build unknown
    docker-py version: 4.1.0
    CPython version: 3.7.4
    OpenSSL version: OpenSSL 1.1.1d  10 Sep 2019
    Removing intermediate container acb5b89e92a7
    ---> 8fd1183543df
    Step 33/39 : FROM alpine:${RUNTIME_ALPINE_VERSION} AS runtime-alpine
    Get https://registry-1.docker.io/v2/: net/http: TLS handshake timeout



.. [#pkg_resources] https://github.com/pypa/setuptools/issues/1963