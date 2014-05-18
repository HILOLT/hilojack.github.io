---
layout: page
title:	
category: blog
description: 
---

# 位置
## margin
边距: 
1. 两边间中距离, 取大边中的最大margin为实际margin.
2. 如果当前元素是float-right, 那么以margin-right为准, 而非margin-left.
3. 如果当前元素是float, 则margin就是距离其下元素的border外沿的距离.

## position
	position:
		static; 默认
		relative; 以static为基准
		absolute; 以所在元素左上角为基准
		fixed; 以窗口左上角为基准,不受鼠标滚动影响

		如果父结点为relative/absolute则以父结点为基准

# Css3
	CSS3 被划分为模块。
	其中最重要的 CSS3 模块包括：
	选择器
	框模型
	背景和边框
	文本效果
	2D/3D 转换
	动画
	多列布局
	用户界面

# opacity透明度
	opacity: 0~1

# background
	background:url x y no-repeat;//xy表示位置
## background-size
背景尺寸

	background-size:
		cover; 全覆盖
		10px 20px;放缩
		50% 50%;放缩

## background-position(位置)
 	background-position: 
		center center;//x y
		left;//x y
## background-origin
背景定位区域

	content-box
	padding-box
	border-box

## background-image:
	img1,img2, ...;

	background-repeat: no-repeat;
	background-attachment: fixed; //do not scroll with the page
# input 
	input[type="submit"] {
		background: limegreen;
		color: black;
		border:0;
	}

# boder
	border-radius: 11px;//圆角半径
	box-shadow: 2px 4px 6px 8px #ccc;
	box-shadow: x  y 模糊值 延伸值 #ccc;//模糊值不能为负
## box-shadow
box-shadow: h-shadow v-shadow blur spread color inset;

	h-v: 位置
	blur: 模糊化
	spread: 尺寸
	color:颜色
	inset: 内部显示

## boder-image
	border-image: url top right bottom left  repeat|initial|inherit;
	object.style.borderImage="url(border.png) 30 30 round"
	 repeat|initial|inherit;
		round: 平铺 改变大小 整数个
		repeat	重复	不改变大小
		stretch		拉伸	改变大小 1个
## border-color
	color 颜色
	initial 默认值
	transparent 透明

# About Text
## text-shadow
	text-shadow: 5px 5px 5px #FF0000;
	text-shadow: 水平 垂直 模糊 #FF0000;
## text-transform
	text-transform:
		uppercase|lowercase|capitalize;
## wrap
	word-wrap:
		break-word; 对长单词强制换行
	word-break: 	;控制空白(空格, 回车, 长句换行)
		break-all; 按字符换行(对中文无效)
		break-word;按单词换行, 不过长单词被强制割断.(等同于word-wrap: break-word)
		normal	按单词换行.长单词不换行 (initial)
	white-space: 控制空白(空格, 回车, 长句换行), 注意,长句换行时,  长单词不会换行
		//忽略回车
		nowrap; 合并空格| 忽略回车 | 长句不拆行 break-word
		normal; 合并空格| 忽略回车 | 长句要拆行 
		//回车换行
		pre;	不合空格| 回车换行 | 长句不拆行 
		pre-wrap;不合空格| 回车换行 | 长句要拆行 
		pre-line;合并空格| 回车换行 | 长句要拆行 

## overflow
	overflow:
		hidden;
		scroll;
		visiable;
# Font
	font-family:
	font-size:2em;
	font-weight:
		normal bold 100 200
	font-style:
		normal	italic 

# transform(2D)
	-webkit-transform:
		rotate(30deg); 顺时针30度旋转
		rotateX(); 
		rotateY(); 
		translate(xpx, ypx); 移动
		scale(2, 4); 水平扩大两倍, 垂直扩大4倍
		skew(30deg,20deg) 围绕 X 轴把元素倾斜 30 度，围绕 Y 轴倾斜 20 度。//-webkit-transform-origin:0px 0px ;倾斜的基点
		#
		matrix() 方法把所有 2D 转换方法组合在一起[matrix].
			matrix(1, 0, 0, 1, e, f) -> (1*x+0*y+e, 0*x+1*y+f) -> (x+e, y+f) -> translate(epx, fpx)
			matrix(cosθ,sinθ,-sinθ,cosθ,0,0) -> (x*cosθ-y*sinθ, x*sinθ+y*cosθ) -> rotate(θ);
			matrix(1,tan(θy),tan(θx),1,0,0) -> (x+y*tan(θx), x*tan(θy)+y) -> skew(θxdeg, θydeg);

