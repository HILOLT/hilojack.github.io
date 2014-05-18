---
layout: page
title:	edit
category: blog
description: 
---
# Preface
# cut
	cut -d: -f 1,3
	cut -d: -f 1
	cut -d: -f 2- 
	-d "delim"
	-f field
	-c list #按字符截取(这个参数是独立的)

# grep
	grep [-acinv] [--color=auto] 'pattern' filename
	选项与参数：
	-a ：将 binary 文件以 text 文件的方式搜寻数据
	-c ：计算找到 '搜寻字符串' 的次数
	-i ：忽略大小写的不同，所以大小写视为相同
	-n ：顺便输出行号
	-v ：反向选择，亦即显示出没有 '搜寻字符串' 内容的那一行！
	-F : 不解释pattern, pattern作为固定的字符串
	-o : 只输出匹配字符串
	--include=PATTERN     Recurse in directories only searching file matching PATTERN.
	--exclude=PATTERN     Recurse in directories skip file matching PATTERN.
    --exclude-dir=PATTERN
	--color=auto ：可以将找到的关键词部分加上颜色的显示喔！
	 -L, --files-without-match
             Only the names of files not containing selected lines are written to standard output.  Pathnames are listed once per file searched.  If the standard input is searched,
             the string ``(standard input)'' is written.

     -l, --files-with-matches
             Only the names of files containing selected lines are written to standard output.  grep will only search a file until a match has been found, making searches potentially
             less expensive.  Pathnames are listed once per file searched.  If the standard input is searched, the string ``(standard input)'' is written.
	-h, --no-filename
	-E, --extended-regexp

## multi patterns
	grep -f patterns.txt data.txt
	grep -vf patterns.txt data.txt


If you want to do the minimal amount of work, change

	grep -o -P 'PATTERN' file.txt
to

	perl -nle'print $& if m{PATTERN}' file.txt

So you get:

	var1=`perl -nle'print $& if m{(?<=<st:italic>).*(?=</italic>)}' file.txt`
	var2=`perl -nle'print $& if m{(property:)\K.*\d+(?=end)}' file.txt`

However, you can achieve simpler code with extra work.

	var1=`perl -nle'print $1 if m{<st:italic>(.*)</italic>}' file.txt`
	var2=`perl -nle'print $1 if /property:(.*\d+)end/' file.txt`

> $print $& 打印全部匹配到的字段,  而print $1而为打印第一个括号

# sort, wc, uniq

	sort [-fbMnrtuk] [file or stdin]
	选项与参数：
	-f  ：忽略大小写的差异，例如 A 与 a 视为编码相同；
	-b  ：忽略最前面的空格符部分；
	-M  ：以月份的名字来排序，例如 JAN, DEC 等等的排序方法；
	-r  ：反向排序；
	-u 去重
	-n 数字
	-r 降序
	-o file 防止重定向清空文件sed a.txt > a.txt
	-k 2 指定排序列
	-t '一个字符' 指定分隔符

# uniq
	uniq [-ic]
	选项与参数：
	-i  ：忽略大小写字符的不同；
	-c  ：进行计数
# wc
	wc [-lwmc]
	选项与参数：
	-l  ：仅列出行；
	-w  ：仅列出多少字(英文单字)；
	-m  ：多少字符；
	-c	多少字节

# tr, col, join, paste, expand(字符转换命令)
## tr
删除一段文字, 或者替换字符
	echo 'a : b' | tr 'a-z' 'A-Z' #替换 -有特别的含义哦
	echo 'a : b' | tr 'a\-z' 'A\-Z' #- 需要转义
	echo 'a : b' | tr -d 'ab' #删除

## col
过滤控制字符
转换tab
	echo -e "a\tb" |col -x # -x 转换tab为空白
	man col |col -b # 过滤控制字符
	man col |cat -A # 显示控制字符

## expand
将tab替换成空格(-t 指定空格数, 默认是8个)
	expand [-t] file
	expand -t 8 file  #与 col -x 相同 
	expand - #从stdinput 读取

## join
	join [-ti12] file1 file2
	选项与参数：
	-t  ：join 默认以空格符分隔数据，并且比对『第一个字段』的数据，
		  如果两个文件相同，则将两笔数据联成一行，且第一个字段放在第一个！
	-i  ：忽略大小写的差异；
	-1  ：这个是数字的 1 ，代表『第一个文件要用那个字段来分析』的意思；
	-2  ：代表『第二个文件要用那个字段来分析』的意思。

	$ join -t ':' -1 4 -2 3 /etc/passwd /etc/group  # 如果是乱序的需要对字段进行sort
	0:root:x:0:root:/root:/bin/bash:root:x:root
	1:bin:x:1:bin:/bin:/sbin/nologin:bin:x:root,bin,daemon
	2:daemon:x:2:daemon:/sbin:/sbin/nologin:daemon:x:root,bin,daemon

## paste
直接将两个文件按行以tab连一起

	paste [-d] file1 file2
	选项与参数：
	-d  ：后面可以接分隔字符。默认是以 [tab] 来分隔的！
	-   ：如果 file 部分写成 - ，表示来自 standard input 的数据的意思。


# split
	 split [-bl] file PREFIX
	选项与参数：
	-b  ：后面可接欲分割成的文件大小，可加单位，例如 b, k, m 等；
	-l  ：以行数来进行分割。
	PREFIX ：代表前导符的意思，可作为分割文件的前导文字。

	split -b 100k file pre_hilo
	cat pre_hilo* > file
