---
layout: page
title: 关于php的调试方法
category: blog
description: 
---

# 序
本篇是我的调试经验整理, 欢迎补充~

# 调试方法
## 反射(Reflection)
反射（reflection）是php5 新加的特性，借助它可以很方便的进行元编程。
不过在团队项目中，我们可以用来追踪类/方法

	class test{};
	ReflectionClass::export('test');

输出：

	Class [ <user> class test ] {
	  @@ /home/hilo/a.php 2-2

	  - Constants [0] {
	  }

	  - Static properties [0] {
	  }

	  - Static methods [0] {
	  }

	  - Properties [0] {
	  }

	  - Methods [0] {
	  }
	}



## 二分调试
如何确定一个数据被莫名奇妙的篡改？二分查找
配合这几个常量：__LINE__/__FILE__/__CLASS__

	<?php
	/**
	 * debuging($var);			//打印$var
	 * debuging($var, 'php');	//打印出$var(var_export)
	 * debuging($var, '任意', 2); //以json格式输出$var
	 * debuging(__LINE__.__CLASS);//常用于大量if语句体定位, 或者寻找函数结束点
	 * debuging('dtrace');//查看调用链
	 */
	function debuging($var = '', $echo = '', $die = false, $force = false){
		static $clear;
		if(0 && $clear === null){
			ob_end_flush();
			$clear = true;
		}
		static $d;
		if(1 && empty($d)){
			$d = 1;
			debuging('dtrace');
		}
		
		$force && $_GET['debug']=1;
		if(isset($_GET['debug'])){
			if( 'dtrace' === $var ){
				dTrace($die);
			}elseif($die === 2){
				header('Content-type: application/json');
				echo json_encode($var);
			}else{
				echo '<pre>'."\n";
					if($echo){
						echo "$echo:";
					}
					if($echo === 'php') 
						var_export($var);
					else 
						var_dump($var);
				echo '</pre>'."\n";
			}
			$die && die;
		}
	}
	function dTrace($die = false){
		if(isset($_GET['debug'])){
			try{
				global $lastTime;
				$lastTime or $lastTime = $_SERVER['REQUEST_TIME'];
				throw new Exception();
			}catch(Exception $e){
				$currTime = microtime(true);
				$totalTime = $currTime-$_SERVER['REQUEST_TIME'];
				$execTime = $currTime-$lastTime;$lastTime = $currTime;
				echo "execTime: $execTime s.<br/>\n";
				echo "totalTime: $totalTime s.<br/>\n";
				debuging($e->getTraceAsString(),'',$die);
			}
		}
	}

## 调用栈
php本身就提供了许多查看调用栈的方法，非常方便
### 用异常查看

	a();
	function a(){
		print_r((new Exception)->getTraceAsString());
	}
### 断点
如果我们想确定某一个函数在哪里被调用，如果它被大量调用，二分查找并非是一个好主意。如果可能的话，我会在函数体中插入追踪函数（debuging，或者其他).只需要一次就可以确定问题。

但是如果我们没有权限改变那个函数呢？或者他就是系统自己函数呢(比如header)？一个办法是，用我们自己的函数去封装他们, 用封装的这一层去高度.

但是，对于一个大型在线项目来说，你可能没有时间，或者没有权限去改写那些不太合理的函数。好吧，既然不能改写那些代码，那就用Php扩展去中断他们吧。。

### 用debug_backtrace
包含debug_backtrace() 与 debug_print_backtrace();

	b();
	function b(){
		a();
	}
	function a(){
		//直接输出
		debug_print_backtrace();
		//返回栈信息
		var_dump(debug_backtrace()); 
	}

## 注意ob_start与各种缓存
ob_start('handler') 以及其它各种缓存
经常会干扰我们的结果，debug时最好用ob_end_flush关闭之．对于缓存可以设置一个标识，有标识就不访问缓存。

# 调试工具
## curl
常用的做法是:

1. 在chrome dev tool 获取到请求的curl
2. 执行curl. 注意curl -I ,-d 两个参数是冲突, curl不能两种不同类型的请求(有点汗是不是). 建议使用参数-D- 

## 代理＆抓包
### fiddler
fiddler应该说是windows下最好的代理工具了
使用时注意：

1. 去掉防火墙限制
2. 外部代理时，应开启options->remote proxy
3. 设置结束，必须重启fiddler才生效

