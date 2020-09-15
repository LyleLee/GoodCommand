**************************************
reexec and namespace
**************************************

在查看namespace的用法时， 发现reexec包比较难理解 [#namespaces-in-go-reexec-3d1295b91af8]_

代码仓库：

.. code-block:: go

    package main

    import (
        "fmt"
        "os"
        "log"
        "os/exec"
        "syscall"

        "github.com/docker/docker/pkg/reexec"
    )


    func init() {
        log.SetFlags(log.LstdFlags | log.Lshortfile)
        log.Println("run func init()")
        reexec.Register("nsInitialisation", nsInitialisation)
        log.Println("finish reexec.Register()")
        if reexec.Init() {
            log.Println("reexec.init() have been init()")
            os.Exit(0)
        }
        log.Println("run func init() finish")
    }

    func nsInitialisation() {
        log.Println(">> namespace setup code goes here <<")
        nsRun()
    }

    func nsRun() {
        cmd := exec.Command("/bin/sh")

        cmd.Stdin = os.Stdin
        cmd.Stdout = os.Stdout
        cmd.Stderr = os.Stderr

        cmd.Env = []string{"PS1=-[ns-process]- # "}

        if err := cmd.Run(); err != nil {
            fmt.Printf("Error running the /bin/sh command - %s\n", err)
            os.Exit(1)
        }
    }

    func main() {
        log.Println("main() begin in first line")
        cmd := reexec.Command("nsInitialisation")
        log.Println("main() construct  reexec.Command()")
        log.Println(cmd.Path)
        log.Println(cmd.Args[0])
        cmd.Stdin = os.Stdin
        cmd.Stdout = os.Stdout
        cmd.Stderr = os.Stderr

        cmd.SysProcAttr = &syscall.SysProcAttr{
            Cloneflags: syscall.CLONE_NEWNS |
                syscall.CLONE_NEWUTS |
                syscall.CLONE_NEWIPC |
                syscall.CLONE_NEWPID |
                syscall.CLONE_NEWNET |
                syscall.CLONE_NEWUSER,
            UidMappings: []syscall.SysProcIDMap{
                {
                    ContainerID: 0,
                    HostID:      os.Getuid(),
                    Size:        1,
                },
            },
            GidMappings: []syscall.SysProcIDMap{
                {
                    ContainerID: 0,
                    HostID:      os.Getgid(),
                    Size:        1,
                },
            },
        }

        if err := cmd.Run(); err != nil {
            fmt.Printf("Error running the reexec.Command - %s\n", err)
            os.Exit(1)
        }
    }


运行结果是::

    user1@intel6248:~/go/src/github.com/Lylelee/ns-process$ ./ns-process
    2020/08/28 17:14:46 ns_process.go:16: run func init()
    2020/08/28 17:14:46 ns_process.go:18: finish reexec.Register()
    2020/08/28 17:14:46 ns_process.go:23: run func init() finish
    2020/08/28 17:14:46 ns_process.go:47: main() begin in first line
    2020/08/28 17:14:46 ns_process.go:49: main() construct  reexec.Command()
    2020/08/28 17:14:46 ns_process.go:50: /proc/self/exe
    2020/08/28 17:14:46 ns_process.go:51: nsInitialisation
    2020/08/28 17:14:46 ns_process.go:16: run func init()
    2020/08/28 17:14:46 ns_process.go:18: finish reexec.Register()
    2020/08/28 17:14:46 ns_process.go:27: >> namespace setup code goes here <<
    -[ns-process]- # exit
    2020/08/28 17:14:50 ns_process.go:20: reexec.init() have been init()


这里解析一下执行过程 ::

    ./ns-process    执行可执行程序
                    注意此时os.Args[0]是空
    func init()     在main参数执行前会执行软件包中的init()函数
            2020/08/28 17:14:46 ns_process.go:16: run func init()
        reexec.Register("nsInitialisation", nsInitialisation)
            2020/08/28 17:14:46 ns_process.go:18: finish reexec.Register()
        if reexec.Init() == false   尝试运行新注册的nsInitialisation，失败，因为os.Args[0]是空
            2020/08/28 17:14:46 ns_process.go:23: run func init() finish
    func main()     执行main函数
            2020/08/28 17:14:46 ns_process.go:47: main() begin in first line
        cmd := reexec.Command("nsInitialisation")   构造新命令，设置参数为nsInitialisation
            2020/08/28 17:14:46 ns_process.go:49: main() construct  reexec.Command()
            2020/08/28 17:14:46 ns_process.go:50: /proc/self/exe    将要执行的命令是自己，也就是当前进程 ns-process ?
            2020/08/28 17:14:46 ns_process.go:51: nsInitialisation  将要执行进程的参数
        cmd.run()
            /proc/self/exec nsInitialisation 执行命令
            func init()     在main参数执行前会执行软件包中的init()函数
                    2020/08/28 17:14:46 ns_process.go:16: run func init()
                reexec.Register("nsInitialisation", nsInitialisation)   进程中也是需要register的
                    2020/08/28 17:14:46 ns_process.go:18: finish reexec.Register()
                if reexec.Init() == true   尝试运行新注册的nsInitialisation，成功，因为os.Args[0]已经设置伪nsInitialisation，查看上一句 cmd := reexec.Command("nsInitialisation")

                    func nsInitialisation() {
                        func nsRun() {

                            2020/08/28 17:14:46 ns_process.go:27: >> namespace setup code goes here <<

                            cmd := exec.Command("/bin/sh") 进入命令行


                            -[ns-process]- # exit

                    2020/08/28 17:14:50 ns_process.go:20: reexec.init() have been init() 执行注册的函数成功


这里花了不少事件去理解他是怎么自己执行自己的。 做法是， 自己在执行时检查自己的参数os.Args[0]是否设置， 如果设置了就执行注册在这个参数下的函数或者时命令。
如果没有设置这个参数，或者设置了这个参数但是没有注册，那么直接退出就好了。

所以， 第一次在命令行输入命令开始执行时， 参数未设置，尝试调用注册的函数失败。 执行到main函数，用rexec.Command设置参数，再调用run， 这个时候就会fork自己。
以设置的参数查找注册函数，执行注册函数。这个时候注册号的函数就再新的命名空间中执行了。


这种设计方法， 感觉会让人比较费解。

据说这种fork自己的办法还可以把内存中可执行的二进制保存到硬盘， 这个样可以实现自己更新自己。


为了简化问题重写了一份比较好理解的代码 [#reexec_code]_

.. code-block:: go

    package main

    import (
        "github.com/docker/docker/pkg/reexec"
        "log"
        "os"
    )

    func init() {
        log.SetFlags(log.LstdFlags | log.Lshortfile)
    }

    func CalmDown() {
        pid := os.Getpid()
        log.Println(pid,"CalmDown() Take a deep breath...")
        // do somthing more
        log.Println(pid, "CalmDown() Yes, I am calmdown already!")
    }

    func main() {

        pid := os.Getpid()
        log.Println(pid, "os argument: ", os.Args)

        reexec.Register("func1", CalmDown)

        log.Println(pid , "register func1")

        if reexec.Init() {
            log.Println(pid, "reexec have init")
            os.Exit(0)
        }

        log.Println(pid, "test init")

        cmd := reexec.Command("func1")

        log.Println(pid,cmd.Path)
        log.Println(pid,cmd.Args)

        output, err := cmd.CombinedOutput()

        if err != nil {
            log.Println(pid, "cmd run with error: ", err.Error())
            os.Exit(10)
        }
        log.Println(pid, "cmd output: ")
        log.Println(pid, string(output))
        log.Println(pid, "rexec demo finish")
    }


输出结果 ::

    2020/08/29 11:01:29 reexec_usage.go:23: 65180 os argument:  [./reexec_usage]
    2020/08/29 11:01:29 reexec_usage.go:27: 65180 register func1
    2020/08/29 11:01:29 reexec_usage.go:34: 65180 test init
    2020/08/29 11:01:29 reexec_usage.go:38: 65180 /proc/self/exe
    2020/08/29 11:01:29 reexec_usage.go:39: 65180 [func1]
    2020/08/29 11:01:29 reexec_usage.go:47: 65180 cmd output:
    2020/08/29 11:01:29 reexec_usage.go:48: 65180 2020/08/29 11:01:29 reexec_usage.go:23: 65185 os argument:  [func1]
    2020/08/29 11:01:29 reexec_usage.go:27: 65185 register func1
    2020/08/29 11:01:29 reexec_usage.go:15: 65185 CalmDown() Take a deep breath...
    2020/08/29 11:01:29 reexec_usage.go:17: 65185 CalmDown() Yes, I am calmdown already!
    2020/08/29 11:01:29 reexec_usage.go:30: 65185 reexec have init

    2020/08/29 11:01:29 reexec_usage.go:49: 65180 rexec demo finish


.. [#namespaces-in-go-reexec-3d1295b91af8] https://medium.com/@teddyking/namespaces-in-go-reexec-3d1295b91af8
.. [#reexec_code] https://play.golang.org/p/ArHJfulbgrO