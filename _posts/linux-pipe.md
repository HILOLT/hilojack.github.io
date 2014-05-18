---
layout: page
title:	
category: blog
description: 
---
# Preface
管道(pipe)实现了stdout到stdin.
很多命令可以通过加参数 "-" 支持pipe.
	cat file | expand -
	tar -cvf - /home | tar -xvf - #tar 将打包结果送到stdout, 这个stdout再通过管道送给tar解包.
# 重定向
	2>&1 # stderr>stdout

# tee双向重导向
tee实现了当输出到管道时, 保存中间状态(stdout)到文件.
	 tee [-a] file
	选项与参数：
	-a  以累加 (append) 的方式，将数据加入 file 当中！

	last | tee last.list | cut -d " " -f1


# xargs 参数替换
	 xargs [-0epn] command
	选项与参数：
	-0  ：如果输入的 stdin 含有特殊字符，例如 `, \, 空格键等等字符时，这个 -0 参数
		  可以将他还原成一般字符。这个参数可以用于特殊状态喔！
	-E  ：这个是 EOF (end of file) 的意思。后面可以接一个字符串，当 xargs 分析到
		  这个字符串时，就会停止继续工作！
	-p  ：在运行每个命令的 argument 时，都会询问使用者的意思；
	-n  ：后面接次数，每次 command 命令运行时，要使用几个参数的意思。看范例三。
	当 xargs 后面没有接任何的命令时，默认是以 echo 来进行输出喔！

	cut -d':' -f1 /etc/passwd |head -n 3| xargs finger
	cut -d':' -f1 /etc/passwd |head -n 3| xargs -p -n 2 finger #每个命令执行时都需要提示.
	cut -d':' -f1 /etc/passwd |head -n 3| xargs -p -n 2 -E 'root' finger #见到root 后截止

> xargs 可以用于不支持管道的命令, 比如ls. 有的命令可能通过加参数"-"支持管道