# transition
CSS3 过渡是元素从一种样式逐渐改变为另一种的效果。
要实现这一点，主要规定：
	transition: property time action;
		property 规定您希望把效果添加到哪个 CSS 属性上
		time 规定效果的时长
		action:
			linear	规定以相同速度开始至结束的过渡效果（等于 cubic-bezier(0,0,1,1)）。
			ease	规定慢速开始，然后变快，然后慢速结束的过渡效果（cubic-bezier(0.25,0.1,0.25,1)）。
			ease-in	规定以慢速开始的过渡效果（等于 cubic-bezier(0.42,0,1,1)）。
			ease-out	规定以慢速结束的过渡效果（等于 cubic-bezier(0,0,0.58,1)）。
			ease-in-out	规定以慢速开始和结束的过渡效果（等于 cubic-bezier(0.42,0,0.58,1)）。
			cubic-bezier(n,n,n,n)	在 cubic-bezier 函数中定义自己的值。

	transition:width 2s, height 2s linear;
	transition:2s; //所有的性
	transition:1s width, 1s 2s height cubic-bezier(.8,.9,.1,2);//2s是延迟
	img:hover{} 经常用

## cublic-bezier
	 y = (1-t)^3*p0y + 3*(1-t)^2*t*p1y + 3*(1-t)*t^2p2y + t^3p3y

# 动画
设定每个时间点的样式集.

	div
	{
		width:100px;
		height:100px;
		background:red;
		position:relative;
		animation:myfirst 5s;
		animation:myfirst 5s backwards;//动画结束后返回每一桢
		animation:myfirst 5s ;//动画结束后返回每一桢
		animation:myfirst 5s 3;//播放3次
		animation:myfirst 5s infinite;//播放无限次
		-moz-animation:myfirst 5s; /* Firefox */
		-webkit-animation:myfirst 5s; /* Safari and Chrome */
		-o-animation:myfirst 5s; /* Opera */
	}

	@keyframes myfirst
	{
		0%   {background:red; left:0px; top:0px;}
		25%  {background:yellow; left:200px; top:0px;}
		50%  {background:blue; left:200px; top:200px;}
		75%  {background:green; left:0px; top:200px;}
		100% {background:red; left:0px; top:0px;}
	}

## animation-fill-mode属性。
动画保持的结束状态

	none：默认值，回到动画没开始时的状态。
	backwards：让动画回到第一帧的状态。
	both: 循环时, 轮流应用forwards和backwards规则
## animation-direction
动画循环播放时，每次都是从结束状态跳回到起始状态，再开始播放。animation-direction属性，可以改变这种行为。(浏览器对alternate的支持不好, 请慎用)

	normal: 正常播放
	reverse: 倒序动画
	alternate: 渐变, 循环播放时, 从结束到开始要平滑的过渡(实现规则是:step1, step2-reverse, step3, step4-reverse ...)
	alternate-reverse: 对倒序动画做渐变

## animation-play-state
有时，动画播放过程中，会突然停止。这时，默认行为是跳回到动画的开始状态。

	animation-play-state: running;
	animation-play-state: paused; //暂停
## 分布过渡step(time)
看看这个[typing](http://dabblet.com/gist/1745856)

	@-webkit-keyframes typing { from { width: 0; } }
	-webkit-animation: 10s typing infinite steps(10); //打字的效果

# 多列
	-webkit-column-count:3; //列数/* Safari and Chrome */
	-webkit-column-gap: 30px;//列间隔
	-webkit-column-rule:3px outset #ff0000;//列边宽度及样式

# 用户界面属性：
resize 
box-sizing
outline-offset

## resize
box-sizing 属性允许您以确切的方式定义适应某个区域的具体内容。

	<style> 
	div.container
	{
		width:30em;
		border:1em solid;
	}
	div.box
	{
		box-sizing:border-box;// 不加的话, box不会并列.
		width:50%;
		border:1em solid red;
		float:left;
	}
	</style>
	<body>
		<div class="container">
			<div class="box">这个 div 占据左半部分。</div>
			<div class="box">这个 div 占据右半部分。</div>
		</div>
	</body>

## outline-offset
outline-offset 属性对轮廓进行偏移，并在超出边框边缘的位置绘制轮廓。
	轮廓不占用空间

	div {
		border:2px solid black;
		outline:2px solid red;
		outline-offset:15px; //轮廓偏移
	}



# image

	Formal grammar: linear-gradient(  [ <angle> | to <side-or-corner> ,]? <color-stop> [, <color-stop>]+ )
									  \---------------------------------/ \----------------------------/
										Definition of the gradient line         List of color stops  

						  where <side-or-corner> = [left | right] || [top | bottom]
							and <color-stop> = <color> [ <percentage> | <length> ]?
	linear-gradient( 45deg, blue, red );           /* A gradient on 45deg axis starting blue and finishing red */
	linear-gradient( to left top, blue, red);      /* A gradient going from the bottom right to the top left starting blue and 
													  finishing red */

	linear-gradient( 0deg, blue, green 40%, red ); /* A gradient going from the bottom to top, starting blue, being green after 40% 
													  and finishing red */ 



# flex
	.parent{ display:flex;}
	.children1{ flex:1;}
	.children2{ flex:2;} //宽度自适应
# Reference
[matrix]
[css animation]
[cubic-bezier]


[matrix]: http://www.zhangxinxu.com/wordpress/2012/06/css3-transform-matrix-%E7%9F%A9%E9%98%B5/
[css animation]:http://www.ruanyifeng.com/blog/2014/02/css_transition_and_animation.html
[cubic-bezier]: http://yiminghe.iteye.com/blog/1762706
