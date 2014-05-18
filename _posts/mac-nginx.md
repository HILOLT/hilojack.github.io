---
layout: page
title:	
category: blog
description: 
---
# Preface
nginx是比apache 更先进的web server. 以BSD许可证发布. 内核简洁, 模块强大(与apache不同, 其所有的模块都是静态编译的, 更快). 简单的是nginx接收到http请求后. 当分析到请求是js/css/img等静态资源, 就交给静态资源模块去处理. 如果是php/python等动态资源, 就交给FastCGI去处理.

> FastCGI = web server 和 动态脚本语言的接口

## I/O消息通知机制
Nginx支持epoll(linux系) 和 qkqueue(bsd) 系两种事件通知机制. epoll是linux2.6引入的提高I/O的处理方法, 优点: 单一进程打开的文件描述符(fd)仅受操作系统限制; 采用内存共享以避免内存copy; fd打开的数量的增加, 不会使I/O性能线性下降. 

	
## 多进程
niginx启动后会有一个master进程(负责接收外界信号并向worker发送信号, 监控worker) 和多个worker进程(对应cup数量)
如果master发现, worker死掉了, 它会再开一个worker. worker会用到epoll通知机制.

	worker_rlimit_nofile 51200; #文件描述符数量限制
	worker_processes 4 #如果有4个cpu
	events
	{
		# use [ kqueue | rtsig | epoll | /dev/poll | select | poll ];
		use epoll;  #epoll（>linux2.6） kqueue(bsd)
		worker_connections 51200; #每个进程最大连接数
	}
	# user & group
	user  www www;

	root /User/hilojack/www/

## log
	log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
										'$status $body_bytes_sent "$http_referer" '
										'"$http_user_agent" "$http_x_forwarded_for"';
	access_log  logs/access.log  main;