<a href="http://hilojack-wordpress.stor.sinaapp.com/uploads/2013/08/Screenshot-from-2013-08-02-022804.png"><img title="Screenshot-from-2013-08-02-022804.png" alt="Screenshot-from-2013-08-02-022804.png" src="http://hilojack-wordpress.stor.sinaapp.com/uploads/2013/08/Screenshot-from-2013-08-02-022804.png" class="aligncenter" /></a>


### charles
charles可作为linux/mac下的fiddler替代（目前功能没有fiddler那么丰富）
<a href="http://hilojack-wordpress.stor.sinaapp.com/uploads/2013/08/Screenshot-from-2013-08-02-021903.png"><img title="Screenshot-from-2013-08-02-021903.png" alt="Screenshot-from-2013-08-02-021903.png" src="http://hilojack-wordpress.stor.sinaapp.com/uploads/2013/08/Screenshot-from-2013-08-02-021903.png" class="aligncenter" /></a>

### firebug(firefox)/dev tool(chrome)
现在看起来dev tool比firebug要强大一些,它支持更多的功能

1. code tidy
1. profiles & audits(性能优化)
1. copy as curl
2. resource
2. .....


# 剖析PHP代码
## APD (效率分析)  
### Install
	wget http://hilo.sinaapp.com/apd-1.0.1.tgz
	ls
	tar xzvf apd-1.0.1.tgz 
	cd apd-1.0.1
	phpize 
	./configure 
	make
	make test
	sudo make install
### Config
	sudo vim /usr/local/wap/php/lib/php.ini
	[apd]
	zend_extension=/usr/local/wap/php/lib/php/extensions/apd.so
	apd.dumpdir = "/tmp/apd"
	apd.statement_tracing = 0

### 分析
如果需要效率分析，只需要开启apd_set_pprof_trace();

	apd_set_pprof_trace();
	a();
	b();
	c();
	function a(){
		sleep(3);
	}
	function b(){
		sleep(1);
	}
	function c(){
		sleep(5);
	}

执行完脚本后通过pprof查看(按耗用时间排序)：

	$ pprofp -R /home/hilo/.apd/pprof.01390.0 
	Trace for /home/hilo/a.php
	Total Elapsed Time = 9.00
	Total System Time  = 0.00
	Total User Time    = 0.00
			 Real         User        System             secs/    cumm
	%Time (excl/cumm)  (excl/cumm)  (excl/cumm) Calls    call    s/call  Memory Usage Name
	--------------------------------------------------------------------------------------
	100.0 0.00 9.00  0.00 0.00  0.00 0.00     1  0.0000   9.0012            0 main
	100.0 9.00 9.00  0.00 0.00  0.00 0.00     3  3.0002   3.0002            0 sleep
	55.6 0.00 5.00  0.00 0.00  0.00 0.00     1  0.0000   5.0002            0 c
	33.3 0.00 3.00  0.00 0.00  0.00 0.00     1  0.0000   3.0002            0 a
	11.1 0.00 1.00  0.00 0.00  0.00 0.00     1  0.0000   1.0002            0 b
	0.0 0.00 0.00  0.00 0.00  0.00 0.00     1  0.0006   0.0006            0 apd_set_pprof_trace
	

