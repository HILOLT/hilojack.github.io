---
layout: page
title:	
category: blog
description: 
---

# length
	len=`expr length $str` 
# substr
	expr substr “this is a test” start length #start是从1开始的,而不是0

# index
	#第一个字符数字串出现的位置
	expr index “sarasara”  a
# 运算
	expr 14 % 9
	expr 14 \* 3 #*在shell中有特别的含义

# expr match $string substring
	expr match $string substring #返回匹配substring的长度, 否则返回0
