---
layout: page
title:	js notes
category: blog
description: 
---
# Variable
强制类型转换:
	Boolean(value) - 把给定的值转换成 Boolean 型；
	Number(value) - 把给定的值转换成数字（可以是整数或浮点数）；
	String(value) - 把给定的值转换成字符串；
## Compare
[js Boolean比较问题研究](http://www.joglex.com/?p=189)

	[]==[];//false 因为它们指向不同的对象. 这跟php是不一样的.
	[]==0; //true Number({})的值为NaN，而Number([])的值为0 Number(null)为0 Number(undefined) = NaN
	{}==0; //false

	null==undefined; //true
	0==''==false;//true

	![];//false 对象取反都为
	!null;!undefined;!'';!0; //true


## Array
	new Array(1,2,3);
	arr = [1,2,'d'];
	brr[0]=11;
	arr;//[11,2,'d']; //因为数组赋值使用的是对象引用

	.length
	.concat(arr2)
	.join([separator]); //implode
	.pop() ;//返回item
	.push(item1, itme2, ...);//return length
	.reverse()
	.shift();//左移(移出) .unshift(item1,item2);//右移(移入)

	.slice(start, end); //支持负数
	.splice(start, end);//删除
	.sort([funcSort]);

	转换:

		arr.toString();arr.valueOf();
		arr.join(',');//

	栈方法:

		arr.push('new item');
		arr.pop();

	队例:

		arr.push('new');
		arr.shift();//LIFO 后进先出

	重排方法(改变arr本身):

		arr.reverse();//倒序
		arr.sort();//从小到大
		arr.sort(function(a,b){return a-b;});//自定义排序

	操作方法:
		
		[0,1].concat(2,[3,4]);//返回数组[0,1,2,3,4];
		arr.slice(start,[end]);//范围不含end本身,end可为负数,
		arr.splice(start,[length]);//返回删除范围
		arr.splice(start,length,val1,val2,....);//返回删除范围,并插入数据

	位置方法:
		
		['aa','bb','cc'].indexOf('aa');//0 找不到就返回-1
		['aa','bb','cc','aa'].lastIndexOf('aa');//3 找不到就返回-1

	迭代方法:
		
		.every(func);//每一项运行给定函数都返回true,结果才返回true. //func= function(item,index,array){}; array是对数组本身的引用
		.some(func);//只有其中一项运行指定函数时返回true,结果就返回true.
		.filter(func);//返回运行为true item组成的数组
		.map(func);//返回函数运行结果组成的数组
		.forEach(func);//只运行不返回

	归并方法:

		.reduce(func);//从第一项开始
		.reduceRight(func);//从最后一项开始
		arr.reduce(function(pre,cur,index,array){return pre+cur;})
		

## Date
	$d = new Date("October 13, 1975 11:13:00");
	
	//date & time
	Date(); 		"Mon Apr 28 2014 23:25:02 GMT+0800 (CST)"
	toString(); 	"Mon Apr 28 2014 23:25:02 GMT+0800 (CST)"
	toUTCString();	"Mon, 28 Apr 2014 15:25:02 GMT" //UTC & GMT 是一样的(除了精度上有区别)
	toGMTString();	"Mon, 28 Apr 2014 15:25:02 GMT" 
	toLocaleString(); "4/28/2014 11:25:02 PM"

	//date part
	getDate(); //1~31 getUTCDate()
	getMonth(); //0~11 getUTCMonth()
	getFullYear(); //四位数字	getUTCFullYear()
	//day
	getDay(); //一周中的某天0~6

	//time part
	getHours()	返回 Date 对象的小时 (0 ~ 23)。 getUTCHours()
	getMinutes()	返回 Date 对象的分钟 (0 ~ 59)。	getUTCMinutes()
	getSeconds()	返回 Date 对象的秒数 (0 ~ 59)。 getUTCSeconds()
	getMilliseconds()	返回 Date 对象的毫秒(0 ~ 999)。getUTCMilliseconds()

	//unixstimestamp
	getTime()	返回 1970 年 1 月 1 日至今的毫秒数。
	Date.parse("Jul 8, 2005 0:0:32"); //返回指定时间的毫秒数
	UTC()	根据世界时返回 1970 年 1 月 1 日 到指定日期的毫秒数。

### compare
	d1 > d2

### set
	//day
	setDate()	设置 Date 对象中月的某一天 (1 ~ 31)。

	//Month
	setMonth()	设置 Date 对象中月份 (0 ~ 11)。

	//Year
	setFullYear()	设置 Date 对象中的年份（四位数字）。 setYear()	使用 setFullYear() 方法代替。

	//Hours & Minutes & Seconds
	setHours()	设置 Date 对象中的小时 (0 ~ 23)。
	setMinutes()	设置 Date 对象中的分钟 (0 ~ 59)。
	setSeconds()	设置 Date 对象中的秒钟 (0 ~ 59)。
	setMilliseconds()	设置 Date 对象中的毫秒 (0 ~ 999)。

	//Time
	setTime(millisec)	以毫秒设置 Date 对象。d.setTime(77771564221)

## String
	.charAt(pos)
	.charCodeAt(pos) //返回ascii十进制表示
	.fromCharCode(97)
	#搜索
	.indexOf(sub_string)
	.lastIndexOf(sub_str)
	#compare
	.localeCompare(str) //return 1 0 -1
	#截取
	.substr(start,[length])//start可为负
	.slice(start, [end]) //start, end可为负
	#case
	.toLowerCase() / .toUpperCase()

### split
支持regexp

	stringObject.split(separator,[maxSize]); 
	'1,2,3,4,5'.split(',', 3);//[1,2,3]
	'1,2,3,4,5'.split(/,/);//[1,2,3,4,5]


### font
	str.link(url)
	str.bold()
	str.sup() 上标
	str.sub() 下标 //"<sub>str</sub>"
	str.small() 小字号
	str.big()
	str.fontcolor('red') "<font color="red">s</font>"
	's'.fontsize('1px')


### Match
	//return 存放匹配结果的数组
	stringObject.match(searchvalue)


	stringObject.match(regexp)
	matches = ("1 2 3 ".match(/\d+/g); //[1,2,3]
	"1 2 3".match(/(\d) s/g); //return null

	//如果regexp没有g
	matches = "first 1".match(/(\w+) 1/);//如果没有g, 则返回包括子表达式  ["first 1", "first"]
	matches.index //0 相当于indexOf返回的位置

> 如果需要同时支持regExp global 及 子表达式, 请使用RegExp.prototype.exec

### search
返回字符位置, 不支持regexp global; 这个像indexOf()

	str.search('string') equal to str.indexOf('string'); //返回字符位置
	str.search(/Hilo/i);
### replace
支持regexp global.

	str = stringObject.replace(regexp/substr,replacement)
	replacement:
		string:
			字符	替换文本
			$1、$2、...、$99	与 regexp 中的第 1 到第 99 个子表达式相匹配的文本。
			$&	与 regexp 相匹配的子串。
			$`	位于匹配子串左侧的文本。
			$'	位于匹配子串右侧的文本。
			$$	$转义
		function:
			function(mathStr, first, second, ...){return replace;}

eg:
	
	//reference
	'funing smoking '.replace(/(\w+)ing/g, '$1');// "fun smok "
	//func
	card = '[card]google[/card]http://g.cn'; // to "<a href="http://g.cn">google</a>"
	card.replace(/\[card\](\w+)\[\/card\]([\w:\/.]+)/,function(ori,card,url){
		return '<a href="'+url+'">'+card+'</a>';
	})

## RegExp
Create RegExp：

	/pattern/attributes
	/str/igm
	new RegExp(pattern, attributes);
	new RegExp("str",'igm')
### test
	test	检索字符串中指定的值。返回 true 或 false。
	str=' 1 2 3';
	r=/\d/igm;
	while(r.test(str) === true){
		console.log(r.lastIndex);//2 4 6 下次要匹配的字符串起始位置
	}
### comile
	r.compile(/\d/); //改变正则表达式
	
### exec
	str=' 1ing 2ing 3ing';
	r=/\d(ing)/igm;
	while((match = r.exec(str)) !== null){
		console.log(match,r.lastIndex);//第一次输出 ["1ing", "ing", index: 1, input: " 1ing 2ing 3ing"] 5 
	}
	
## Func
这里罗列的是顶层函数（全局函数）
### 转码:
常规字符: 字母 数字 下划线

	encodeURI()	把字符串编码为 URI。
		encodeURI("http://www.google.com/a file with spaces.html"); //转码所有非常规URI字符转码: '|" Ò' 等等
	encodeURIComponent()	把字符串编码为 URI 组件。(所有URI特殊字符 将被转码)
	escape()	对字符串进行编码。Don't use it, as it has been deprecated since ECMAScript v3.
	str.replace(/'/g, "\\'");//addslashes


	eval()	计算 JavaScript 字符串，并把它作为脚本代码来执行。

## Number
	数值范围:Number.MIN_VALUE~Number.MAX_VALUE (一般是5e-324~1.79769e+308)
	parseInt('0x10', [进制]) //number or NaN
	parseFloat(var) //number or NaN
	Number(undefined);//NaN
	Number(null);//0
	(10).toString(16);//'a'
	num.toFixed(2); //两位小数
	num.toExponential([小数位数]);// 科学计数法
	num.toPrecision([有效位数]); //据最有意义的形式来返回数字的预定形式或指数形式

## Math
	E	返回算术常量 e，即自然对数的底数（约等于2.718）。
	LN2	返回 2 的自然对数（约等于0.693）。
	LN10	返回 10 的自然对数（约等于2.302）。
	LOG2E	返回以 2 为底的 e 的对数（约等于 1.414）。
	LOG10E	返回以 10 为底的 e 的对数（约等于0.434）。
	PI	返回圆周率（约等于3.14159）。
	SQRT1_2	返回返回 2 的平方根的倒数（约等于 0.707）。
	SQRT2	返回 2 的平方根（约等于 1.414）。


## Boolean
null == undefined 可相等.

但它们与false/true/0 都不能相等
	null==0 //return false	
	undefined==0 //return false	
	undefined==false //return false	
	

## Obj
### 判断原型
	obj instanceof funcname// 函数原型名

### Undefined && Null
没有值和空值

	typeof null; "object"
	typeof undefined; "undefined"

## function

# 运算符
## 一元
	delete variable
	delete obj.name 
##位运算
	num & num
	num | num	
	~num 取反
	num ^ num	//xor
	#位移
	1<<2 # 1<<34 == 1<<2
	#有符号右移(高位1不会变)
	a=1<<31; 
	a>>32 === a>>0 === a;

	#无符号右移(高位1会变成0),输出无符号数 
	a
	-2147483648
	a>>>0
	2147483648
	a>>>1
	1073741824
	a>>>32
	2147483648
## 逻辑
	!var
	var && var
		逻辑 AND 运算并不一定返回 Boolean 值：
			如果一个运算数是对象，另一个是 Boolean 值，返回该对象。
				1 && obj //return obj
				0 && obj // return 0
				obj1 && obj2 //return obj2(if obj1不为空)
			如果某个运算数是 null
				1 && null //return null
				0 && null //return 0
			如果某个运算数是 NaN
				1 && NaN //return NaN
				0 && NaN //return 0
	var || var
		逻辑 OR 运算并不一定返回 Boolean 值(同上)
		
# 语句
## 迭代
	for(i in obj){sth...} // PropertyIsEnumerable
# 函数
## arguments
	function a(name){
		arguments[0]='v11';
		console.log(arguments, name);
	}
	a('v1','v2'); //output: ['v11', 'v2'], 'v11'

## function 对象
	new a(); 函数本身就是一个constructor.
	a.length; //参数数量
## 闭包
	变量的作用域链.

# Obj(面向对象)
## Obj属性
constructor(指向函数)
	对创建对象的函数的引用（指针）。对于 Object 对象，该指针指向原始的 Object() 函数。
Prototype(指向对象原型)
	对该对象的对象原型的引用。对于所有的对象，它默认返回 Object 对象的一个实例。

hasOwnProperty('property')
	判断对象是否有某个特定的属性

IsPrototypeOf(object)
	判断该对象是否为另一个对象的原型。

PropertyIsEnumerable
	判断给定的属性是否可以用 for...in 语句进行枚举。

## 创建对象
	1. obj = new Object();
	2. person={firstname:"John"};
	3. obj = new func(param1, param2);

## 本地对象
	Object
	Function
	Array
	String
	Boolean
	Number
	Date
	RegExp
	Error
	EvalError
	RangeError
	ReferenceError
	SyntaxError
	TypeError
	URIError
## 静态作用域
可以构造一个:

	function a(){};
	a.name=1;
## 定义对象的模式
### 工厂方式
工厂方式的点是: 
1. 每次new factory 都会创建单独的函数
2. 太复杂
	
	function factory(v1, v2){
		obj = new Object();
		obj.param1 = v1;
		obj.param2 = v2;
		obj.func = function(){}; 
		return obj;
	}

### 构造方式
1. 每次都会生成新的function.
但:

	function construction(v1,v2){
		this.p1 = v1;
		this.p2 = v2;
		this.func = function(){}; //为避免重复的func, 可在外部定义
	}
	
### 原型方式
1. 不能传参数

	function Car() {
	}
	Car.prototype.color = "blue";
	Car.prototype.showColor = function() {
	  alert(this.color);
	};	
	(new Car) instanceof Car;//true;
	(new Car) instanceof Object;//true;
	(new Car) instanceof Number;//false;

### 构造原型混合
#. 构造: 放私有的属性
#. 原型: 放公共的属性

1. 批评混合的构造函数/原型方式的人认为，在构造函数内部找属性，在其外部找方法的做法不合逻辑: 所以就有一种动态 构造/原型混合

#### 动态构造原型混合
function Car(color){
	//private
	this.color=color;

	//public
	if (typeof Car._initialized == "undefined") {
		var self = Car;
		self.prototype.showColor = function() {
		  console.log(this.color);
		};
		self._initialized = true;
	}
  }

## 继承
### 对象冒充
ClassB 继承 ClassA
	
	function ClassA(color){
		this.color = color;
	}
	function ClassB(color, num){
		this.method = ClassA; //ClassB就冒充了ClassA中的this
		this.method(color)
		delete this.method;

		this.method = ClassA1; //ClassB就冒充了ClassA1中的this(可以多重继承的)
		this.method(num);
		delete this.method;
		
		this.color = value; //Notice; 会覆盖前面的属性. 请确保属性名不冲突
	}
	new ClassB('red', 5);
### Call()
	function sayColor(sPrefix,sSuffix) {
		alert(sPrefix + this.color + sSuffix);
	};

	var obj = new Object();
	obj.color = "blue";

	sayColor.call(obj, "The color is ", "a very nice color indeed.");// saycolor中的this会指向obj, obj对象就冒充了saycolor.

#### 用call 实现继承
	function ClassB(sColor, sName) {
		//this.newMethod = ClassA;
		//this.newMethod(color);
		//delete this.newMethod;
		ClassA.call(this, sColor);//this冒充了ClassA

		this.name = sName;
		this.sayName = function () {
			alert(this.name);
		};
	}

### apply 方法
apply与call方法类似, 除了参数调用形式不一样.

	function sayColor(sPrefix,sSuffix) {
		alert(sPrefix + this.color + sSuffix);
	};

	var obj = new Object();
	obj.color = "blue";

	sayColor.apply(obj, new Array("The color is ", "a very nice color indeed."));
		
#### apply 实现继承.
	function ClassB(sColor, sName) {
		//this.newMethod = ClassA;
		//this.newMethod(color);
		//delete this.newMethod;
		ClassA.apply(this, arguments);//arguments === new Array(sColor);

		this.name = sName;
		this.sayName = function () {
			alert(this.name);
		};
	}

### 原型链（prototype chaining）
用prototype 对象去继承.
缺点: 不能控制被继承类的传参(一般都不会传参数)
	
	function ClassA() {
	}

	ClassA.prototype.color = "blue";
	ClassA.prototype.sayColor = function () {
		alert(this.color);
	};

	function ClassB() {
	}

	ClassB.prototype = new ClassA(); //继承了啦.

### 混合方式
对象冒充: 不能冒充静态成员(prototype public)
原型链: 因为protype 是公共的, 所以传argument(private)就不合适了.故产生了两种混合的方式. 

	function ClassA(color) {
		this.color = color;
		if(ClassA.init === undefined){
			ClassA.init = true;
			ClassA.prototype.sayColor = function () {
				console.log(this.color);
			};
		}
	}

	
	function ClassB(sColor, sName) {
		var self = ClassB;
		if( self.init === undefined){
			self.init = true;
			self.prototype = new ClassA(); //1. 原型链冒充 原类的静态成员(prototype). 最好别传new ClassA(sColor),因为sColor应该是每个对象私有的. 
		}
		ClassA.call(this, sColor);// 2. 再冒充ClasA对象.
		this.name = sName;
	}


