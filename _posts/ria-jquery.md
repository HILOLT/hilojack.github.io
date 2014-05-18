---
layout: page
title:	
category: blog
description: 
---
# selector
	$(selector)
		$('div span')
		$('#mydiv')
	$(selector, this)
		var optionSelected = $("option:selected", this); //you are finding all selector elements inside this's context. 		
	    var valueSelected = this.value;
## node
	//创建节点
	$('<span></span>')
	//调用节点
	$(node); //$(document).ready()

# 效果
## hide
node.hide()
node.show()
node.toggle()

## 淡入/淡出
### fadeIn
	node.fadeIn(speed, callback)
		speed:
			null
			'slow'/'fast'
			3000 //3000ms
		callback:
			function(){....} //没有参数
### fadeOut
	node.fadeOut(speed, callback)
### fadeToggle
	node.fadeToggle(speed, callback)

### fadeTo
$(selector).fadeTo(speed,opacity,callback);
	opacity: 透明度
		0~1

## slide滑动
	$(selector).slideDown(speed,callback);
	$(selector).slideUp(speed,callback);
	$(selector).slideToggle(speed,callback);

## animation动画
必选的css属性. css3也有相应的动画效果: -webkit-animation: myAnimation speed;

	$(selector).animate({params},speed,callback);
		params:
			{left:'250px',
				height:'+=150px',//相对值
				marginLeft:'10px' //必须使用 Camel 标记法书写所有的属性名，比如，必须使用 paddingLeft 而不是 padding-left，使用 marginRight 而不是 margin-right，等等。
			}
	
## stop
停止动画/淡入淡出

	$(selector).stop(stopAll,goToEnd);
		stopAll:
			default:false
			false/true;//是否清除所有动画队列
		goToEnd:
			default:false
			false/true;//是否立即完成当前动画

# html
## 查询
	$(select).text();//innerText
	$(select).html();//取html. 相当了innerHTML
	$(select).val();//取value
	$(select).attr('name');//取得属性

## 设置
	$(select).text(value);
	$(select).html(value);
	$(select).val(value);
	$(select).attr(name, value);
	$(select).attr({name:value});

	//以上都支持回调
	$("#test1").text(function(i,origText){
	    return "Old text: " + origText + " New text: Hello world!
		(index: " + i + ")";
	});

## append & prepend
	 $(select).append('hello world!');
	 $("p").prepend("Some prepended text.");
	 
	 $("p").prepend(node1, node2, ...);

## after & before
在行踪元素后面, 或者开头添加节点, 相当于:

	$("img").after("Some text after");
	$("img").after(node1, node2, ...);
	$("img").before("Some text before");

## remove & empty
	$("#div1").remove(); //删除自己
	$("p").remove(".italic"); //删除class="italic" 的p node

	$("#div1").empty(); //删除div1下的子元素

# Css
## ClassName
	.addClass(ClassName);
	.removeClass(ClassName);
	.toggleClass(ClassName);
## Attribute
	.css(propertyname); //return Attribute value
	.css(propertyname, value); //set Attribute value
	.css(propertyname, value); //set Attribute value
	.css({'k1':'v1', 'k2':'v2'}); //set Attribute value
## size
	width() ;//不包括内边距、边框或外边距）。
	height()
	innerWidth() //包括padding
	innerHeight()
	outerWidth() //包括border. outerWidth(true)则包括border & margin
	outerHeight()

# Dom Node
祖先:
	父		
		.parent();//父节点
	祖父\曾神父\曾曾祖父...
		.prents(); //所有父节点
		.parents('ul'); //所有标签为ul的父节点
		$('span').parentsUntil('div'); //父节点以div为止, 不含div
后代: 
	子、
		$('div').children(); //所有div之下的所有子节点
		 $("div").children("p.1"); //筛选出所有类名为.1的p标签节点
	孙、曾孙...
		$("div").find("span"); //所有孙子中的span节点
		$("div").find("*"); //所有孙子节点

同胞:

	siblings()
	next()
	nextAll()
	nextUntil()
	prev()
	prevAll()
	prevUntil('p');//直到p(不含p)

过滤:

	 $("div p").first();//div 中第一个p
	 $("div p").last();//div 中第一个p
	 $("p").eq(0);//第一个p 注意 $('p')[0]拿到的是dom节点, 而不是jquery节点对象数组
	 $("p").filter(".intro");//类名为intro的p
	$("p").not(".intro"); //与filter相反

# ajax
## load
	$(selector).load(URL,data,callback);
		如果data是对象, 则post, 否则get
	$(selector).load('a.txt');// 用a.txt改变当前结节的innerHTML
	$(selector).load('a.txt #p1');// 用a.txt中的#p1节点元素改变当前结节的innerHTML
	$(selector).load(url, function(responseTxt,statusTxt,xhr){...});

## .get
	$.get("demo_test.asp",function(responseTxt,statusTxt){});
	$.post("demo_test.asp",data, function(responseTxt,statusTxt){});

# noConflict
	jq = $.noConflict();
	jq(document).ready(function($){
		$("button").click(function(){
		  $("p").text("jQuery 仍在运行！");
		});
	});

# Event
## some event
	$(func);
	$(document).ready(func);
## add Event
	$( "input#name" ).click(function(eventObject) {
		console.log(eventObject);
		$( this ).slideUp();
		this.value = this.value.toUpperCase();
	  });
	$( "select" ).select(function(eventObject) {

## Del Event
	$('p').unbind('click');
	$('p').attr('onclick','').unbind('click');//If you have setted attr
