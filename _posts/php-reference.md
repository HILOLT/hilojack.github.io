"=========== Meta ============
"StrID : 1406
"Title : 如何使用php引用
"Slug  : %e5%a6%82%e4%bd%95%e4%bd%bf%e7%94%a8php%e5%8f%98%e9%87%8f%e5%bc%95%e7%94%a8
"Cats  : Php
"Tags  : php
"=============================
"EditType   : post
"EditFormat : Markdown
"TextAttach : wpid1432-wpid-wpid-vimpress_51e4211d_mkd.txt
"========== Content ==========
$TOC$

# 序
php的引用类似于指针，但不同于指针，不合理的使用可能导致事倍功半，浪费调试时间，而本文旨在总结关于引用的正确方法（任何问题，请不吝指教）。
关于引用的本质，见[php之变量引用].

# 两种引用
参考[php之变量引用]的说明,php zval结构有两种引用，本文所指的引用为后者（is_ref=1这种情况）
	$a = $b; //refcount=2,is_ref=0(隐式引用)
	$a = &$b; //refcount=2,is_ref=1

# foreach的坑
foreach在循环时，所有循环的数组都是拷贝：

	$arr = array('Li Lei',"Wei Hua");
	foreach($arr as $k=>$name){
		if(0===$k){
			$arr[$k+1]= 'Wei Hua1';//copy $arr on write
		}else{
			var_dump($k,$name);//这里不会是"Wei Hua1".因为循环的是关于$arr的拷贝(已经变量分离)
		}	
	}

如果需要在循环时改变值，可以借助引用．但是引用时注意别进入到这个坑：

	$arr = array('badminton','tennis');
	foreach($arr as &$name){
		//some code	
	}

	//some other code
	
	$brr = array('basketball','football');
	foreach($brr as $name){
		//some code 	
	}
	var_dump($arr[1]);// 'tennis' or 'football'?

如果$name没有明确的使用范围，一个好习惯是，foreach后，unset($name)释放$name对zval的引用。

# 数组元素的引用
看这个例子：
	
	$arr = array('a');	
	$brr[0] = &$arr[0];
	//some code
	$crr = $brr;
	$crr[0] = 'c';
	var_dump($arr['0']);//'a' or 'c'?

结：混乱的逻辑加上不区分范围的引用，最容易导致值被莫名奇妙的篡改．使用引用时应该注意的是： 

1. 在函数调用过程中，按引用传参或者用局部变量去引用数组元素，函数调用结束后会变量被销毁(refcount=1,is_ref=0)，引用解除，不必担心这个问题
1. 如果数据需要保持固定和统一（也就是没有被篡改机会），也可以考虑引用。

# 如何使用引用形参
## 引用的优点
如果传递的形参是一个大数组，并且会有变量分离的过程，那么引用形参能使代码更kiss/省时/省空间。
看以下两个例子：第一个例子几乎没有耗用内存，

	<?php
	function strip(&$arr){
		$arr['text'] = strip_tags($arr['text']);//change on write
		return memory_get_usage();
	}
	$arr = array_pad(array(),1e3,'string')+array('text'=>'<b>Hello!</b>');
	$init_m_size = memory_get_usage();
	echo strip($arr)-$init_m_size;//函数调用过程中耗用了208字节

第二个例子耗费了近100k(96.7K)的内存

	function strip($arr){
		$arr['text'] = strip_tags($arr['text']);//copy on write
		return memory_get_usage();
	}
	$arr = array_pad(array(),1e3,'string')+array('text'=>'<b>Hello!</b>');
	$init_m_size = memory_get_usage();
	echo strip($arr)-$init_m_size;//函数调用过程中耗用了96704字节

## 一个例子
大部分情况下，格式化数组的mblog,我们可能会这么写（实际项目中的代码比这8行复杂得多）

	$users = array(
		array(
			'name'=>'name1',
			'mblog'=>...,
		),
		array(
			'name'=>'name2',
			'mblog'=>...,
		),
		...
	);

	//有8行
	$mblogs = array();
	foreach($users as $k=>$user){
		$mblogs[$k]=>$user['mblog'];
	}
	$formatMblogs = getFormatMblog($mblogs);
	foreach($formatMblogs as $k=>$mblog){
		$users[$k]['mblog'] = $mblog;	
	}

	//这个是公共函数
	function getFormatMblog($mblogs){
		$mblogList = array();
		foreach($mblogs as $k=>$mblog){
			if(condition === true){
				//do format mblog
				$mblogList['k']	= $mblog;
			}
		}
		return $mblogList;
	}

通过引用，我们可以有一种更kiss（简洁）/更省时／更省空间写法：

	//只有4行
	$mblogs = array();
	foreach($users as $k=>&$user){
		$mblogs[$k]=>&$user['mblog'];
	}
	formatMblog($mblogs);


	//这个是公共函数
	function formatMblog(&$mblogs){
		foreach($mblogs as $k=>&$mblog){
			if(condition === true){
				//do format mblog
			}
		}
	}

>> 函数调用结束后，形参/局部变量会被销毁，引用被解除

#　变量别名不需要引用
没有必要这么做：

	$name = 'name';
	$name_alias = &$name;

因为按值传递并不会浪费内存

	$name = 'name';
	$name_alias = $name;


[php之变量引用]: http://hilojack.sinaapp.com/?p=1392