测试机apd


	$ ./apd-1.0.1/pprofp -R /tmp/apd/pprof.18083.0

	Trace for /data1/wap/code/weibov4_wap/index.php
			 Real         User        System             secs/    cumm
	%Time (excl/cumm)  (excl/cumm)  (excl/cumm) Calls    call    s/call  Memory Usage Name
	--------------------------------------------------------------------------------------
	100.0 0.00 5.26  0.00 0.06  0.00 0.02     1  0.0000   5.2613            0 main
	97.5 0.00 5.13  0.00 0.01  0.00 0.01     1  0.0000   5.1305            0 Router->dispatch
	96.4 0.00 5.07  0.00 0.00  0.00 0.00     1  0.0000   5.0736            0 unread->_action
	96.4 0.00 5.07  0.00 0.00  0.00 0.00     1  0.0000   5.0728            0 unread->getUserSkin
	96.4 0.00 5.07  0.00 0.00  0.00 0.00     1  0.0000   5.0724            0 unread->getAppSetting
	96.4 0.00 5.07  0.00 0.00  0.00 0.00     1  0.0000   5.0714            0 WapRedis->hget
	96.4 0.00 5.07  0.00 0.00  0.00 0.00     1  0.0001   5.0714            0 WapRedis->__call
	96.4 0.00 5.07  0.00 0.00  0.00 0.00     1  0.0000   5.0704            0 WapRedis->getLink
	96.4 0.00 5.07  0.00 0.00  0.00 0.00     1  0.0001   5.0703            0 WapRedis->connect
	96.3 5.07 5.07  0.00 0.00  0.00 0.00     1  5.0690   5.0690            0 Redis->connect
	2.9 0.00 0.15  0.00 0.05  0.00 0.04    19  0.0000   0.0081            0 loadClass
	2.9 0.00 0.15  0.00 0.05  0.00 0.04    20  0.0000   0.0077            0 Loader::loadClass
	2.1 0.05 0.11  0.02 0.07  0.01 0.01    74  0.0006   0.0015            0 require_once
	1.4 0.00 0.07  0.00 0.02  0.00 0.01     1  0.0000   0.0737            0 Router->__construct
	1.2 0.00 0.06  0.00 0.01  0.00 0.01     3  0.0001   0.0209            0 unread->__construct
	1.2 0.00 0.06  0.00 0.01  0.00 0.00     1  0.0001   0.0624            0 Router::initGlobal
	1.1 0.00 0.06  0.00 0.03  0.00 0.00    39  0.0000   0.0014            0 Loader::loadFile
	0.8 0.00 0.04  0.00 0.01  0.00 0.00     4  0.0000   0.0100            0 CNF::includeFile
	0.7 0.00 0.03  0.00 0.00  0.00 0.00     2  0.0001   0.0174            0 WapMemcache->get
	0.6 0.00 0.03  0.00 0.01  0.00 0.00     4  0.0000   0.0085            0 WapMysql->__construct

## Xhprof
### Install
	wget http://pecl.php.net/get/xhprof-0.9.4.tgz
	tar  xzvf xhprof-0.9.4.tgz 
	cd xhprof-0.9.4/extension/
	phpize 
	./configure 
	make && sudo make install
	make test
	sudo apachectl restart
	sudo -u www mkdir /tmp/xhprof
	chmod 777 /tmp/xhprof/

### Config
	sudo vim /usr/local/wap/php/lib/php.ini
	[xhprof]
	extension = xhprof.so
	xhprof.output_dir = "/tmp/xhprof"


### 分析
	xhprof_enable(XHPROF_FLAGS_CPU + XHPROF_FLAGS_MEMORY);

	//code

	$xhprof_data = xhprof_disable();

	$XHPROF_ROOT = ".";
	include_once $XHPROF_ROOT . "/xhprof_lib/utils/xhprof_lib.php";
	include_once $XHPROF_ROOT . "/xhprof_lib/utils/xhprof_runs.php";

	$xhprof_runs = new XHProfRuns_Default();
	$run_id = $xhprof_runs->save_run($xhprof_data, "xhprof_testing");

	echo "http://hilo.com/xhprof/xhprof_html/index.php?run={$run_id}&source=xhprof_testing\n";

http://hilo.com/xhprof/xhprof_html/index.php?run=527bb2545175e&source=xhprof_testing

	main()	1	0.1%	64,745	100.0%	731	1.1%	56,003	100.0%	0	0.0%	1,586,288	100.0%	4,784	0.3%	1,584,288	100.0%	4,376	0.3%
	loadClass	1	0.1%	31,588	48.8%	45	0.1%	28,002	50.0%	0	0.0%	729,272	46.0%	1,336	0.1%	730,768	46.1%	880	0.1%
	Loader::loadClass	1	0.1%	31,521	48.7%	162	0.3%	28,002	50.0%	0	0.0%	727,176	45.8%	2,904

## xdebug
	wget http://pecl.php.net/get/xdebug-2.2.3.tgz
	tar xvf /xdebug-2.2.3.tgz; cd xdebug-2.2.3;
	phpize
	./configure --enable-xdebug --with-php-config=/usr/local/wap/php/bin/php-config
	sudo make && sudo make install;
	Installing shared extensions:     /usr/local/wap/php/lib/php/extensions/xdebug.so

### config
	sudo -u www mkdir /tmp/xdebug
	sudo apachectl restart
	sudo vim php.ini
	[xdebug]
	extension=xdebug.so
	xdebug.profiler_enable=on
	xdebug.trace_output_dir="/tmp/xdebug"
	xdebug.profiler_output_dir="/tmp/xdebug"

