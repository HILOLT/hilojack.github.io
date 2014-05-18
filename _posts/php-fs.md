---
layout: page
title:	php filesystem
category: blog
description: 
---

# 一、文件属性（file attribute）

	filetype($path)	block(块设备:分区，软驱，光驱) char(字符设备键盘打打印机) dir file fifo （命名管道，用于进程之间传递信息） link unknown
	file_exits() 文件存在性
	filesize() 返回文件大小（字节数,用pow()去转化 为MB吧）
	is_readable()检查是否可读
	is_writeable()检查是否可写
	is_excuteable()检查是否可执行
	filectime()检查文件创建的时间
	filemtime()检查文件的修改时间
	fileatime()检查文件访问时间
	stat()获取文件的属性值
	0 dev device number - 设备名
	1 ino inode number - inode 号码
	2 mode inode protection mode - inode 保护模式
	3 nlink number of links - 被连接数目
	4 uid userid of owner - 所有者的用户 id
	5 gid groupid of owner- 所有者的组 id
	6 rdev device type, if inode device * - 设备类型，如果是 inode 设备的话
	7 size size in bytes - 文件大小的字节数
	8 atime time of last access (unix timestamp) - 上次访问时间（Unix 时间戳）
	9 mtime time of last modification (unix timestamp) - 上次修改时间（Unix 时间戳）
	10 ctime time of last change (unix timestamp) - 上次改变时间（Unix 时间戳）
	11 blksize blocksize of filesystem IO * - 文件系统 IO 的块大小
	12 blocks number of blocks allocated - 所占据块的数目
# 二、文件目录

## 名字
	dirname() basename() pathinfo()返回一个数组‘dirname’,'basename’,'extension’
	__DIR__,__FILE__
	parse_str($_SERVER['QUERY_STRING']);返回查询字串的中的键值 对。
	parse_url($url);返回Array ( [scheme] => http [host] => hostname [user] => username [pass] => password [path] => /path [query] => arg=value [fragment] => anchor) 

对_SERVER中的path:

	#按脚本
	SCRIPT_FILENAME=DOCUMENT_ROOT + truePath
		/data1/www/htdocs/912/hilo/1/phpinfo.php #_SERVER["SCRIPT_FILENAME"](脚本文件名-脚本在服务器中的path)
	DOCUMENT_ROOT
		/data1/www/htdocs/912/hilo/1

	#按url
	path:SCRIPT_NAME/SCRIPT_URL/PHP_SELF 
		/interestnew/music
	SCRIPT_URI = HTTP_HOST+path
		http://m.weibo.cn/interestnew/music
	REQUEST_URI = path + QUERY_STRING
		/interestnew/music?test=1
							

## 目录访问

	$dirp=opendir()
	readdir($dirp);结尾时返回false
	rewinddir($dirp);返回目录开头
	closedir($dirp);

## 目录操作

	mkdir ( string $pathname [, int $mode [, bool $recursive [, resource $context ]]] )
	rmdir($pathname);必须为空
 
# 三、文件操作
## 打开：
	fopen ( string $filename , string $mode [, bool $use_include_path [, resource $zcontext ]] )
	‘r’ 只读方式打开，将文件指针指向文件头。
	‘r+’ 读写方式打开，将文件指针指向文件头。
	‘w’ 写入方式打开，将文件指针指向文件头并将文件大小截为零。如果文件不存在则尝试创建之。
	‘w+’ 读写方式打开，将文件指针指向文件头并将文件大小截为零。如果文件不存在则尝试创建之。
	‘a’ 写入方式打开，将文件指针指向文件末尾。如果文件不存在则尝试创建之。
	‘a+’ 读写方式打开，将文件指针指向文件末尾。如果文件不存在则尝试创建之。
	‘x’ 创建并以写入方式打开，将文件指针指向文件头。如果文件已存在，则 fopen() 调用失败并返回 FALSE，并生成一条 E_WARNING 级别的错误信息。如果文件不存在则尝试创建之。这和给 底层的 open(2) 系统调用指定 O_EXCL|O_CREAT 标记是等价的。此选项被 PHP 4.3.2 以及以后的版本所支持，仅能用于本地文件。
	‘x+’ 创建并以读写方式打开，将文件指针指向文件头。如果文件已存在，则 fopen() 调用失败并返回 FALSE，并生成一条 E_WARNING 级别的错误信息。如果文件不存在则尝试创建之。这和给 底层的 open(2) 系统调用指定 O_EXCL|O_CREAT 标记是等价的。此选项被 PHP 4.3.2 以及以后的版本所支持，仅能用于本地文件。

 Windows 下提供了一个文本转换标记（’t'）可以透明地将 \n 转换为 \r\n。与此对应还可以使用 ‘b’ 来强制使用二进制模式，这样就不会转换数据。要使用这些标记，要么用 ‘b’ 或者用 ‘t’ 作为 mode 参数的最后一个字符。

