---
layout: page
title:	Shell Programming
category: blog
description: 
---

# Preface

# Variable
	let num++
	let ++num
	num+=1
## readonly
	x=6
	readonly x

### PS1
	PS1 命令提示符
	PS1='\[\e[1;31m\][\u@\W]\$\[\e[m\]' #\[\e[1;31m\] 是红色粗体, \[\e[m\] 是正常颜色值.

## 输出变量
	echo $v
	echo ${v}
### bash 中的换行
建议使用zsh. bash的不会将单双引号中的`\n`解析为换行.

	echo "a\nb" #没有换行的,\n会被原样输出
	echo $'a\nb' #这样才能换行

> 建议使用zsh 或者 printf 'a\nb %s' $str

## shell 特殊变量
	$$          脚本运行的当前进程的ID号
	$!           后台运行的最后一个进程的ID号
	$#          传递到脚本的参数个数
	$@        	传递给脚本的参数数组
	$*        	传递给脚本的参数字符串
	$-          显示shell使用的当前选项
	$?          显示最后命令的退出状态，0表示无错误
	$0				Current Process's ScriptPath

### Get Script File Path
In bash(>=3):

	$0				Current Process's ScriptPath
	BASH_SOURCE	Current Script's ScriptPath

In zsh:

	$0				Current Script's ScriptPath

	$ cat s.sh
	#!/bin/bash
	printf '$0 is: %s\n $BASH_SOURCE is: %s\n' "$0" "$BASH_SOURCE"

	bash-3.2$ ./s.sh
		$0 is: ./s.sh,$BASH_SOURCE is: ./s.sh
	bash-3.2$ source s.sh
		$0 is: bash,$BASH_SOURCE is: s.sh

## 赋值
	v=value #注意=两边不能有空格,这是规定!
	unset v ;#删除字符串
### 交互
	read [-pt] variable
	选项与参数：
	-p  ：后面可以接提示字符！
	-t  ：后面可以接等待的『秒数！』这个比较有趣～不会一直等待使用者啦！

	## read line
	while read line;
	do
		echo $line
	done < file


### 声明
	 declare [-aixr] variable
	 typeset [-aixr] variable

	 选项与参数：
	 -a  ：将后面名为 variable 的变量定义成为数组 (array) 类型
	 -i  ：将后面名为 variable 的变量定义成为整数数字 (integer) 类型
	 -x  ：用法与 export 一样，就是将后面的 variable 变成环境变量；
	 -r  ：将变量配置成为 readonly 类型，该变量不可被更改内容，也不能 unset
	 declare -p var  :单独列出变量类型

	unset var #销毁变量

## 数据类型
### String字符串
#### 引号
要注意的是shell中的单引号内所有字符都会原样输出, 包括	`\`.
而双引号内,这些字符会被转义`\"` `\r` `\n` `\t` , 而这两个字符`\'`, 原样输出.

	echo 'It'\''s Jack'; //output: It's Jack
	echo "\""; //output: "
	echo "\'"; //output: \'

ps: echo 会解析 -n \007 \x31
	
	echo '-n' //换行
	echo '\x31'
	echo "\x31"
	echo "\021"
	
#### 拼接
	$PATH:otherStr #拼接.
	${var}otherStr

