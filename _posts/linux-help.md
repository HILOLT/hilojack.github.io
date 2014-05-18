---
layout: page
title:	
category: blog
description: 
---

$TOC$

# 序
linux的帮助系统主要有以下三种,本文参考了[鸟哥的Linux私房菜]，总结了man和info

1. 程序自带的，比如命令 --help,还比如安装手册提供的README
2. man
3. info

# man 
这个应该是大家最常用的了．以man date为例。ps:man手册不仅仅是有关于命令（比如man ascii）,只要提供了man doc,都可以通过man去查看。

	NAME

		   date - print or set the system date and time

	SYNOPSIS　//摘要或命令的基本用法

		   date [OPTION]... [+FORMAT]
		   date [-u|--utc|--universal] [MMDDhhmm[[CC]YY][.ss]]

	DESCRIPTION//详情（包括参数和用法）
		   Display the current time in the given FORMAT, or set the system date.
		   -d, --date=STRING
			  display time described by STRING, not 'now'

	REPORTING BUGS //如果你想提交bug或者联系作者，就是这里啦
		   Report bugs to <bug-coreutils@gnu.org>.

	COPYRIGHT //注意一下版权
		   This is free software.  You may redistribute copies  of	it  under  the terms	   of	    the	     GNU      General	   Public      License <http://www.gnu.org/licenses/gpl.html>.	There is NO WARRANTY,  to  the extent permitted by law.


##　快捷键
除了常用的：[page up]/[page down]/[home]/[end]/方向键
也可以使用类似于vim的快捷键：

1. g 第一行
1. G 最后一行
1. ctrl-f 往下翻页
1. j/k 往下/上移动一行
1. /pattern  搜索
1. n/N　重复上一次搜索/以反方向重复上一次搜索

更多信息可以按h查看

## 常用例子
	$man -f curl //按手册名搜索man手册（相当于whatis curl, 此命令会搜索缓存）
	$man -k curl //按手册名和手册描述搜索man手册(相当于apropos curl，此命令搜索的也是缓存)
	$man -w curl //打印手册路径
	$man -wa man //打印所有找到的手册路径

## man手册的分类
man手册实在太多了，一般地manual分为9大类。
	
	man 1 curl //指定查看分类1下的curl手册

1. 用户在 shell 环境中可以操作的挃令戒可执行文件
2. 系统核心可呼叫的凼数不工具等
3. 一些常用的凼数(function)不凼式库(library),大部分为 C 的凼式库(libc)
4. 装置档案的说明,通常在/dev 下的档案
5. 配置文件戒者是某些档案的格式
6. 游戏(games)
7. 惯例不协议等,例如 Linux 文件系统、网绚协议、ASCII code 等等的说明
8. 系统管理员可用的管理挃令
9. 跟 kernel 有关的文件

## man 配置& man 写法
### 配置(config)
通过man man 我们可以知道：

1. 配置文件在/etc/man_db.conf 
2. 合局的手册分层级目录：/usr/share/man
2. man手册缓存:/var/cache/man/index.*

其中配置文件中,最重要的是manpath(manpath本身是一个打印man path的命令，可查man manpath)

1. MANDATORY_MANPATH 指定的是强制手册搜索路径
2. MANPATH_MAP是PATH到manpath映射.

###
让我们看看，手册本身是什么样子的。

	vim `man -w svn` 

简单看下语法：.TH 这个是分类用的 .SH是每个section的标题,\fB与\fP之间的内容会被加粗，\fI与\fP为加下划线。可以对比man svn感受一下。 

	.TH svn 1
	.SH NAME
	svn \- Subversion command line client tool
	.SH SYNOPSIS
	.TP
	\fBsvn\fP \fIcommand\fP [\fIoptions\fP] [\fIargs\fP]
	.SH OVERVIEW
	Subversion 


# info
一般来说man就足够了，如果你想了解更多，可以用info，比如 info info.
info是按照结点组织起来的。 看看鸟哥的结点图好了：
<a href="http://hilojack-wordpress.stor.sinaapp.com/uploads/2013/08/Screenshot-from-2013-08-25-022943.png"><img title="Screenshot-from-2013-08-25-022943.png" alt="Screenshot-from-2013-08-25-022943.png" src="http://hilojack-wordpress.stor.sinaapp.com/uploads/2013/08/Screenshot-from-2013-08-25-022943.png" class="aligncenter" /></a>

## 快捷键

	空格+方向键+翻页键实现移动
	n/p 下/上一节点
	u 返回上一层
	/ 搜索
	h 帮助
	? 指令一览表


>> info可以支持vi类的快捷模式,实现jk上下移动，使用时加参数[--vi-keys](http://www.gnu.org/software/texinfo/manual/info-stnd/info-stnd.html)就可以了

# 自带的doc
很多程序都会提供doc，放在/usr/share/doc/
比如：fcitx /usr/share/doc/fcitx/API.txt 

# 参考
[鸟哥的linux私房菜]

[鸟哥的linux私房菜]: http://linux.vbird.org/