## 关闭
	 fclose($fp);

## 读取-写入
	 fread ( int $handle , int $length )最长8192 –fwrite ( resource $handle , string $string [, int $length ] )
	 fgets ( int $handle [, int $length=1024 ] ) 读取一行
	 fgetss ( resource $handle [, int $length])读取一行并且去掉html+php标记
	 fgetc();读取一个字符

 其它：

	 file_get_contents() —file_put_contents()
	 返回行数组
	 file ( string $filename [, int $use_include_path [, resource $context ]] )
	 输出一个文件
	 readfile ( string $filename [, bool $use_include_path [, resource $context ]] )
	 文件截取
	 ftruncate ( resource $handle , int $size )，当$size=0,文件就变为空
	 文件删除
	 unlink();
	 文件复制
	 copy($src,$dst);
## 指针移动

	 ftell($fp);
	 fseek($fp,$offset[,SEEK_CUR OR SEEK_END OR SEEK_SET),SEEK_SET是默认值，SEEK_END时offset应该为负值
	 可选。可能的值：
	 SEEK_SET - 设定位置等于 offset 字节。默认。
	 SEEK_CUR - 设定位置为当前位置加上 offset。
	 SEEK_END - 设定位置为文件末尾加上 offset （要移动到文件尾之前的位置，offset 必须是一个负值）。

# 四、并发访问中的文件锁

	 flock ( int $handle , int $operation [, int &$wouldblock ] )
	 LOCK_SH（PHP 4.0.1 以前的版本设置为 1）。
	 operation 设为 LOCK_EX（PHP 4.0.1 以前的版本中设置为 2）。
	 operation 设为 LOCK_UN（PHP 4.0.1 以前的版本中设置为 3）。
	 operation 加上 LOCK_NB（PHP 4.0.1 以前的版本中设置为 4）。 NO_block

# 五、上传下载
## 1.上传
 1.1表单：enctype=”multipart/form-data”

	 array(1) {
	 ["upload"]=>array(5) {
	 ["name"]=>array(3) {
	 [0]=>string(9)”file0.txt”
	 [1]=>string(9)”file1.txt”
	 [2]=>string(9)”file2.txt”
	 }
	 ["type"]=>array(3) {
	 [0]=>string(10)”text/plain”
	 [1]=>string(10)”text/plain”
	 [2]=>string(10)”text/plain”
	 }
	 ["tmp_name"]=>array(3) {
	 [0]=>string(14)”/tmp/blablabla”
	 [1]=>string(14)”/tmp/phpyzZxta”
	 [2]=>string(14)”/tmp/phpn3nopO”
	 }
	 ["error"]=>array(3) {
	 [0]=>int(0)
	 [1]=>int(0)
	 [2]=>int(0)
	 }
	 ["size"]=>array(3) {
	 [0]=>int(0)
	 [1]=>int(0)
	 [2]=>int(0)
	 }
	 }
	 }

 1.2处理上传

	 move_uploaded_file();必须要在http.conf中设置documentRoot文件

## 下载（改HEADER）

	 header(“Content-Type:application/octet-stream”); //打开始终下载的mimetype
	 header(“Content-Disposition: attachment; filename=文件名.后缀名”);
	 // 文件名.后缀名 换成你的文件名这里的文件名是下载后的文件名，和你的源文件名没有关系。
	 header(“Pragma: no-cache”); // 缓存
	 header(“Expires: 0″);
	 header(“Content-Length:3390″);
	 记得加enctype=”multipart/form-data”

