---
layout: page
title:	
category: blog
description: 
---
CREATE TABLE `TTT_DATAALLOWANCE` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` char(15) NOT NULL,
  `status` tinyint(2) DEFAULT NULL,
  `number` char(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `number` (`number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 


# Alter
alter table tabelname ...
 ALTER TABLE table_name DROP PRIMARY KEY
 ALTER TABLE table_name DROP Column
 ALTER TABLE table_name ADD KEY `provice` (`province`)

## change
alter table t1 change a b tinyint(1) not null;


# export & import
mysqldump -uuser -ppasswd -h12.1.1.1 database table > backup.sql
mysqldump -h localhost -u root -p --no-data --compact  some_db

	-d, --no-data
	--compact
		Produce less verbose output. This option enables the --skip-add-drop-table, --skip-add-locks,
	    --skip-comments, --skip-disable-keys, and --skip-set-charset options.



mysql -uuser -ppasswd -h12.1.1.1 database < backup.sql

# drop
 DROP DATABASE database_name;
 DROP TABLE table;

# LOCK
LOCK TABLES `TTT_DATAALLOWANCE` WRITE;
INSERT INTO `TTT_DATAALLOWANCE` VALUES (7,'2274153945',1,'13522565869');
UNLOCK TABLES;


# 数据类型
## time
 TIMESTAMP DEFAULT CURRENT_TIMESTAMP

# How to install MySQL
	yum install mysql-server mysql php-mysql
	#Set the MySQL service to start on boot
	chkconfig --levels 235 mysqld on
	#start
	service mysqld start
	#Log into MySQL
	mysql -u root
	#Set the root user password for all local domains
	SET PASSWORD FOR 'root'@'localhost' = PASSWORD('new-password');
	SET PASSWORD FOR 'root'@'localhost.localdomain' = PASSWORD('new-password');
	SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD('new-password');
	#Drop the Any user
	DROP USER ''@'localhost';
	DROP USER ''@'localhost.localdomain';

# 乱码
## collation
[用于指定数据集如何排序，以及字符串的比对规则](http://zhongwei-leg.iteye.com/blog/899227)
	show collation;

collation 名字的规则可以归纳为这两类：
1. <character set>_<language/other>_<ci/cs>
2. <character set>_bin

ci 是 case insensitive 的缩写， cs 是 case sensitive 的缩写。即，指定大小写是否敏感。
那么 utf8_general_ci, utf8_unicode_ci, utf8_danish_ci 有什么区别? 他们各自存在的意义又是什么？
同一个 character set 的不同 collation 的区别在于排序、字符对比的准确度（相同两个字符在不同国家的语言中的排序规则可能是不同的）以及性能。
  
例如：
  utf8_general_ci 在排序的准确度上要逊于 utf8_unicode_ci， 当然，对于英语用户应该没有什么区别。但性能上（排序以及比对速度）要略优于 utf8_unicode_ci. 例如前者没有对德语中 `ß = ss` (在德语中他们意义是等价的)的支持。
    
而 utf8_danish_ci 相比 utf8_unicode_ci 增加了对丹麦语的特殊排序支持。

1. 当表的 character set 是 latin1 时，若字段类型为 nvarchar, 则字段的字符集自动变为 utf8.
可见 database character set, table character set, field character set 可逐级覆盖。
 
 2. 在 ci 的 collation 下，如何在比对时区分大小写：
推荐使用

	mysql> select * from pet where name = binary 'whistler'; //这样可以保证当前字段的索引依然有效 
	mysql> select * from pet where binary name = 'whistler'; //会使索引失效。

## 其它
	 
	//查看mysql 支持的字符集
	show character set;
	show collation;//影响字符排序\对比的性能与准确度


	//check
	show variables like "%char%";
	show create table db.table;
	show create database db;

	//临时
	mysql_query("SET NAMES 'utf8'");//设定字符集,告诉服务器,我用的是utf-8编码, 我希望你也给我返回utf-8编码的查询结果. 
	mysql_set_charset("utf8");//设定字符集(会影响mysql_real_escape_string())
	mysql_query("SET CHARACTER_SET_CLIENT=utf8"); 
	mysql_query("SET CHARACTER_SET_RESULTS=utf8"); 
	mysql_query("SET CHARACTER_SET_RESULTS=latin1"); //万能码

