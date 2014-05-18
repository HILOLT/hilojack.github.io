---
layout: page
title:	Linux Network
category: blog
description: 
---
# Preface
# netstat
使用netstat -lntp来看看有侦听在网络某端口的进程。当然，也可以使用lsof。
	netstat -antl|grep 9000
	sudo lsof -i:80
	On Linux/Unix run
	$>  netstat -plant
	$> # or
	$> sudo lsof -i:80

	On Windows run
	$>  netstat -ano

	On Mac OS X / FreeBSD run
	$> netstat -Wan |grep 80
	$> # or, to get the pid
	$> sudo lsof -i:80

# lsof

# selinux
SELinux / AppArmor is preventing apache httpd from binding to a specific IP/PORT
	#check port
	semanage port -l|grep http

	# And add your favourite port to the existing policy:
	semanage port -a -t http_port_t -p tcp <PORT>


# Reference
[could_not_bind_to_port]

[could_not_bind_to_port]: http://wiki.apache.org/httpd/CouldNotBindToAddress
