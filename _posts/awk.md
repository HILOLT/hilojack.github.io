---
layout: page
title:	edit
category: blog
description: 
---
# Preface
# 显示指定列 
	$ awk '{print $1, $4}' netstat.txt
	$ awk '{printf "%-8s %-8s %-8s %-18s %-22s %-15s\n",$1,$2,$3,$4,$5,$6}' netstat.txt

# filter
	$ awk '$3==0 && $6=="LISTEN" ' netstat.txt
	$ awk ' $3>0 {print $0}' netstat.txt
	# 如果需要第一行(NR表示行数)
	$ awk '$3==0 && $6=="LISTEN" || NR==1 ' netstat.txt

# Variable
## Inner Variables
说到了内建变量，我们可以来看看awk的一些内建变量：
	$0	当前记录（这个变量中存放着整个行的内容）
	$1~$n	当前记录的第n个字段，字段间由FS分隔
	FS	输入字段分隔符 默认是空格或Tab (Field Separator)
	NF	当前记录中的字段个数，就是有多少列(Num of Field)
	NR	已经读出的记录数(Line Recoder)，就是行号，从1开始，如果有多个文件话，这个值也是不断累加中。(Num of Record)
	FNR	当前记录数，与NR不同的是，这个值会是各个文件自己的行号
	RS	输入的记录分隔符， 默认为换行符
	OFS	输出字段分隔符， 默认也是空格
	ORS	输出的记录分隔符，默认为换行符
	FILENAME	当前输入文件的名字
	$5+ENVIRON["y"] 系统环境变量
	$ awk -v val=$x '{print $1+val}' a.txt val 是参数

### 指定分隔符

	$  awk  'BEGIN{FS=":"} {print $1,$3,$6}' /etc/passwd
	# It same as 
	$ awk  -F: '{print $1,$3,$6}' /etc/passwd

# 数组
	#awk 将 myarr["1"] 和 myarr[1] 指向同一元素, 这类似于php
	myarray[1]="jim"
	myarray['name']="Ye"

## delete
	delete arr[1]
## in
	if('Ye' in myarray){
		print "Yep! It's here!"
	}
## for-in
	for ( x in myarray ) {
			 print myarray[x]
	}


# printf & print
	printf("%s got a %03d on the last test\n","Jim",83)
	myout=("%s-%d",b,x)
	print myout

	#print 打印字符串可以以","分隔, 也可以以空格分格.
	print "Hi",",","how are you";
	print "Hi" "," "how are you";

# String
## String Func
	print length(str)
	print index("mainstr", 'str'); #5
	tolower(str)
	toupper(str)
	substr(mystring,startpos,maxlen)	
	match(mystring,/you/); # 如果没有找到, 返回0
### 替换
	sub(regexp,replstring,mystring)
	gsub(regexp,replstring,mystring); #全局替换
### split
	numelements=split("Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec",mymonths,",")
	调用 split() 时，第一个自变量包含要切开文字字符串或字符串变量。在第二个自变量中，应该指定 split() 将填入片段部分的数组名称。在第三个元素中，指定用于切开字符串的分隔符。split() 返回时，它将返回分割的字符串元素的数量。split() 将每一个片段赋值给下标从 1 开始的数组，因此以下代码：
	print mymonths[1],mymonths[numelements]

### 简短注释 
-- 调用 length()、sub() 或 gsub() 时，可以去掉最后一个自变量，这样 awk 将对 $0（整个当前行）应用函数调用。要打印文件中每一行的长度，使用以下 awk 脚本：

	{
					 print length()
	}


## 字符串匹配
	$ awk '$6 ~ /FIN/ || NR==1 {print NR,$4,$5,$6}' OFS="\t" netstat.txt #~ 模式匹配开始

	$ awk '/LISTEN/' netstat.txt
	# Same as Below
	$ grep -F 'LISTEN' netstat.txt
	$ awk '/FIN|TIME/' netstat.txt

	awk '/[0-9]+\.[0-9]*/ { print }'
		$1 == "fred" { print $3 }
		$5 ~ /root/ { print $3 }

## 模式取反
	$ awk '$6 !~ /WAIT/ || NR==1 {print NR,$4,$5,$6}' OFS="\t" netstat.txt # ~ 模式匹配开始
	$ awk '$6 !~ /WAIT/' netstat.txt
	$ awk '!/WAIT/' netstat.txt

# Expresion
## condition expresion
1. 命令行

	$ awk 'NR!=1{if($6 ~ /TIME|ESTABLISHED/) print > "1.txt";
	else if($6 ~ /LISTEN/) {print > "2.txt";}
	else print > "3.txt" }' netstat.txt

2. Script脚本

	cat condition.awk
		{
			 if ( $1 == "foo" ) {
				if ( $2 == "foo" ) {
				   print "uno"
				} else {
				   print "one"
				}
			 } else if ($1 == "bar" ) {
				print "two"
			 } else {
				print "three"
			 }
		}

多个条件:

	( $1 == "foo" ) && ( $2 == "bar" ) { print } #cmd line

## do-while
	 {
		 count=1
		 do {
				print "I get printed at least once no matter what"
			if( x == 10 ){
				break
				continue
			}
		 } while ( count != 1 )
	}

## for 

	for ( x = 1; x <= 4; x++ ) {
		 print "iteration",x
	}


# Split File
按第6列拆分文件:

	$ awk 'NR!=1{print > $6}' netstat.txt #$6 是文件名

指定列

	$ awk 'NR!=1{print $4,$5 > $6}' netstat.txt
	
# 统计
	$ ls -l  *.cpp *.c *.h | awk '{sum+=$5} END {print sum}'
	$ awk 'NR!=1{a[$6]++;} END {for (i in a) print i ", " a[i];}' netstat.txt

# 语句体
	BEGIN{ 这里面放的是执行前的语句 }
	END {这里面放的是处理完所有的行后要执行的语句 }
	{这里面放的是处理每一行时要执行的语句}

# Script
	 awk -f my.awk file
	 cat my.awk
	 	BEGIN {
			 FS=":"
		 }
		 { print $1 }