#### length
	echo ${#str}
	echo "1"|awk '{print length($0)}' 
	echo "1" | wc -c #会多一个换行符
    #len=`expr length $str` 

#### index
	awk -v str="$a" -v substr="$b" 'BEGIN{print index(str,substr)}'; #

#### match 
	[ $(echo "$st" | grep -E "^[0-9]{8}$") ] && echo "match"

#### 截取
	echo ${str:start:length}
	echo ${str: -1}; #负数前面需要有空格
	echo ${str:(-1)}; #或者负数用括号. 否则负数不会生效

#### 替换与删除
	变量配置方式	说明
	${变量#关键词}	若变量内容从头开始的数据符合『关键词』，则将符合的最短数据删除
	${变量##关键词}	若变量内容从头开始的数据符合『关键词』，则将符合的最长数据删除

	${变量%关键词}	若变量内容从尾向前的数据符合『关键词』，则将符合的最短数据删除
	${变量%%关键词}	若变量内容从尾向前的数据符合『关键词』，则将符合的最长数据删除
	${变量/旧字符串/新字符串}	若变量内容符合『旧字符串』则『第一个旧字符串会被新字符串取代』
	${变量//旧字符串/新字符串}	若变量内容符合『旧字符串』则『全部的旧字符串会被新字符串取代』

#### 变量测试
	: 判断是否非空/默认判断是否声明
	- 不存在则设置
	+ 存在则设置
	= 结合了- 和 改写原值
	? 结合了- 并 输出expr到stderr
	变量配置方式	str 没有配置	str 为空字符串	str 已配置为非空字符串
	var=${str-expr}	var=expr		var=$str		var=$str
	var=${str:-expr}var=expr		var=expr		var=$str
	var=${str+expr}	var=			var=expr		var=expr
	var=${str:+expr}var=			var=			var=expr
	var=${str=expr}	str=${str-expr}; var=str;
	var=${str:=expr}	
	var=${str?expr}	expr输出至stderr var=$str		var=$str
	var=${str:?expr}expr输出至stderr expr输出stderr	var=$str
	　
### 数字

#### Caculate 运算
下面介绍的inner运算和expr都不支持小数, 虽然不会报错, 但计算结果让人无语. 如果需要小数, 请使用bc(无论如何, shell 计算很鸡肋, 如果需要请请使用python等脚本)

	# 不要用inner calc 和 expr 做 float 运算!!
	➜  ~  a=-2+1.1; declare -p a;
	typeset -i a=0
	➜  ~  a=2+1.1; declare -p a;
	typeset -i a=3

##### Inner Calc 
zsh shell 内置支持简单的+-*/%

	declare -i a=1;
	let ++a; let a++;//a也可以为字符串
	a+=2; #shell 不允许有空格
	a=a%50*3-10; 

##### expr 运算
    expr 14 % 9 #需要有空格
    expr 14 \* 3 #*在shell中有特别的含义(它是通配符wildcard)
		expr '14 * 3' #最好是直接放在引号里面
##### bc 运算
	echo '14*3' | bc #bc更精确
	echo '2.1*3' |bc #6.3
#### 生成数字序列
这不是数组!而是以空格为间隔的字符串序列!

	for i in {1..5}; do echo $i; done #Brace expansion是在其它所有类型的展开之前处理的包括参数和变量展开
	END=5;
	$ echo {1..5}
	$ for i in `seq $END`; do echo $i; done #或者用 for i in $(seq $END); do echo $i; done
	$ for i in `eval echo {1..$END}`; do echo $i; done

seq 用法: man seq

	seq [first [incr]] last

#### Format Num
	`printf "%02i\n" $num`


### Array数组
定义:

	var=(1 2 3 4 5)
	var[num]=content

赋值:
	var[num]=value;
	var[字符]=value; #相当于var[0]=value;

使用:

	${var[index]}
	$var or ${var[@]} or ${var[*]} #输出整个数组
	${#var} or ${#var[@]} or ${#var[*]} #输出数组长度

截取:
	echo ${a[@]:start:length}
	c=(${a[@]:1:4}) #加上()后生成一个新的数组c

替换:
	a=(1 2 3 13 4 5)
	echo ${a[@]/3/ahui} #得到 1 2 ahui 1ahui 4 5

清除:
	unset var[0] #清除下标, 其它下标的顺序不会变

#### in_array
shell 参数不支持array传递.只能变通实现[in_array](http://stackoverflow.com/questions/5788249/shell-script-function-and-for-loop)了
1. 用shift 实现
shift: 左移出 (注意:shell 不支持unshift push pop)

	in_array(){
		el=$1
		shift
		while test $# -gt 0; do
				test $el = $1 && return 0
				shift
		done
		return 1
	}
	arr=( 1 2 'Hello Jack');
	in_array 'Hello Jack' $arr && echo has;

2. 利用eval 访问外围的arr
	in_array(){
    a=$2
    eval "for i in \${$a[@]}; do
        echo \$i
        test $1 = \$i && return 1
    done"
    return 0
	}
	arr=( 1 2 'It'\''s Jack');
	in_array 'Hello Jack' arr && echo has;


##  环境变量
	env #查看环境变量 与说明
	env var1=1 var2=2 php -r 'var_dump($_SERVER);'  #执行其它信命令时, 指定环境变量
	set #查看环境变量与自定义变量.
	export  #查看环境变量的生成语句(declare -x)

## 环境配置stty,set
	set # 查看/设置 环境变量与本地变量
	set -o nounset # 引用未定义的变量(缺省值为"")
	set -o errexit # 执行失败时, 命令被忽略

	set :
	allexport                -a                        从设置开始标记所有新的和修改过的用于输出的变量          
	braceexpand         -B                      允许符号扩展,默认选项   
	emacs                                            在进行命令编辑的时候,使用内建的emacs编辑器, 默认选项
	errexit                   -e                        如果一个命令返回一个非0退出状态值(失败),就退出.
	histexpand           -H                      在做临时替换的时候允许使用!和!! 默认选项
	history                                           允许命令行历史,默认选项
	ignoreeof                                     禁止coontrol-D的方式退出shell，必须输入exit。
	interactive-comments                  在交互式模式下， #用来表示注解
	keyword             -k                     为命令把关键字参数放在环境中
	monitor               -m                      允许作业控制
	noclobber           -C                      保护文件在使用重新动向的时候不被覆盖
	noexec                 -n                       在脚本状态下读取命令但是不执行，主要为了检查语法结构。
	noglob                -d                       禁止路径名扩展，即关闭通配符      
	notify                 -b                        在后台作业以后通知客户
	nounset              -u                         在扩展一个没有的设置的变量的时候，    显示错误的信息      
	onecmd               -t                          在读取并执行一个新的命令后退出        
	physical              -P                       如果被设置，则在使用pwd和cd命令时不使用符号连接的路径 而是物理路径
	posix                                             改变shell行为以便符合POSIX要求
	privileged                                       一旦被设置，shell不再读取.profile文件和env文件 shell函数也不继承任何环境
	verbose             -v                            为调试打开verbose模式
	vi                                                  在命令行编辑的时候使用内置的vi编辑器
	xtrace                  -x                            打开调试回响模式

	stty [-a]
	选项与参数：
	-a  ：将目前所有的 stty 参数列出来；
	eof   : End of file 的意思，代表『结束输入』。
	erase : 向后删除字符，
	intr  : 送出一个 interrupt (中断) 的讯号给目前正在 run 的程序；
	kill  : 删除在目前命令列上的所有文字；
	quit  : 送出一个 quit 的讯号给目前正在 run 的程序；
	start : 在某个程序停止后，重新启动他的 output
	stop  : 停止目前屏幕的输出；
	susp  : 送出一个 terminal stop 的讯号给正在 run 的程序。

# Exec Command
## `cmd` or $(cmd)
以子进程执行cmd.(你也可能通过source 以当前进程执行cmd)

	`cmd` or $(cmd)
	ls -l `locate crontab`

	source cmd or . cmd #这会执行login 过程中的~/.bash_profile .profile

\`\`内嵌时需要转义

	echo "`ls \`which ls\``"
	echo "$(ls `which ls`)"


>	ps: a=`cmd` #如果cmd 中含有\r, 则每次\r会把前面的字符给干掉. 可以 a=`cmd | tr "\r\n" "-+"`

## 文件名参数
有些命令需要以文件名为参数，这样一来就不能使用管道。这个时候 <() 就显出用处了，它可以接受一个命令，并把它转换成可以当成文件名之类的什么东西：

	# 下载并比较两个网页
	diff <(wget -O - url1) <(wget -O - url2)

## heredoc
	# 任何字词都可以当作分界符 (cat < file)
	cat  << MM
	echo $? #支持变量替换
	MM
	
	#加引号防止变量替换
	cat << 'MM' > out.txt
	echo $?
	MM

## Caculation
## expr 
expr 算式:

	x=`expr $x + 1` ; #$x 与 + 与 1 之间必须有空格, 否则被expr视为字符串	
## bc expression
	x=`echo $x^3 | bc`; #bc 较expr限制少, 支持大量的数学符号(而expr 仅支持+-*/%)

## let 
let 数学式:

	let x=$x+1;echo $x; # let 没有返回值的

## 双括号(())
1. 支持-+*/%
2. 支持随机数

	echo $((RANDOM%100)) 
	
# Condition Expression
	if [ -x file ]; then  # 语法规定[]两边必须有空格
	　 .... 
	elif test "$a" = "$b" ; then 
		...
	elif [ "$a" = "$b" ] ; then 
	　 .... 
	elif [ "$a" == "$b" ] ; then #shell Condition 中 "==" /"=" 两者是相同的 . 没有全等"==="
	　 .... 
	else 
	　 .... 
	fi

参考: [shell表达式](http://www.cnblogs.com/chengmo/archive/2010/10/01/1839942.html)

## 测试符号
shell 这些测试表达式

	## expr 中 测试符号 两边要有空白. 且不支持<= , >=
	test expr
	[ expr ]
	[[ expr ]] # 较[ expr ] 更严格, 不用转义< > &&,||

	## 双括号, 支持我们所熟悉的> >= < <= == !=, 且符号两边不用留空白 .不会支持(-d, -eq ...)
	((expr))


### 逻辑测试
	&& -a # and
	|| -o # or
	! #取反
	! test '' && echo 0
	! ((1>1)) && echo 0

### 文件测试
	### 关于档案与目录 测试文件的状态 
	-d 是否为目录
	-e 路径是否存在
	-f 是否为文件
　　-c file　　　　　文件为字符特殊文件为真 
　　-b file　　　　　文件为块特殊文件为真 
　　-s file　　　　　文件大小非0时为真 
　　-t file　　　　　当文件描述符(默认为1)指定的设备为终端时为真  这个测试选项可以用于检查脚本中是否标准输入 ([ -t 0 ])或标准输出([ -t 1 ])是一个终端.
	-L 是否为链接文件
	-S 是否为socket文件
	-p	侦测是否为程序间传送信息的 name pipe 或是 FIFO

	### 关于程序的逻辑卷标！
	-G	你所有的组拥有该文件
	-O	你是文件拥有者
	-N	文件最后一次读后被修改

	### 档案权限
	-r	侦测是否为可读的属性
	-w	侦测是否为可以写入的属性
	-x	侦测是否为可执行的属性
	-s	侦测是否为『非空白档案』
	-u	侦测是否具有『 SUID 』的属性
	-g	侦测是否具有『 SGID 』的属性
	-k	侦测是否具有『 sticky bit 』的属性

	## 两个档案之间的判断与比较
	-nt	第一个档案比第二个档案新
	-ot	第一个档案比第二个档案旧
	-ef	第一个档案与第二个档案为同一个档案（ hard link or symbolic file）

	!	反转以上测试

### 字符串测试 
	
	=	相等
	== 与= 相同(-1: Do not use "==". It is only valid in a limited set of shells, zsh do not support it)
	!= 不相等

	<	按ascii比较	
		if [[ "$a" < "$b" ]]
		if [ "$a" \< "$b" ] 注意"<"字符在[ ] 结构里需要转义, 这个是重定向控制符

	>	按ascii比较	

	-z	空字符串
	-n	非空字符串

### 数字比较

	-eq	等于 应用于：整型比较
	-ne	不等于 应用于：整型比较
	-lt	小于 应用于：整型比较
	-gt	大于 应用于：整型比较

	-le	小于或等于 应用于：整型比较
	-ge	大于或等于 应用于：整型比较

	## 双括号(语法宽松, 但不支持字符串比较, 字符串比较请使用[[ expr ]])
	> 双括号
	>= 双括号
	< 双括号
	<= 双括号
	== 双括号
	!= 双括号

# 括号
	(cmd1; cmd2) 	以子shell执行命令集
		arr=(1 2 3) 也用于初始化数组
	[ expr ] 		测试,  test expr 等价
		[ 1 ] && echo 1 # true
		[ 0 ] && echo 1 # true
		[ '' ] && echo 1 # false
		[ $(echo $str | grep -E '^[0-9]+$') ] && echo 1 #小心命令替换出现恶意字符 导致syntax error.
	{ cmds;}		命令集 
		for i in {0..4};do echo $i;done 产生一个for in序列
		ls {a,b}.sh		通配符(globbing)
		echo a{p,c,d,b}e # ape ace ade abe
		echo {a,b,c}{d,e,f} # ad ae af bd be bf cd ce cf
		{code block}


	$(cmd1;cmd2) 	命令结果替换 相当于`cmds`, 会将命令输出作为结果返回(带$都有这个意思)
	$[ expr ] 		以常用数学符号做计算 完全等价$((expr))
	${var}			变量 


	((expr1,expr2, ...))	 	以常用数学符号做计算(+-*/%=), 提供随机数RANDOM, 以最后expr的结果为返回状态码
		((a=1,a=2,a=1,RANDOM%100)) && echo 'true'
		for (( a=0 ; a<10 ; a++ )); do echo $a; done # for中双括号用的是分号哦
	[[ expr ]] 		比[ expr ] 更严格而规范的测试, 不用转义 >,< ,||, && 这个是重定向控制符, 管道, 命令连接 杜绝了当a为空时 [ $a = '' ] && echo true; 会出错($a在[]必须"$a", 而[[ ]] 不用对$a使用双引号)
	{{ }} 			syntax error

	$((expr))	 	返回((expr1,expr2,...))计算结果
	$[[ expr ]]  syntax error
	${{ }} 			syntax error

## ((expr)) , $((expr)) and $[expr]
	((expr))	 以常用数学符号做计算, 结果会转为boolen型
	$((expr))	 只能用于赋值语句, 输出语句(echo/print),	以常用数学符号做计算
	$[expr]	 	与$((expr))完全一样

	((x=1)) && echo b #先执行赋值语句 x=1, 再做逻辑判断
	((1*0)) && echo b 
	((1>0)) && echo b 
	((a++))
	((x+=10)) 

	echo $((3+3))
	x=$(($a+3))
	x=$[$a+3]


## (cmds) or { cmds;} 一串命令
()和{}都是对一串的命令进行执行，但有所[区别](http://my.oschina.net/xiangxw/blog/11407)：

	A,()只是对一串命令重新开一个子shell进行执行
	B,{}对一串命令在当前shell执行
	C,()和{}都是把一串的命令放在括号里面，并且命令之间用;号隔开
	D,()最后一个命令可以不用分号
	E,{}最后一个命令要用分号
	F,{}的第一个命令和左括号之间必须要有一个空格
	G,()里的各命令不必和括号有空格
	H,()和{}中括号里面的某个命令的重定向只影响该命令，但括号外的重定向则影响到括号里的所有命令

	(var=notest; echo $var) # 无空格限制 
	{ var=notest; echo $var;} # 开头有一空格, 结尾必须有分号.


# Loop

	for a in $* ; do echo "$a "; done
	for file in Downloads/* ; do echo "$file"; done #遍历文件
	for file  (Downloads/*) ; do echo "$file"; done #遍历文件(zsh)
	for ((i=0;i<10;i++)); do echo $i; done;

	while expr;
	do
		.. expr;
	done;
	declare -i i=0; until (($i>=3)); do  echo $i;let i++; done #output: 0 1 2

# case
	case "$string" in
		(*$SUBSTRING*) echo "$string matches";;　＃条件以右括号结尾, 左括号可省略.           每个条件判断语句块都以一对分号结尾 ;;.  
		(*)            echo "$string does not match";;
	esac

# function
	function fun(){
		local 变量=值 #和js的变量范围类似
		echo $1 $2
		return 3;
	}
	fun 2 3
	echo $? #函数返回值

# About Shell Script
## Arguments
	$@ = $* = "$1 $2 $3 ..."
	for a in $* ; do
		echo $a;
	done


# Tools & Some cmds
## mail
	echo 'str'|mail -s 'subject' name@email.com

## 性能
	time cmd

	$ time (for m in {1..100000}; do [[ -d . ]];done;)
	real	0m0.438s
	user	0m0.375s
	sys	0m0.063s

## type
查看命令类型
	type ll
	type -t ll

# 调试debug
	sh -x myscript.sh #跟踪每一句的执行
	zsh -x a.sh

# Reference
[shell manual]

[shell manual]: http://blog.51yip.com/manual/shell/
[bash 进阶]: http://blog.sae.sina.com.cn/archives/3606
