---
layout: page
title:	
category: blog
description: 
---

$TOC$
# 下载goagent-git
	yaourt -S goagent-git 
## 安装 crt 在 firefox/chrome 

## 下载  Proxy SwitchySharp in chrome
	并设置代理为goagent代理
	http://127.0.0.1:8087
## edit /opt/goagent/local/proxy.ini
	appid = appid1|appid2

# 上传 server
用sdk工具来上传其实很方便

## download appengine sdk
	https://developers.google.com/appengine/downloads
## upload
### 打开app.yaml指定自己的appid
	sudo vim /opt/goagent/server/python/app.yaml 
### 上传server
	python google_appengine/appcfg.py update goagent/server/python/	
> 撤消证书认证 如果你绑定过hosts，那么你无法通过证书验证
	
	fancy_urllib.InvalidCertificateException: Host appengine.google.com returned an invalid certificate (hostname mismatch):

> 那么就过滤掉认证代码： vim /home/hilo/test/google_appengine/lib/fancy_urllib/fancy_urllib/__init__.py

	#        if self.cert_reqs & ssl.CERT_REQUIRED:
	#          cert = self.sock.getpeercert()
	#          hostname = self.host.split(':', 0)[0]
	#          if not self._validate_certificate_hostname(cert, hostname):
	#            raise InvalidCertificateException(hostname, cert,
	#                                              'hostname mismatch')

# 运行
## 运行goagent代理
	sudo /opt/goagent/local/proxy.py 
## 打开你的chrome访问这个代理
	利用proxy swith插件可以很方便的在代理和直连间切换
	如果你不会正则，也可以用通配符，比如*.google.com/*
