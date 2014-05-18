---
layout: page
title:	
category: blog
description: 
---
$TOC$

# 序
本篇是为组内经验分享而写，后面有很大一部分是炒别人的冷饭（算是总结归纳），如有任何问题请指教。

# 按需执行/按需加载
比较耗时的计算应该考虑按需执行/按需要加载

## 按需执行
以正则为例， 与普通字符串函数相比，其效率是非常低的（[php正则性能]).很多情况下都可以避免的。
看看sinaurl中的这个例子：
	
	if(preg_match('tv\.weibo\.com/n/\d+',$webUrl)){
		...	
	}elseif(preg_match('tv\.weibo\.com/p/\d+',$webUrl)){
		...
	}
	....

很多情况下，正式是不需要执行的(tv.weibo.com出现的概率很小)。如果改成按需执行，效率会高很多：

	if(strpos($webUrl, 'tv.weibo.com')){
		if(preg_match('tv\.weibo\.com/n/\d+',$webUrl)){
			...	
		}elseif(preg_match('tv\.weibo\.com/p/\d+',$webUrl)){
			...
		}
		....
	}
	
## 按需加载
如果tv.weibo.com域下的跳转规则非常的多，那么可以改成按需加载：

	if(strpos($webUrl, 'tv.weibo.com')){
		urlRoute::tv($webUrl);//仅在需要的情况下才加载	
	}

再来个例子：
	//按需加载
	'p' => require(CORE_DIR . '/uri/map/h5/pageUri.php'),

还有很多地方可以改为按需加载：
比如formatMblog位于apiFormat中，因为其它format继承apiFormat，所以不管是否需要，formateMblog都会被加载到php符号表中。
	
# 避免重复计算
## 最经典的循环:

	for($i=0;$i<getTotal();$i++) //getTotal没有必要被重复调用

## 用缓存代替
比如使用redis/mc来减轻数据库压力。
##　使用static
适用场景是：单次http请求时，其计算值需要被多次引用．我们不需要mc/redis,也不需要绞尽脑汁的想如何为缓存key命令.

public static function x_user_agent_info() {
		static $x_user_agent_info = null;//static
		if($x_user_agent_info === null){
			$x_user_agent_info = array(); 
			$x_user_agent = self::x_user_agent();
			if( 4 == substr_count($x_user_agent, '__')){
				$arr = explode('__', $x_user_agent);
				list($x_user_agent_info['deviceName'], 
						$x_user_agent_info['appName'], 
						$x_user_agent_info['appVersion'],
						$x_user_agent_info['osName'],
						$x_user_agent_info['osVersion'],
					) = $arr;
			}
		}
		return $x_user_agent_info;
	}

# 语法tips

## 用list取特定值

	list(,$name) = explode(',',$str);
## 用list交换值

	list($b,$a) = array($a, $b);
## 尽量使用===而非==

	$a === $b;
	4 == $a;//或者常量放在左边

## 注意switch/in_array的松散比较
	
	in_array(0,array('aa','bb','cc'));

## 所有变量应该先定义后使用
这样可以节省执行未定义变量逻辑的时间．

## do while妙用
do while一般是不被重视的，看下这个例子

	$isOk = func1();
	if(!$isOk){
		$isOk = func2();		
		if(!isOk){
			.....	
		}
	}

使用do while重写会健壮很多

	do{
		if(func1()){
			break;
		}
		if(func2()){
			break;
		}
		.....
	}while(0);

## 少用@
不方便调试　&& 低效


## 合理运用字符串比较函数
strncmp / strncasecmp 要比 substr 什么的好很多，

	strcmp


# 避免正则表达式的长回溯

	$reg = "/<script>.*?<\/script>/is";
	$str = "<script>********</script>"; //长度大于100014
	$ret = preg_replace($reg, "", $str); //返回NULL

凑合的解决方式是：
	
	/<script>[^<]*<\/script>/is //但是没有考虑a>b这个情况

好的表达式是利用非回溯子表达式"?>",正如栖草所写的正则[php正则效率:回溯]：

	'%<script>(?>[^<]*)(?>(?!</?script>)<[^<]*)*</script>%';


>>尽量用字符串函数代替正则表达式

下面是炒冷饭([php性能])，加入一点自己的看法

# 关于编译
每个php脚本文件的引入，都会造成zend编译与执行环节。而对线上环境而言，编译时间我们不用计较，原因是：
>php编译为opcode后，每次http请求都直接读取内存中的opcode(不再有再编译的环节)

所以对于发生在编译环节的执行时间，我们可以忽略，这主要包括：

1. 注释
1. 常量(const)、静态方法
1. 字符串之单双引号
1. cls
 
# 不要重复造轮子
php,linux,webserver已经为我为提供了数量巨大的命令集／工具集，使用现成的工具会比我们自己造轮子更高效

##　使用系统调用（低开销） 
## 使用php自带的函数
这使用纯php写出来的方法更快
比如：

	version_compare($appVersion,  "3.1.5")	
## 用字符函数代替正则
## 使用现有的常量
eg:

	php_version() === PHP_VERSION
	php_uname(‘s’) === PHP_OS
	php_sapi_name() === PHP_SAPI
	使用$_SERVER['REQUEST_TIME']代替time()

