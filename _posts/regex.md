---
layout: page
title:	Posix Regex
category: blog
description: 
---
# Preface
正则分两大类:Posix和PCRE(Perl Compatible Regular Expression ). posix 已经很老了, 效率也没有PCRE高. 但是它被linux命令行广泛支持. 
在介绍Posix Regex之前, 我们先介绍一下wildcard

# wildcard 通配符
	* 多个字符
	? 单个字符
	[a-z] 字符范围
	[^a-z] 不在此字符范围(unix系统shell)
## Mysql 中的wildcard
	% 多个字符
	_ 单个字符

# Posix Expression

POSIX正则表达式分为：BRE(Basic Regular Expression)和ERE(Extended Regular Expressions)。

BRE 并非是ERE的子集.以下是它们的交集:

	\ 用于关闭后续字符的特殊意义。
	\n 对子模式的反引用(backreference) 支持\1到\9
	. 匹配任意单个的字符
	* 匹配任意数目的字符(可以为0)
	^ 匹配出现在行首或字符串开始位置的空字符串。ERE：置于任何位置都具特殊含义；BRE：仅在正则表达式的开头具有此特殊含义。
	$ 匹配出现在行末的空字符串。
	[...] 元字符 比如:
		[a-z] [^1-9] 
		[[:space:]] 空白符	也相当于perl中的\s
		[^[:space:]] 非空白符	也相当于perl中的\S
		[[:alnum:]] same as [a-zA-Z0-9] 
		[[:digit:]] same as [0-9] 也相当于perl中的\d
		[[:xdigit:]] same as [0-9a-fA-F]
		[[:alpha:]] same as [a-zA-Z]	
		[[:uppper:]] same as [A-Z]	
		[[:lower:]] same as [a-z]
		[[:punct:]] 标点	
		[[:<:]] 匹配单词的开始 	perl中的\b代表单词边界
		[[:>:]] 匹配单词的结束

## BRE专有

	\{n,m\} \{n,\} 限制它之前的元字符或者子模式重现的次数区间
	\( \) 子模式

# ERE 专有:
	{n,m} 
	+ 1个或多个元字符或子模式
	? 0/1个元字符或子模式
	* 0个或以上元字符或子模式
	| 或
	() 子模式

	echo -n ' ./alxxxxal 1.txt' | grep -E './(al).+\1'
	
# 支持情况
grep, sed 默认使用BRE. 
grep 通过`-E` 启用ERE
sed 通过`-r` 启用ERE
