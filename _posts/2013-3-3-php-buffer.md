---
layout: page
title:	php buffer
category: blog
description: 
---
$TOC$

#关于缓存类型
鸟哥在这里有所提及：[php buffer]
ob_*系列函数控制的是PHP自身的缓存
数据到浏览器显示，一般会经过三种缓存：
php oupput buffering->webServer buffering->browser buffering->display.

### 对应这三种缓存，有三种函数：
1.ob_flush()是刷新php自身的缓存(数据会输出) ob_clean()是清除php自身的缓存(数据不会输出了)
2.而flush()刷新webServer的缓存，仅当php作为webServer(如apache)的moudle时才有作用，它是刷新webserver的缓存(也3就是直接把数据推送了浏览器)
3.浏览器在显示之前同样也会缓存。

IE 缓存满256Bytes就显示
FF/CHROME 至少缓存1024字节且缓存出现了html标签时才直接显示
我们来做一个小实验

<pre>
set_time_limit(0);
$a='';
for($i=0;$i<1024;$i++) $a.='a';
echo $a;//输入1024+字节，以防止浏览器缓存
ob_end_flush();//#关闭并刷新缓存,当然你也可以设置php.ini中output_buffering=0

#第一次推送数据到浏览器
echo 'aaaaa';
flush();//刷新缓存（直接发送到浏览器）。此时可以不用ob_flush了，因为已经通过ob_end_flush关闭了php自身的缓存了

#第二次推送（等待1s以后）
sleep(1);
echo 'bbbbb';
flush();
</pre>

# 默认缓存的设置：

这个设置有php.ini中

<pre>
output_buffering = on #无限
output_buffering = off #关闭
output_buffering = 4096 #这个是默认值4k Bytes
当然你也可以通过ini_set ini_get 进行临时的设置和查询
另：使用ob_implicit_flush()时，每一次输出都会自动调用flush()
</pre>

# 关于缓存嵌套
php的ob缓存是嵌套的。
来看看下面这个例子。我们默认php.ini已经开启了缓存

<pre>
set_time_limit(0);
$buffer = array();
echo 'buffer1';
    ob_start();//开启第二个缓存
    echo 'buffer2';
    $buffer['buffer2']=ob_get_contents();
    ob_end_clean();//关闭第二个缓存
    $buffer['buffer1']=ob_get_contents();
    ob_end_clean();//关闭第一个缓存
var_dump($buffer);

</pre>

[php buffer]: http://www.laruence.com/2010/04/15/1414.html
