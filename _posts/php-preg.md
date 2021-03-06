---
layout: page
title:	
category: blog
description: 
---
$TOC$

# 序
本文描述的是php中正则与通用正则的特殊性以及[30分钟正则入门]不曾提及的东西.
如果你觉得有必要的话,请到这里补补课[30分钟正则入门](http://deerchao.net/tutorials/regex/regex.htm).

# 转义序列

	\ddd 

>8进制或者后向引用（当字组数量大于等于ddd/dd所表示的十进数时或者只有一个d时，就表示后向引用，否则就尝试解析为８进制,不成功就将"\"解析为单字节"\x00"中纯数字本身的含义）eg:\40 当字组有40个以上时,就表示后向引用. \81 先尝试解析为后向引用,否则尝试角析为8进制,最后才解析为"\x0081"

具体来说:
	
	"#\40#" 匹配 "\040"
	"#\040#" 匹配 "\040"
	"#\81#" 匹配 "\x0081"
	"#\7#" 匹配 后向引用分组7

其它:

	\xhh #16进制
	\p{xx} #符合xx属性的字符(unicode) eg: "\p{Sc}"匹配货币符号'$'
	\P{xx} \p{^xx} #不符合xx属性的字符(unicode)
	

# 内部修饰符
语法为：
	
	(?修饰符)

	'/(?i)sss/' #(?i)忽略大小写敏感
	'/(?Ui)sss/' #(?Ui)去贪婪且忽略大小写敏感,或者在量词后面加'?'号实现贪婪逆转,如'*?','+?' 
	'/(?s)sss/' #(?s)使得.可以匹配换行符

# 外部模式修正符
	
	i 忽略字符敏感
	s .号匹配换行
	u 匹配utf8字符(unicode)(与perl不兼容)
	U 去贪婪(与perl不兼容)
	e 仅在perg_replace时生效，当有e时，会对replace后的字符进行eval（不建议使用e）

# 分组
php叫子组(子模式)

	'/(sum) min/' #捕获一个子组(子组序号最多99个)
	'/(?<total>sum) min/' #命名一个子组
	'/(?:sum) min/' #不捕获子组(捕获子组和非捕获子组最多200个)
	'/(?|(sum)|(total)) min/' #不捕获本子组,但在有'|'时,(sum)与(total)反向引用都占1.如果使用'?:',"sum"与"total"会分别占用\1和\2
	'/(?Ui:sum) min/' #?与:之间可以加修饰符.等价于'/(?:(?Ui)sum) min/'

## 反向引用
	
	'/(sum)\1/'
	'/(sum)\g{1}/'
	'/(sum)(total)\g{2}/' #等同于 '/(sum)(total)total/' 
	'/(sum)(total)\g{-1}/' #负数是相对的反向引用(-1指往前数第一个分组)

*php 5.2.4后已经支持对子组名称的引用*

	'/(?<name>xuehui)(total)\g{name}/' 

## 非回溯子表达式

	(\d+foo) #在匹配123bar时,第一次失败,回溯匹配23bar,又失败,再回溯匹配3bar,再回溯.
	(?>\d+foo) ?>分组匹配失败后,不会再回溯.
## 条件子组
php 不支持平衡树,但支持条件子组:

	(?(condition)yes-pattern)
	(?(condition)yes-pattern|no-pattern)

其中:
	
	condition 可以为引用/(?(1)yes|no)/
	condition 可以为断言/(?(?=[a-z])yes|no)/

## 递归子组
php5.4之后,会支持递归子组.

	(?R)  #这个?R反向引用正则本身	
	(?num)  #这个?num反向引用第num个子分组,而非子分组所匹配的字符\num

比如:
	
	#\((?R)*\)#		就可匹配 "((()))"括号对
	#(blue|red) (?1)#		就可匹配 "blue red"括号对
	#(blue|red) (\1)#		只能匹配 "blue blue","red red"

# 字符匹配
## 字符类
除了\d、\D、 \s、\S、\w 和 \W 外，perl支持posix.比如：

	[:digit:] #等同于数字\d
	[:^digit:] #等同于非数字\D
	[:lower:] #小写
	[12[:lower:]] #作为元字符


<table class="doctable table"> <caption><strong>Character classes</strong></caption> <tbody class="tbody"> <tr><td><em>alnum</em></td><td>字母和数字</td></tr> <tr><td><em>alpha</em></td><td>字母</td></tr> <tr><td><em>ascii</em></td><td>0 - 127的ascii字符</td></tr> <tr><td><em>blank</em></td><td>空格和水平制表符</td></tr> <tr><td><em>cntrl</em></td><td>控制字符</td></tr> <tr><td><em>digit</em></td><td>十进制数(same as \d)</td></tr> <tr><td><em>graph</em></td><td>打印字符, 不包括空格</td></tr> <tr><td><em>lower</em></td><td>小写字母</td></tr> <tr><td><em>print</em></td><td>打印字符,包含空格</td></tr> <tr><td><em>punct</em></td><td>打印字符, 不包括字母和数字</td></tr> <tr><td><em>space</em></td><td>空白字符 (比\s多垂直制表符)</td></tr> <tr><td><em>upper</em></td><td>大写字母</td></tr> <tr><td><em>word</em></td><td>单词字符(same as \w)</td></tr> <tr><td><em>xdigit</em></td><td>十六进制数字</td></tr> </tbody> </table>

## 汉字
汉字编码都是多字节的,而关于多字节元字符,目前php仅支持utf8的unicode.
要想元字符支持多字节,必须启用修正符u,见[php 修正符](http://php.net/manual/zh/reference.pcre.pattern.modifiers.php)
示例:
	
	preg('/[\x{4444}-\x{9555}]/u','新01',$m);//4444 指的是utf8字符对应的unicode码位,而非utf8码值(我们常说的utf8编码)
	preg('/[\x{4444}-\x{9555}]/u',"\xe6\x96\xb001",$m);//与上面的是等价的,'新'的utf8编码是\xe696b0. unicode码位是\x65b0.

>ps:网上所搜索的php gbk正则匹配 大多是错的.php的/u修正符并不包含gbk,仅包括utf-8.

>ps:如果你安装了vim,让光标处于这个汉字上,按ga显示其unicode编码,按g8显示其utf-8编码.另,fcitx中,可以按`ctrl+shift+alt+u`,然后输入'0x65b0'这个unicode找到主个汉字.


# 参考
[php pcre]

[php pcre]: http://www.php.net/manual/zh/reference.pcre.pattern.syntax.php
