---
layout: page
title:	
category: blog
description: 
---
# Preface
本该讲述的是Linux文件管理

# ls
	ll -S 按文件大小排序
	ll -i 查看文件的inode

# find
	find [-H | -L | -P] [-EXdsx] [-f path] path ... [expression]
## -exec
	find . -inum INODE -exec cmd #根据-exec
		-inum #指定文件的inode
		-exec cmd #对匹配文件执行cmd. 特殊字符需要转义. eg. `rm {} \;`
	find . -inum 123 -o -inum 132 -exec rm {} \;

## -name
find -name 支持wildcard("[,],*,?")
	-name pattern
		 True if the last component of the pathname being examined matches pattern.  Special shell pattern matching characters (``['', ``]'', ``*'', and ``?'') may be used as part of pattern.  These characters may be matched explicitly by escaping them with a backslash (``\'').

eg:

	find . -name '[AB].txt' 
	find . -name '*.txt'  #或者 find -name \*.txt

## -regex & -iregex
这个参数是匹配path 而不是像-name那样只匹配filename(-iregex same as -regex but ther match is case isensitive)
It support POSIX Basic regular expressions by default (and so does grep). 

	$ find  . -maxdepth 1  -regex './\(Ale[xe]\).*'
		a/Alex.SpeechVoice
		a/Alee.SpeechVoice

开启-E 后就可以支持ERE了.

	$ find . -maxdepth -regex './(Alex|John).*' 
	
注意-regex -iregex内部实现强制使用了^$. 即'^Alex$' ,'^Alex', 'Alex$'是等价的, 如果相部分匹配, 一定要加.*

	-regex '.*Alex.*'


## -not & !
实现条件反转, 比如寻找txt文件但过滤掉a.txt
	
	find . -name \*.txt ! -name 'a.txt'
	find . -name \*.txt -not -name 'a.txt'

# du
du -s dir/* | sort -nr > dir.du