# Install nginx
如果你想手动安装:[compile options](http://wiki.nginx.org/InstallOptions)

否则, 用brew 自动安装吧, 如果需要[extra module](https://github.com/Homebrew/homebrew-nginx/issues/49):
	
	brew tap homebrew/nginx # This tap is designed specifically for a custom build of Nginx with more module options.
	brew install nginx-full --with-echo-module

	### myself
	rm -r /usr/local/var/www
	ln -s /Users/hilojack/www /usr/local/var/www
	sudo ln -s /usr/local/etc/nginx /etc/nginx

## nginx Conf
	# docroot is: /usr/local/var/www
	# The default port has been set in /usr/local/etc/nginx/nginx.conf to 8080 so that nginx can run without sudo.
	#To have launchd start nginx at login:
			ln -sfv /usr/local/opt/nginx/*.plist ~/Library/LaunchAgents
	# Then to load nginx now:
			launchctl load ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist
	# Or, if you don't want/need launchctl, you can just run:
			nginx
			nginx -V

### nginx.conf
	#user  nobody;
	worker_processes  1;
	#error_log  logs/error.log  info;
	#pid        logs/nginx.pid;

	events {
			worker_connections  1024;
	}


	http {
			include       mime.types;
			default_type  application/octet-stream;
			sendfile        on;
			keepalive_timeout  65;
			#tcp_nopush     on;
			#gzip  on;

			server {
					listen       80;
					server_name  gitWiki.com;
					root   /Users/hilojack/www/gitWiki;
					location  ~ "^/(js|img|css|htm)/" {
						#rewrite "^/(.*)" /yar.php/$1 last;
					}

					rewrite "^/(js|img|css|htm)/(.*)" /$1/$2 last; #好像即使rewrite在location后面, 也会在location执行前执行
					if ( $http_host ~ "^rpc.cn" ){
						rewrite "^/2/(.*)" /yaf.php/$1 last;
					}
					rewrite "^/(?:2)/(.*)" /yaf.php/$1 last;
					rewrite "^/(.*)" /index.php/$1 last;

					# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
					#location ~ \.php$ {
					#
					location /{
							redirect ^ http://www.google.com/?q=$fastcgi_script_name last; break; # test nginx variable
							fastcgi_pass   127.0.0.1:9000;
							#fastcgi_index  index.php;
							fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
							include        fastcgi_params;
					}
			}
		}

# php5 & php5-fpm conf
	一般在:
		/etc/php.ini (php --ini)
		/etc/php-fpm.conf

## php.ini confi
	cgi.fix_pathinfo=0 #如果是1, php会尽可能的解析各种文件类型, 这会有安全风险

## fpm Conf
	listen = 127.0.0.1:9000 这个 走的是TCP socket改成
	listen = /var/run/php5-fpm.sock 走Unix domain socket

# condition expression
## if
	if ( $http_host ~ "^hilojack.com" ){
             rewrite "^(.*)" /index.php/$1 last;
	 }


# rewrite
所有的rewrite都在location之前处理(即使rewrite 在location 后面, 并且 如果rewrite在location里面, rewrite会失效)

	rewrite "^/([0-9]{5}).html$" /viewthread.php?tid=$1 last;

	last - 基本上都用这个Flag。last 相当于Apache里的[L]标记，表示完成rewrite
	break - 中止Rewirte，不在继续匹配
	redirect - 返回临时重定向的HTTP状态302
	permanent - 返回永久重定向的HTTP状态301

# debug 
nginx不会打印出变量. 有一个办法可以[探测变量](http://www.justincarmony.com/blog/2012/01/13/debugging-nginx-configuration-trick/).

	location /{
		redirect ^ http://www.google.com/?q=$fastcgi_script_name last; break; # test nginx variable
		fastcgi_pass   127.0.0.1:9000;
		fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
	}

Update: 其实nginx 有一个echo moudle
	
	location /{
	 echo The current request uri is $request_uri;
	 }

# regexp
正则表达式匹配，其中：
	* ~ 为区分大小写匹配
	* ~* 为不区分大小写匹配
	* !~和!~*分别为区分大小写不匹配及不区分大小写不匹配
	* = 不用正则, 可以省略的 直接loaction /{}

文件及目录匹配，其中：
	* -f和!-f用来判断是否存在文件
	* -d和!-d用来判断是否存在目录
	* -e和!-e用来判断是否存在文件或目录
	* -x和!-x用来判断文件是否可执行

# $_SERVER
	hilo.com/a/b?c=1
  'PATH_INFO' => '/a/b',
  'QUERY_STRING' => 'c=2',
  'REQUEST_URI' => '/a/b?c=2',

	//rewrite path_info
  'PHP_SELF' => '/yar.php//a/b',
  'DOCUMENT_URI' => '/yar.php//a/b',


  'SCRIPT_NAME' => '/yar.php',
  'SCRIPT_FILENAME' => '/data1/www/htdocs/xh.v5.weibo.cn/public/yar.php',


# start nginx
	sudo ln -s /usr/local/sbin/nginx /usr/sbin
	sudo nginx -s Signal
		-s Signal:
			stop — fast shutdown
			quit — graceful shutdown
			reload — reloading the configuration file
			reopen — reopening the log files
		-V compiler args

	sudo php-fpm
	sudo kill `/usr/var/run/php-fpm.pid`

https://gist.github.com/uradvd85/5552906

# 基本配置与参数说明
	#运行用户
	user nobody;
	#启动进程,通常设置成和cpu的数量相等
	worker_processes  1;

	#pid        logs/nginx.pid;

	#工作模式及连接数上限
	events {
		#epoll是多路复用IO(I/O Multiplexing)中的一种方式,
		#仅用于linux2.6以上内核,可以大大提高nginx的性能
		use   epoll; 

		#单个后台worker process进程的最大并发链接数    
		worker_connections  1024;

		# 并发总数 即 max_clients = worker_processes * worker_connections
		# 在设置了反向代理的情况下，max_clients = worker_processes * worker_connections / 4  为什么
		# 为什么上面反向代理要除以4，应该说是一个经验值
		# 根据以上条件，正常情况下的Nginx Server可以应付的最大连接数为：4 * 8000 = 32000
		# worker_connections 值的设置跟物理内存大小有关
		# 因为并发受IO约束，max_clients的值须小于系统可以打开的最大文件数
		# 而系统可以打开的最大文件数和内存大小成正比，一般1GB内存的机器上可以打开的文件数大约是10万左右
		# 我们来看看360M内存的VPS可以打开的文件句柄数是多少：
		# $ cat /proc/sys/fs/file-max
		# 输出 34336
		# 32000 < 34336，即并发连接总数小于系统可以打开的文件句柄总数，这样就在操作系统可以承受的范围之内
		# 所以，worker_connections 的值需根据 worker_processes 进程数目和系统可以打开的最大文件总数进行适当地进行设置
		# 使得并发总数小于操作系统可以打开的最大文件数目
		# 其实质也就是根据主机的物理CPU和内存进行配置
		# 当然，理论上的并发总数可能会和实际有所偏差，因为主机还有其他的工作进程需要消耗系统资源。
		# ulimit -SHn 65535

	}

	http {
		#设定mime类型,类型由mime.type文件定义
		include    mime.types; #etc/nginx/mime-types
		default_type  application/octet-stream;

		#设定日志格式
		log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
						  '$status $body_bytes_sent "$http_referer" '
						  '"$http_user_agent" "$http_x_forwarded_for"';
		access_log  logs/access.log  main;

		#sendfile 指令指定 nginx 是否调用 sendfile 函数（zero copy 方式）来输出文件，
		#对于普通应用，必须设为 on,
		#如果用来进行下载等应用磁盘IO重负载应用，可设置为 off，
		#以平衡磁盘与网络I/O处理速度，降低系统的uptime.
		sendfile     on;
		#tcp_nopush     on;

		#连接超时时间
		#keepalive_timeout  0;
		keepalive_timeout  65;
		tcp_nodelay     on;

		#开启gzip压缩
		gzip  on;
		gzip_disable "MSIE [1-6].";

		#设定请求缓冲
		client_header_buffer_size    128k;
		large_client_header_buffers  4 128k;


		#设定虚拟主机配置
		server {
			#侦听80端口
			listen    80;
			#定义使用 www.nginx.cn hilojack.com访问
			server_name  hilojack.com www.nginx.cn;

			#定义服务器的默认网站根目录位置
			root html;

			#设定本虚拟主机的访问日志
			access_log  logs/nginx.access.log  main;

			#默认请求
			location / {
				
				#定义首页索引文件的名称
				index index.php index.html index.htm;   

			}

			# 定义错误提示页面
			error_page   500 502 503 504 /50x.html;
			location = /50x.html {
			}

			#静态文件，nginx自己处理
			location ~ ^/(images|javascript|js|css|flash|media|static)/ {
				
				#过期30天，静态文件不怎么更新，过期可以设大一点，
				#如果频繁更新，则可以设置得小一点。
				expires 30d;
			}

			#PHP 脚本请求全部转发到 FastCGI处理. 使用FastCGI默认配置.
			location ~ .php$ {
				fastcgi_pass 127.0.0.1:9000;
				fastcgi_index index.php;
				fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
				include fastcgi_params;
			}

			#禁止访问 .htxxx 文件
				location ~ /.ht {
				deny all;
			}

		}
	}


