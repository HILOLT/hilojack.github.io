---
layout: page
title:	Fork & Exec
category: blog
description: 
---
# Preface

# exec



exec命令

    exec ls
    在shell中执行ls，ls结束后不返回原来的shell中了
    exec <file
    将file中的内容作为exec的标准输入
    exec >file
    将file中的内容作为标准写出
    exec 3<file
    将file读入到fd3中
    sort <&3
    fd3中读入的内容被分类
    exec 4>file
    将写入fd4中的内容写入file中
    ls >&4
    Ls将不会有显示，直接写入fd4中了，即上面的file中
    exec 5<&4
    创建fd4的拷贝fd5
    exec 3<&-
    关闭fd3

## exec 执行程序

 虽然exec和source都是在父进程中直接执行，但exec这个与source有很大的区别，source是执行shell脚本，而且执行后会返回以前的shell。而exec的执行不会返回以前的shell了，而是直接把以前登陆shell作为一个程序看待，在其上经行复制。
举例说明：

    root@localhost:~/test#exec ls
    exp1  exp5  linux-2.6.27.54  ngis_post.sh  test  xen-3.0.1-install
    <logout>
    root@localhost:~/test#exec >text
    root@localhost:~/test#ls
    root@localhost:~/test#pwd
    root@localhost:~/test#echo "hello"
    root@localhost:~/test#exec>/dev/tty
    root@localhost:~/test#cat text 
    exp1
    exp5
    linux-2.6.27.54
    ngis_post.sh
    test
    text
    xen-3.0.1-install
    /root/test
    hello
    root@localhost:~/test#
    Exec >text 是将当前shell的标准输出都打开到text文件中
    root@localhost:~/test#cat test
    ls
    Pwd
    root@localhost:~/test#bash
    root@localhost:~/test#exec <test
    root@localhost:~/test#ls
    exp1  exp5  linux-2.6.27.54  ngis_post.sh  test  text  xen-3.0.1-install
    root@localhost:~/test#pwd
    /root/test
    root@localhost:~/test#
    root@localhost:~/test#exit       #自动执行

## exec的重定向

先上我们进如/dev/fd/目录下看一下：

    root@localhost:~/test#cd /dev/fd
    root@localhost:/dev/fd#ls
    0  1  2  255
    默认会有这四个项：0是标准输入，默认是键盘。
    1是标准输出，默认是屏幕/dev/tty
    2是标准错误，默认也是屏幕
    255
    当我们执行exec 3>test时：
    root@localhost:/dev/fd#exec 3>/root/test/test 
    root@localhost:/dev/fd#ls
    0  1  2  255  3
    root@localhost:/dev/fd#

看到了吧，多了个3，也就是又增加了一个设备，这里也可以体会下linux设备即文件的理念。这时候fd3就相当于一个管道了，重定向到fd3中的文件会被写在test中。关闭这个重定向可以用exec 3>&-。

    root@localhost:/dev/fd#who >&3
    root@localhost:/dev/fd#ls >&3
    root@localhost:/dev/fd#exec 3>&-
    root@localhost:/dev/fd#cat /root/test/te
    test  text  
    root@localhost:/dev/fd#cat /root/test/test 
    root     tty1         2010-11-16 01:13
    root     pts/0        2010-11-15 22:01 (192.168.0.1)
    root     pts/2        2010-11-16 01:02 (192.168.0.1)
    0
    1
    2
    255
    3

## 应用举例：

    exec 3<test
    while read -u 3 pkg
    do
    echo "$pkg"
    done

# Rerference
[exec]   
[fork]  

[exec]: http://blog.chinaunix.net/uid-24921475-id-2547162.html "x"
[fork]: http://www.cnblogs.com/hicjiajia/archive/2011/01/20/1940154.html "x1"
