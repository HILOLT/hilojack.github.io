---
layout: page
title:	html5
category: blog
description: 
---
# Tag

## Forms
属性

	autocomplete(自动完成)
		autocomplete="off" //默认自动完成是on
	multiple(多选)
		<input type="file" name="img" multiple="multiple" />

## Input

	email:	<input type="email" name="xxx" />
	url:	<input type="url" name="xxx" />
	number:	<input type="number" name="points" min="1" max="10" />
	range: <input type="range" name="points" min="1" max="10" />
	date:
		month, week, time
		<input type="time" />
	
### Datalist-Option
	Select-Option

	<select name="browser">
		<option value="firefox">Firefox</option>
		<option value="chrome">Chrome</option>
		<option value="opera">Opera</option>
		<option value="safari">Safari</option>
	</select>

Datalist-Option: 
1. 需要id与list绑定
1. 用户可做任意修改数据

	<input type=text list=browsers>
	<datalist id=browsers> 
		<option value="Firefox">
		<option value="Chrome">
		<option value="Opera">
		<option value="Safari">
	</datalist>

##　video
	node.play();
	node.pause();
	node.load();

	  <video id="video1" width="420" style="margin-top:15px;">
		<source src="/example/html5/mov_bbb.mp4" type="video/mp4" />
		<source src="/example/html5/mov_bbb.ogg" type="video/ogg" />
		Your browser does not support HTML5 video.
	  </video>

## radio

## drag
	<img draggable="true" />
### 拖动什么 - ondragstart 和 setData()
	ondragstart = function drag (ev){
		ev.dataTransfer.setData("Text",ev.target.id);
	}
	
### 目标区行为ondragover
	//否则目标区不会接受drop行为
	ondragover="allowDrop(event)"
	function allowDrop(ev) {
		ev.preventDefault();
	}
### 开始放置drop
	ondrop = function drop(ev){
		ev.preventDefault();
		var data=ev.dataTransfer.getData("Text");
		ev.target.appendChild(document.getElementById(data));
	}

## Canvas
	<canvas id="myCanvas" width="200" height="100"></canvas>

	var c=document.getElementById("myCanvas");
	//context 对象
	var cxt=c.getContext("2d");
	//画矩形
	cxt.fillStyle="#FF0000";
	cxt.fillRect(0,0,150,75); 
	//画线
	cxt.moveTo(10,10);//提笔移动
	cxt.lineTo(150,50);//执笔画线
	cxt.lineTo(10,50);
	cxt.stroke();//收笔

	//画圆
	cxt.fillStyle="#FF0000";
	cxt.beginPath();
	cxt.arc(70,18,15,0,Math.PI*2,true);
	cxt.closePath();
	cxt.fill();

	//渐变
	var grd=cxt.createLinearGradient(0,0,175,50);
	grd.addColorStop(0,"#FF0000");
	grd.addColorStop(1,"#00FF00");
	cxt.fillStyle=grd;
	cxt.fillRect(0,0,175,50);

	//画片
	var img=new Image()
	img.src="flower.png"
	cxt.drawImage(img,0,0);

## svg
SVG 意为可缩放矢量图形（Scalable Vector Graphics）

	Canvas
	依赖分辨率
	不支持事件处理器
	弱的文本渲染能力
	能够以 .png 或 .jpg 格式保存结果图像
	最适合图像密集型的游戏，其中的许多对象会被频繁重绘
	SVG
	不依赖分辨率
	支持事件处理器
	最适合带有大型渲染区域的应用程序（比如谷歌地图）
	复杂度高会减慢渲染速度（任何过度使用 DOM 的应用都不快）
	不适合游戏应用

# Location(navigator.geolocation)
	navigator.geolocation.getCurrentPosition(showPos, showErr);
	funciton showPos(pos){
		x = pos.corrds.latitude;
		y = pos.corrds.longtitude;
	}
	function showErr(err){
		switch(err.code){
			case err.PERMISSION_DENIED: break;
			case err.POSITION_UNAVAILABLE: break;
			case err.TIMEOUT: break;
			case err.UNKNOWN_ERROR: break;
		}
	}

其它方法:

	watchPosition() - 返回用户的当前位置，并继续返回用户移动时的更新位置（就像汽车上的 GPS）。
	clearWatch() - 停止 watchPosition() 方法

# web存储
	localStorage.name
	sessionStorage.name

# Web Workers
web worker 是运行在后台的 JavaScript，不会影响页面的性能。

##创建web worker文件

		var i=0;
		function count(){
			i++;
			postMessage(i);
			setTimeout("count()",500);
		}
		count();

## 引入worker

		w = new Worker('worker.js');
		w.onmessage = function(ev){
			console.log(ev.data);
		}
		w.terminate();

>由于 web worker 位于外部文件中，它们无法访问下例 JavaScript 对象：
`window/document/parent`.

# server-sent event 服务器发送事件
Server-Sent 事件指的是网页自动获取来自服务器的更新。
以前也可能做到这一点，前提是网页不得不询问是否有可用的更新。通过服务器发送事件，更新能够自动到达。

## 服务器端a.php

	header('Content-Type: text/event-stream');//务器端事件流 "Content-Type" 报头设置为 "text/event-stream" 服务器端会自己轮询.
	header('Cache-Control: no-cache');

	$time = date('r');
	echo "data: The server time is: {$time}\n\n";
	flush();
		
## Client端

	source = new EventSource('/test');
	source.onmessage = function(ev){console.log(ev.data);}
	source.onerror
	source.onopen

