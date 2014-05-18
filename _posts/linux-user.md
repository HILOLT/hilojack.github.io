---
layout: page
title:	
category: blog
description: 
---

#
last #显示最后登录者
who #显示当前登录者

# usermod
User Modifier

	usermod -l new-name old-name
	usermod -u new-uid loginname
	usermod -d /home/new-home name
# umask
设定新建文件的默认权限:
	for file: 666 - umask
	for dir: 777 - umask

	umask #显示
	umask -S #显示
	umask 022
# permission
	r (read contents in directory)： ls 
	w (modify contents of directory)：touch rm mkdir mv (这些命令都需要x 权限做access)
	x (access directory)：cd ; ls -l ; ls --color=auto;
	rwx------. # `.`means an SELinux ACL (+ means a general ACL.)


注意: 
	rwxr--r-- root users dir
	rwxrwxrwx root users dir/a

如果用id:id=501(hilojack) gid=20(users) 去访问dir:
	
	$ ls dir
	a
	$ ls --color=auto dir
	ls: cannot access dir/a: Permission denied

# chattr

	chattr [+-=][ASacdistu] 檔案或目錄名稱
	選項與參數：
	+   ：增加某一個特殊參數，其他原本存在參數則不動。
	-   ：移除某一個特殊參數，其他原本存在參數則不動。
	=   ：設定一定，且僅有後面接的參數
	a 只能增加
	i 不能增加,不能删除

lsattr 
	
	lsattr [-adR] 檔案或目錄
	選項與參數：
	-a ：將隱藏檔的屬性也秀出來；
	-d ：如果接的是目錄，僅列出目錄本身的屬性而非目錄內的檔名；
	-R ：連同子目錄的資料也一併列出來！ 

# suid,sgid,sbit
suid/sgid 用于转换用户身份. 但是用户原来的rwx权限不会改变. 以前不能r(read) 照样不能read
适用: suid只适用binary file 
	sgid 适用binanry file + directory
作用: 用于以别的身份创建或者改写文件

sbit: sticky bit
适用: directory
作用: directory 下的文件, 只有自己和root 外的其它用户不能删除其中的文件

用法: 
	sudo chmod 2755 dir;
	sudo chmod g+s,o+t dir
	其中 SUID 為 u+s ，而 SGID 為 g+s ，SBIT 則是 o+t 囉！

