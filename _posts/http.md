---
layout: page
title:	About Http
category: blog
description: 
---
# Preface

# Referer
这个东西不仅仅用于统计, 也用于钓鱼(CSRF)

## 关于referer传递
### https中的referer
一般地
	
	# 会传送referer
	https->https
	http->https
	http->http

	# 不会传送refer
	https->http

但是如果头部加了[meta_referer](http://wiki.whatwg.org/wiki/Meta_referrer). https->http就会传送referer
	
	<meta name="referrer" content="origin">

Specs here:
	http://wiki.whatwg.org/wiki/Meta_referrer
Only supported by webkit at the moment, with Firefox support on the way (apparently).

### iframe/frame中的referer
1. 父页面访问iframe/frame的http src时, 所传referer为父页面(parent)
2. 在iframe内的http请求, 所带referer为iframe/frame自己的src. 如果为空, 就不会传递referer. 见以下两种情况:
	
	//不带referer
	document.querySelector('body').innerHTML='<iframe src="javascript:\'<!doctype html><script>location.href=\\\'http://weibo.cn\\\';</script>\'"></iframe>'
	//不带referer
	document.querySelector('body').innerHTML='<iframe src="javascript:location.href=\'http://weibo.cn\'"></iframe>'

## referer maintain in 301/302 redirect
考虑下这个情况: 在domainX 访问domainA, domainA 再301/302到domainB.
虽然[RFC](http://stackoverflow.com/questions/2158283/will-a-302-redirect-maintain-the-referer-string)并没有规定这个行为.
但在现代的浏览器中, domainB拿到的referer都是domainX.


## CSRF
CSRF 的本质是用户身份冒充. 为了避免这情况, 我们可以通过referer判断点击/请求是否是来自于可信页面.
但是可信页面又很难能做到可信. 比如这样的情况: 我们的网站A有两个页面/或者接口
1. pageA_visit #下行
2. pageA_modify #上行(CSRF漏洞针对的是这种接口/页面)

1. 恶意网站通过302传递受信的referer: 网站A 的pageA_visit 要跳到其它第三方网站B, 这样refer pageA_visit就被带到第三方网站B, 第三方网站B再302回网站A pageA_modify. PageA_modify拿到的referer还是pageA_visit (办法:)
2. 攻击者通过受信页面借刀杀人: 攻击者直接在pageA_visit 张贴 pageA_modify的url

对此可以有安全策略:

1. 限制受信页面的跳转:
	建立一个统一跳转的中间页面: 为避免302 referer保持, 使用js location; 有时为了灵活性, referer只限制了域名. 此时, 中间页面需要使用独立域名.

2. 判断referer+判断post
	post保证了本请求不会是302/301来的, 该请求一定来自于本站form提交. 而攻击者无法通过CSRF伪造这种请求.(当然,xss是可以的)

3. 为pageA_modify请求 增加跟用户身份相关的签名

### 一种iframe攻击
	通过设置opacity, 让用户误点iframe中的操作, 而用户却不自知
### 钓鱼网站
专门用来获取用户帐号信息.
