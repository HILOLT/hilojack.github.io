---
layout: page
title:	sed 简记
category: blog
description: 
---
# Abstract
sed作为字符串处理工具本身太强大了，因为经常忘记一些语法，故在此做个小记.

>ps: mac 下的sed与linux下的gnu sed有很大的不同，建议安装gsed（如果你熟悉gnu-sed）: brew install gnu-sed

mac 下的BSD sed 非常怪异: 

	sed -i '.ori' $'/^PATH=/c\\\n sth.' a.txt #> a.txt.ori (注意bash的string不直接支持\n, 只能使用$'string\n' , 不是$"string\n"哈, $"string\n"与 "string\n"没有分别)
	sed -i '' "/^PATH=/ c\\
	sth." a.txt #> a.txt 

而linux下则简单多了

	gsed '/^PATH=/c sth.' a.txt > a.txt.ori
	gsed -i '/^PATH=/c sth.' a.txt #> a.txt


# 关于操作码
s替换d删除i插入a追加
## 字符串替换s
	$ sed -i "s/pattern/replace/g" a.txt 
	$ sed -i "n,ms/pattern/replace/g" a.txt //指定行
	$ sed -i "s/pattern/replace/ng" a.txt //指定该行的第n个字符开始搜索
### 引用
	//&引用search
	$ sed 's/my/ha-&/g' my.txt 与 sed 's/my/ha-my/g' my.txt 相同
	//\1 引用search中的第一个括号
	$ sed 's/\(my\)/\1/g' my.txt 与 sed 's/my/my/g' my.txt 相同
## i and a
插入和追加

	$ sed '1 i a' pets.txt//sed '1ia' pets.txt 
	$ sed '1 a sth.' pets.txt

利用匹配追加与插入

	$ sed  '/my/a' a.txt
	$ sed  '/my/i' a.txt

## c替换
	$ sed '2c Sth. else' a.txt
	$ sed '/my/c Sth. else' a.txt
## d删除
	$ sed '2d' a.txt
	$ sed '/my/d' a.txt

## p
	$ sed '2p' a.txt
	$ sed '2,3p' a.txt
	$ sed '/my/p' a.txt

# -n 
	sed -n '1p' a.txt //不输出原文

# 行范围
## 合并行
	$ sed 'N;s/my/your/' pets.txt //当前行与下一行视为同一行
	$ sed 'N;s/\n/,/' pets.txt //合并奇偶行
## 指定行范围
	$ sed 'n,mp' n到m行
	$ sed '/from pattern/,/to pattern/d' 
	$ sed '/from pattern/,+3d' //使用相对位置
# 命令打包
	# 对3行到第6行，匹配/This/成功后，再匹配/fish/，成功后执行d命令
	$ sed '3,6 {/This/{/fish/d}}' pets.txt
	# 从第一行到最后一行，如果匹配到This，则删除之；如果前面有空格，则去除空格
	$ sed '1,${/This/d;s/^ *//g}' pets.txt #用分号分割多个命令

	## 用分号分割命令;
	$ sed -n -e '=;p' myfile.txt #'=' 命令告诉 sed 打印行号，'p' 命令明确告诉 sed 打印该行（因为处于 '-n' 模式）
	## 用-e分割
	$ sed -n -e '=' -e 'p' myfile.txt

## 一个地址多个命令
	1,20{    s/[Ll]inux/GNU\/Linux/g     s/samba/Samba/g        s/posix/POSIX/g }

## regx
关于regex的支持, 见[Posix Regex](/p/regex.html)


# Reference
[sed 简明教程] 

[sed 简明教程]: http://coolshell.cn/articles/9104.html

