---
layout: page
title:	Shell bash Shortcut
category: blog
description: 
---

#序

本文描述的是bash命令行的一些技巧.其中一些技巧局限于使用环境,比如secureCRT.

# 定位
##	光标移动

	CTRL-A/E #跳到行首/行尾
	ALT-B/F #按单词移动光标左/右 默认的mata为ESC，所以ESC-B/F也生效的
	CTRL-left/right #按单词移动光标左/右
	CTRL-B/F #光标左移/右移
	Alt-Mouse Click #通过鼠标点击(iTerminal)

##　编辑

	CTRL-U/K #删除光标前/后所有字符
	CTRL-W/ALT-D #删除光标前/后一个词　（alt-d　等效esc-d）
	CTRL-H/D #删除光标前/后的一个字符

	CTRL-T #光标所在字符与前面的字符作交换

## 复制/粘贴(copy & paste)

	CTRL-Y #粘贴所删除内容
	CTRL-_ #撤消动作
	ALT-. #使用上一条命令的最后一个参数

### gnome-terminal下的复制粘贴:

	SHIFT-CTRL-C/V #复制/粘贴gnome系统剪切板
	SHIFT-CTRL-T #新建tab

##	窗口定位(gnome)
	ALT+NUM #tab 切换(会占用[readline])
	ALT-CTRL-T #新建terminal window

# 历史记录

	CTRL-P/N #上/下一条历史记录
	CTRL-R #历史搜索
	CTRL-G #退出历史搜索

# Bang(!)命令
	
	!!  执行上一条命令（或者!-1）
	!!:p  打印上一条命令
	!wget  执行最近一条以wget打头的命令
	!wget:p  打印最近一条以wget打头的命令
	!$  执行上一条命令的最后一个参数（alt-. 和 $_类似）
	!-n 扫行最近第n条命令
	^foo 删除上一条命令的foo并执行
	^foo^bar 用bar替换上一条命令的foo并执行(全部替换)
	^foo^bar^ 用bar替换上一条命令的foo并执行（只替换一次）

# 控制命令

	CTRL-L #清屏
	CTRL-O #执行当前命令并选择上一条命令
	CTRL-S/Q #阻止屏幕输出／允许屏幕输出
	CTRL-C #终止命令
	CTRL-Z #挂起命令

# 重复

## 重复操作
在shell中也有类似vim的num {motion}功能--[readline].也就是用数字指定操作次数.当然,与vim相比,功能相当弱.
用法为:
	
	`MetaKey` + `Count`  Command 

其中:
	
	MetaKey :一般默认的Meta Key是`Alt`,或`Esc`.
	Count:repeat的次数,如果是负数,则是相反的意思
	Command: 可以是字符/快捷键.(如果是数字,以CTRL+V与Count相分隔)

以下是例子:
	
	`MetaKey`+`12` a #输出12个a
	`MetaKey`+`3` ALT+B #光标左移三个单词
	`MetaKey`+`-3` ALT+B #光标右移三个单词(-负数时,动作取反)
	`MetaKey`+`13` CTRL+V 0 #输出13个0

有更多的技巧吗?请留言，谢谢．

# 参考
[readline]  
[shell_shortcutKey]

[readline]: http://stackoverflow.com/questions/562115/press-alt-numeric-in-bash-and-you-get-arg-numeric-what-is-that
[shell_shortcutKey]: http://coderbee.net/index.php/linux/20130424/41
