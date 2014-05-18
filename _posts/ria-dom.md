---
layout: page
title:	js notes
category: blog
description: 
---
# Bom
# Window
## 屏幕-窗口-页面 位置与尺寸
屏幕-窗口-页面
页面全高为: scrollTop + 窗口内高

	//屏幕大小
	screen.width/screen.height 屏幕的宽和高 这个是固定的
	1440/900

	//屏幕可用于窗口的宽高(窗口最大化时的大小)
	screen.availWidth/screen.availHeight 屏幕可用工作区宽/高(不受窗口大小的影响)
	1440/826

	//窗口位置 (0/22)
	screenX = screenLeft/screenY = screenLeft (窗口左上角点在整个屏幕的位置)

	//窗口内外宽/高
	window.innerWidth/window.innerHeight
	897/731
	window.outerWidth/window.outerHeight 当前页面可视区的外宽/高(含边界)
	1177/826

	//页面的宽高
	//不含 scrollBar, border, and the margin.
	document.body.clientWidth .clientHeight body本身的宽/高
	//不含margin.
	document.body.offsetWidth .offsetHeight 同上
	897/11468
	//全部
	document.body.scrollWidth .scrollHeight
	960/11473	 11473 = 10742+731
	scrollHeight = document.body.scrollTop + window.innerHeight

	//滚动偏移
	document.body.scrollLeft .scrollTop	正文滚动的偏移
## location
	location.href
	location.host
	location.hash
	location.origin
	location.port
	location.pathname

## history
	history.back() //history.go(-1)
	history.forward() // history.go(1)

## cookie
	document.cookie = 'a=1;expires='+d.toGMTString()
	function getCookie(k){
		c=document.cookie;
		start = c.indexOf(k+'=');
		v = '';
		if(start>-1){
			end = c.indexOf(';', start);
			if(end <0) end = c.length;
			v = c.substr(start, end)
		}
		return v;
	}

# Dom	
## Dom Document
	all[]	提供对文档中所有 HTML 元素的访问。
	anchors[]	返回对文档中所有 Anchor 对象的引用。
	applets	返回对文档中所有 Applet 对象的引用。
	forms[]	返回对文档中所有 Form 对象引用。
	images[]	返回对文档中所有 Image 对象引用。
	links[]A 返回对文档中所有 Area 和 Link 对象引用。

		
# Dom Node 
## Search Node
### query
	document.getElementById('id');
	document.getElementsByTagName('p');
	document.getElementsByName('name');
	document.querySelector(str);str='#id','.class', 'tag'
	document.querySelectorAll(str);str='#id','.class', 'tag'
### global node
	document.body
	document.head
## create node
	document.createElement("p");
	document.createTextNode("这是新段落。");
## delete node
	child.parentNode.removeChild(child);

## node 属性
	node.nodeName; //
	node.nodeValue; //
	node.nodeType; //元素1 属性2 文本3 注释8 文档9

# Dom Attribute
## Get Attribute
	node.getAttribute('name')
	
## Set Attribute
	node.setAttribute('name', value);
	
# Dom Class
	array node.classList
	string node.className
	node.classList.add(className);
	node.classList.remove(className);

## Style
	node.style[key]

# Dom Event
## 一般事件
	onclick
	onload/onunload 进入或离开页面时
	onchange 表单改变时
	onmouseover 和 onmouseout 事件
	onmousedown、onmouseup
	onfocus

	//监听顺利
	btn1Obj.addEventListener("click",method1,false);
	btn1Obj.addEventListener("click",method2,false);
	btn1Obj.addEventListener("click",method3,false);
	执行顺序为method1->method2->method3
	useCapture=false //不捕获

	e.stopPropagation()//阻止冒泡
	e.currentTarget //
	e.srcElement:

# Dom HTML
## iframe
访问iframe:
	document.getElementById('frameId').contentDocument.document; //有跨域限制.

	属性	描述
	align	根据周围的文字排列 iframe。
	contentDocument	容纳框架的内容的文档。
	frameBorder	设置或返回是否显示 iframe 周围的边框。
	height	设置或返回 iframe 的高度。
	id	设置或返回 iframe 的 id。
	longDesc	设置或返回描述 iframe 内容的文档的 URL。
	marginHeight	设置或返回 iframe 的顶部和底部的页空白。
	marginWidth	设置或返回 iframe 的左侧和右侧的页空白。
	name	设置或返回 iframe 的名称。
	scrolling	设置或返回 iframe 是否可拥有滚动条。
	src	设置或返回应载入 iframe 中的文档的 URL。
	width	设置或返回 iframe 的宽度。
