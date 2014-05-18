---
layout: page
title:	Install ADB on Mac OSX	
category: blog
description: 
---
# Install sdk
	$ brew install android-sdk
	==> Downloading http://dl.google.com/android/android-sdk_r22.0.5-macosx.zip
	######################################################################## 100.0%
	==> Downloading https://raw.github.com/CyanogenMod/android_sdk/3bf0a01ef66a9b99149ba3faaf34a1362581dd01/bash_completion/adb.bash
	######################################################################## 100.0%
	==> Caveats
	Now run the `android' tool to install the actual SDK stuff.

	The Android-SDK location for IDEs such as Eclipse, IntelliJ etc is:
	  /usr/local/Cellar/android-sdk/22.0.5

	You will have to install the platform-tools and docs EVERY time this formula
	updates. If you want to try and fix this then see the comment in this formula.

	You may need to add the following to your .bashrc:
	  export ANDROID_HOME=/usr/local/opt/android-sdk

	Bash completion has been installed to:
	  /usr/local/etc/bash_completion.d
	==> Summary
	🍺  /usr/local/Cellar/android-sdk/22.0.5: 683 files, 97M, built in 10.2 minutes

# Install 
执行：

	$ android
如果你只是想操作android手机或者刷机用，只需要勾选Platform-tools和Tools (这是ADT必须的)。
完成后就可以使用 adb（Android Debug Bridge）命令来调试手机了，输入：adb version 出现版本结果就大功告成。

# Reference
[adb on Mac][] 

[adb on Mac]: http://www.izhangheng.com/mac-os-x-homebrew-install-android-sdk/