### analyse
xdebug的trace数据放在/tmp/xdebug/cachegrind.out.*
这个文件难是阅读，幸运的时，已经有人开发了许多功能强大的program实现对cacheGrind的可视化分析。最具代表性就是KCacheGrind.
#### winCacheGrind(for windows)

<a href="http://hilojack-wordpress.stor.sinaapp.com/uploads/2013/11/Screenshot-from-2013-11-08-144724.png"><img title="Screenshot-from-2013-11-08-144724.png" alt="Screenshot-from-2013-11-08-144724.png" src="http://hilojack-wordpress.stor.sinaapp.com/uploads/2013/11/Screenshot-from-2013-11-08-144724.png" class="aligncenter" /></a>
#### KCacheGrind
KCacheGrind(for Linux),QCacheGrind(for windows/Mac)

<a href="http://hilojack-wordpress.stor.sinaapp.com/uploads/2013/11/Screenshot-from-2013-11-08-144345.png"><img title="Screenshot-from-2013-11-08-144345.png" alt="Screenshot-from-2013-11-08-144345.png" src="http://hilojack-wordpress.stor.sinaapp.com/uploads/2013/11/Screenshot-from-2013-11-08-144345.png" class="aligncenter" /></a>

http:
<a href="http://hilojack-wordpress.stor.sinaapp.com/uploads/2013/11/Screenshot-from-2013-11-08-144059.png"><img title="Screenshot-from-2013-11-08-144059.png" alt="Screenshot-from-2013-11-08-144059.png" src="http://hilojack-wordpress.stor.sinaapp.com/uploads/2013/11/Screenshot-from-2013-11-08-144059.png" class="aligncenter" /></a>


## vld(opcode查看器)
	
	$ php -dvld.active=1 -r 'echo $a="a"."b";'
	Finding entry points
	Branch analysis from position: 0
	Return found
	filename:       Command line code
	function name:  (null)
	number of ops:  4
	compiled vars:  !0 = $a
	line     # *  op                           fetch          ext  return  operands
	---------------------------------------------------------------------------------
	   1     0  >   CONCAT                                           ~0      'a', 'b'
			 1      ASSIGN                                           $1      !0, ~0
			 2      ECHO                                                     $1
			 3    > RETURN                                                   null

# stackOverflow
如果问题无法解决怎么办？ 如果手册／google/wiki/readme都没有答案呢？那么推荐stackOverflow(没有更顶级的it问答社区了)

# mobile debug
	[weinre](http://segmentfault.com/a/1190000000459296)

# 开发效率
## 善用IDE
ide的coder开发效率中占有非常重要的地位.以前我总以为vim是万能的，后来发现vim不是这样(写小脚本还行，写项目就不适合了)：

1. 几乎所有的vim插件都需要巨大的学习成本	
1. 很多插件功能整合得不好，甚至不稳定
1. 不能像IDE那样对程序文本进行真正的 parse，之后才开始分析里面的结构。它们的“跳转到定义”一般都是很精确的跳转，而不是像文本编辑器那样瞎猜。
1. 打造一个属于自己的vim for php只能自己写（修改）插件
1. 自己写插件会浪费大量的时间，光一个智能补全就足够折腾人的

做项目还是得用现代的IDE，比如eclipse/netbeans/...，但需要熟悉一些技巧：
比如netbeans：

1.	要熟悉常用快捷键(help->shortcut)，比如格式刷C-S-v,文件名查找C－S-o
2. 还比如vdoc创建类引用声明

## 效率插件
vimor/json/php man/speed tracer/cookie/ua/hosts/
## 编写工具／脚本
现有的工具并不总是满足的我们的要求，作为coder，我们应该考虑简化我们的开发流程．（不要做什么代码民工，要做一个有主见的coder!）
比如:

1. wml转换器
2. json
3. webShell

## todo与协同
一心二用是最没有效率，但是没办法，很多时候我们都会被一些事儿所打扰。回头又经常忘记要做啥了。所以，我们最好建立一个todo事项。
网上有许多简单方便的todo工具，我觉得最方便省事的就是google docs了，其交互性也非常的棒，比如支持图片粘贴板。

1. google excel.
2. google draw(简单的作图工具)
2. lucidchart(基于google drive 强大的流程图)

[IDE]: http://www.yinwang.org/blog-cn/2013/04/20/editor-ide/

