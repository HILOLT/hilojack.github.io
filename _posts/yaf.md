---
layout: page
title:	
category: blog
description: 
---
# Preface
# config
## php.ini
	yaf.library=/var/www/library
	yaf.environ	product	PHP_INI_ALL	环境名称, 当用INI作为Yaf的配置文件时, 这个指明了Yaf将要在INI配置中读取的节的名字
	yaf.library	NULL	PHP_INI_ALL	全局类库的目录路径
	yaf.cache_config	0	PHP_INI_SYSTEM	是否缓存配置文件(只针对INI配置文件生效), 打开此选项可在复杂配置的情况下提高性能
	yaf.name_suffix	1	PHP_INI_ALL	在处理Controller, Action, Plugin, Model的时候, 类名中关键信息是否是后缀式, 比如UserModel, 而在前缀模式下则是ModelUser
	yaf.name_separator	""	PHP_INI_ALL	在处理Controller, Action, Plugin, Model的时候, 前缀和名字之间的分隔符, 默认为空, 也就是UserPlugin, 加入设置为"_", 则判断的依据就会变成:"User_Plugin", 这个主要是为了兼容ST已有的命名规范
	yaf.forward_limit	5	PHP_INI_ALL	forward最大嵌套深度
	yaf.use_namespace	0	PHP_INI_SYSTEM	开启的情况下, Yaf将会使用命名空间方式注册自己的类, 比如Yaf_Application将会变成Yaf\Application
	yaf.use_spl_autoload	0	PHP_INI_ALL	开启的情况下, Yaf在加载不成功的情况下, 会继续让PHP的自动加载函数加载, 从性能考虑, 除非特殊情况, 否则保持这个选项关闭

## application/conf
	$app  = new Yaf_Application(APP_PATH . "/conf/application.ini");

### application.ini

	application.directory=/usr/
	application.ext	String	php	PHP脚本的扩展名
	application.bootstrap	String	Bootstrapplication.php	Bootstrap路径(绝对路径)
	application.library	String	application.directory + "/library"	本地(自身)类库的绝对目录地址
	application.baseUri	String	NULL	在路由中, 需要忽略的路径前缀, 一般不需要设置, Yaf会自动判断.
	application.dispatcher.defaultModule	String	index	默认的模块
	application.dispatcher.throwException	Bool	True	在出错的时候, 是否抛出异常
	application.dispatcher.catchException	Bool	False	是否使用默认的异常捕获Controller, 如果开启, 在有未捕获的异常的时候, 控制权会交给ErrorController的errorAction方法, 可以通过$request->getException()获得此异常对象
	application.dispatcher.defaultController	String	index	默认的控制器
	application.dispatcher.defaultAction	String	index	默认的动作
	application.view.ext	String	phtml	视图模板扩展名
	application.modules	String	Index	声明存在的模块名, 请注意, 如果你要定义这个值, 一定要定义Index Module
	application.system.*	String	*	通过这个属性, 可以修改yaf的runtime configure, 比如application.system.lowcase_path, 但是请注意只有PHP_INI_ALL的配置项才可以在这里被修改, 此选项从2.2.0开始引入


## 加载顺序
index.php 

	->$app = new Yaf_Application('conf/app.ini') //set application.directory=APPLICATION_PATH
	->$app ->bootstrap() ->run();

## 自动加载器
Yaf在自启动的时候, 会通过SPL注册一个自己的Autoloader

表 5.1. Yaf目录映射规则

类型	后缀(或者前缀, 可以通过php.ini中ap.name_suffix来切换)	映射路径
控制器	Controller	默认模块下为{项目路径}/controllers/, 否则为{项目路径}/modules/{模块名}/controllers/
数据模型	Model	{项目路径}/models/
插件	Plugin	{项目路径}/plugins/

