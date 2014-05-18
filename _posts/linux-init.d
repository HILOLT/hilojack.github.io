---
layout:	post
title:	
category: blog
description: 
---
# Preface
# init
init指linux 系统运行级runlevel 0~6. 可在/etc/inittab中指定:

	id:3:initdefault:


## rc.d
运行级对应的要启动的脚本目录rcN.d(其下的脚本链接到../init.d/):

	/etc/rc.d/rcN.d

rcN.d下的文件是按启动顺序的, 18比10大, 于是在10后启动; S代表start K 代表Kill

	S10network
	K15httpd
	S18sshd
	
	...

runlevel含义是基于rcN.d的, 不同的OS对于rcN.d的定义是不同的, 对于Red Hat系来说[runlevel](http://en.wikipedia.org/wiki/Runlevel):
0	Halt(Shutdown)
1	Single-user Mode
2	Multi-user Mode	
3	Multi-user Mode with Networking
4	Not used/User-definable	For special purposes.
5	Start the system normally with appropriate display manager. ( with GUI )	Same as runlevel 3 + display manager.
6	Reboot

# init.d
如果你执行这个命令, 你会发现: 
	
	ll -id /etc/init.d /etc/rc.d/init.d #它们是硬链接

# service
在linux 中:

	service Name argv1 argv2 ...

实际调用的是:
	
	/etc/init.d/Name argv1 argv2

# *ctl
*ctl 实际是对一些服务的单独封装. 比如: apachectl 就是对httpd的独立封装
	
	vi `which apachectl`
