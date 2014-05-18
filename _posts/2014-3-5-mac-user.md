---
layout: page
title:	mac user manager
category: blog
description: 
---

# Preface
mac下没有adduser, 那如何在mac中添加用户/组?

# 命令行操作 
## 交互
在命令行：
 
	dscl localhost

进入组目录

	cd /Local/Default/Groups

使用ls 你就可以看到所有的group，  /Local/Default/Users 可以看到所有的用户
然后添加组:

 append groupname GroupMembership username

## 非交互
单独用命令完成:

	dscl . append /Groups/vboxusers GroupMembership hilojack
	#或者
	append vboxusers GroupMembership hilojack	#sudo usermod -a -G vboxusers hilojack

	#删除组用户
	delete groupname GroupMembership username

# 图形操作 

  "System preferences" -> "Accounts" -> "+" (as if you were adding new account) -> Under "New account" select "Group" -> Type in group name -> "Create group"



