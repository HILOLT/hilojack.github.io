---
layout: page
title:	
category: blog
description: 
---
# Preface
# iTerm2
zsh号称终极shell, 配合iTerm2(terminal)更强大. 引用池建强的总结(基本功能):

## window(tabs)
	Cmd-W close current tab 
	cmd-Num	Goto tab No. as Num.
	cmd-shift-[/] switch tab
	Cmd-Shift-Left/Right Reorder current tab.

	Cmd-Alt-E View all tab
	 cmd+enter Full Screen

### pane
	Cmd-D opens a new vertical pane with the default bookmark.
	cmd-opt-left/right switch panes
	Cmd-Shift-D opens a new horizonal pane with the default bookmark.(横向)

## find & paste
	查找和粘贴：command+f，呼出查找功能，tab 键选中找到的文本，option+enter 粘贴
	粘贴历史：shift+command+h
	光标去哪了？command+/
## 自动完成
	自动完成：command+; 根据上下文呼出自动完成窗口，上下键选择
	 回放功能：option+command+b
	 Expose Tabs：Option+Command+E

## 光标移动
	Alt+鼠标点点击, 移动到命令行其它位置
	 Ctrl+Left/Right: 按单词移动光标
	 Ctrl+u/k
	 Ctrl+a/e
	 Ctrl+f/b

## 链接
	在链接上按住cmd+单击 直接打开url


# zsh

## o~my~zsh
zsh的配置太复杂, 还好有好心人贡献了一个很好用的配置[o-my-zsh]

Install:
	wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

## conf
### theme
如果你对theme中的提示符不爽, 可以改PROMPT(在.oh-my-zsh/themes/*). 参考[zsh-conf](https://wiki.archlinux.org/index.php/zsh#Customizing_the_prompt) 
### conf files
At login, Zsh sources the following files in this [order](https://wiki.archlinux.org/index.php/zsh):

	~/.zshenv
	This file should contain commands to set the command search path, plus other important environment variables; it should not contain commands that produce output or assume the shell is attached to a tty.
	/etc/profile
	This file is sourced by all Bourne-compatible shells upon login: it sets up an environment upon login and application-specific (/etc/profile.d/*.sh) settings.
	~/.zprofile
	This file is generally used for automatic execution of user's scripts.
	~/.zshrc
	This is Zsh's main configuration file.
	~/.zlogin
	This file is generally used for automatic execution of user's scripts.

## 文件默认打开程序
	
	alias -s gz='tar -xzvf' #直接在命令行下输入tar文件, 就自动解压了
	alias -s tgz='tar -xzvf'
	alias -s zip='unzip'
	alias -s bz2='tar -xjvf'

## 强大的历史
输入grep 再按上下键, 会查阅所有以grep 打头的历史命令

## 目录跳转
	d<CR> #罗列所有访问过的目录 再输入数字<CR> 就直接进入到对应的目录
	-='cd -' #进入到上次的目录
	1='cd -'
	2='cd -2' #进入到上上次目录 默认设置了1~9

	..='cd ..'
	...='cd ../..'

## 通配符
	ls */*.sh
	ls <tab> #补全筛选

## 插件
.oh-my-zsh.sh 有这一行插件配置语句:

	plugins=(git textmate ruby autojump osx mvn gradle)
	brew install autojump #autojump需要安装一下

git插件旋转在`.oh-my-zh/plugins/git/git.plugin.zsh`.

介绍下这几个插件:

1、git：当你处于一个 git 受控的目录下时，Shell 会明确显示 「git」和 branch，如上图所示，另外对 git 很多命令进行了简化，例如 gco=’git checkout’、gd=’git diff’、gst=’git status’、g=’git’等等，熟练使用可以大大减少 git 的命令长度，命令内容可以参考~/.oh-my-zsh/plugins/git/git.plugin.zsh

2、textmate：mr可以创建 ruby 的框架项目，tm finename 可以用 textmate 打开指定文件。

3、osx：tab 增强，quick-look filename 可以直接预览文件，man-preview grep 可以生成 grep手册 的pdf 版本等。

4、autojump：zsh 和 autojump 的组合形成了 zsh 下最强悍的插件
	

	j dirname #智能dir跳转, 支持模糊匹配
	j -stat ＃显示记录的所有目录