# 关于http
## keepAlive 
按理说长链接可以让请求变的更快，但如果不合理使用长链接，服务器会崩溃。
Apache的长连接超时尽可能的设置短一些，建议值为10s
 
## 304
对于静态页面或者变化不是特别频繁的页面，可以利用304缓存．

	function setHttpCache($offset = 3){
		$rtime = $_SERVER['REQUEST_TIME'];
		//http 304
		if(isset($_SERVER['HTTP_IF_MODIFIED_SINCE'])){
			$lasttime = $_SERVER['HTTP_IF_MODIFIED_SINCE'];
			$expire = strtotime($lasttime)+$offset;
			if($expire>$rtime){
				header('HTTP/1.1 304 Not Modified');
				die;
			}
		}

		//Modified
		header('Last-Modified: '.date('D, d M Y H:i:s ', $rtime));
	}
	setHttpCache();
	echo 'Date:'.date('r');
 
## 输出控制
效率； 灵活；
请使用ob_start()； 开启 output_buffering；
提高浏览器的渲染速度。
 
 
## 为静态文件选择更好的server
虽然apache是很强大的动态语言服务器，但静态请求可以通过其他一些webserver很好的支持。
比如： lighttpd / Boa / Tux / thttpd
上述webserver在服务于静态内容请求时，响应速度要比apache1或apache2快300~400%倍
 
## 少输出
少输出能加快http响应，特别是我们无线端，理由：
1. 减轻服务器带宽（直接经济利益）
1. 减少服务器资源的使用（CPU/内存/磁盘）
1. 用户能更快的看到信息
1. 减轻那些常常因为网络IO过多而瘫痪的网站的负载

### 压缩
大多数的浏览器均支持内容解压缩 平均能压缩页面的60~80%
Apache1 采用mod_gzip / mod_deflate
Apache2 采用 mod_deflate
PHP 通过设置配置文件中 zlib.output_compression=1  或者在代码中使用  ob_start(“ob_gzhandler”) 压缩内容

	ob_start("ob_gzhandler");
	echo '<pre>';
	echo str_pad('a',1e4,'=');

>>压缩一般要额外消耗3~5%的CPU（是否开启压缩，还需要根据情况而定）
 
# 分析瓶颈
跟踪资源使用
生成调用树
产生进程轨迹数据
 
 服务器测试
Apache Bench ->  ab: 绑定在apache项目代码中
Siege: http://www.joedog.org/JoeDog/Siege
http_load (延迟测试工具)  http://www.acme.com/software/http_load/
 
 
# 剖析PHP代码
APD (完全分析)  http://pecl.php.net/apd
XDebug (探测与分析) http://xdebug.org/
DBG (探测与分析) http://dd.cron.ru/dbg/
 
# Session 存储
PHP默认是把SESSION存储在一个文件中
把存储session分落在一个目录中，减轻单未见的读写频度
- 为每个项目设置他们独立的session存储目录
- 利用php.ini的配置 session.save_path=”N;/path”将session存储在多个目录中
 
Session不采用文件存储
文件存储不是一个优秀的方案
- mm – 固话的共享内存存储
- apc – 用APC存储、获取、删除（见[php apc浅析]）
- memcache – 基于内存的存储服务
 
 
# 减少路由查找 
##　尽量使用绝对路径
尽可能的用绝对路径，相对路径虽然简短但会产生额外的寻径开销。而且使用绝对路径也很保险
## 少用require＿once
减少查找开销
 
## 少用魔法函数
 __get() / __set() ／__autoload()／ __call()

比如,我们的：
	
	$this->apiProxy->page->page_id;//__call增加了符号表查找的时间
 
# 正则优化
1.使用非捕获子表达式
2.使用非回溯子表达式
	
	'#<script>.*</script>#';//可能就会因为回溯给暴栈

3.使用str*函数代替正则
strpbrk(charlist匹配),strncasecmp,strcmp,substr_compare,stripos,str_replace，strtr(charlist替换)....
比如：

	substr_compare($str, 'text', -4);
 
字符集替换strtr()的妙用：

	$rep = array('-'=>'*', '.' => '*');
	$glob = strtr($glob, $rep);

采用这种:
	
	$glob = strtr($glob, '-.','**');

前后两种方式对比，string参数要比array()参数快了10倍！
 
 
# 修复报错
每一个报错，会带来性能影响：
1. 产生一个复杂的错误字符串
2. 产生一个标准输出
3. 可能会产生一个日志文件的写操作或者syslog的写操作
 
# 合理使用引用
更kiss/高效
 
# 参考
[php正则效率:回溯]
[php tips]
[php性能]
[php apc浅析]

[php正则效率:回溯]: http://www.cnxct.com/php%E6%AD%A3%E5%88%99%E8%A1%A8%E8%BE%BE%E5%BC%8F%E7%9A%84%E6%95%88%E7%8E%87%EF%BC%9A%E5%9B%9E%E6%BA%AF%E4%B8%8E%E5%9B%BA%E5%8C%96%E5%88%86%E7%BB%84/
[php tips]: http://www.laruence.com/2011/03/24/858.html
[php性能]: http://pangee.me/blog/e22.html
[php apc浅析]: http://www.perfgeeks.com/?p=298
