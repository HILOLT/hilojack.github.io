---
layout: page
title:	
category: blog
description: 
---
# 
find -maxdepth 1 -name '*' -inum 1324 -exec rm {} \;
//du -d 1

# -perm
	754(rwxr-xr--) a.txt
	find . -perm 755 # 755 == 754 false
	find . -perm +4000 # 4000 & 0754 true
	find . -perm -4000 # (4000 & 0754) == 4000 false
	find . \(! -perm -0754 -o -perm 766 \)
