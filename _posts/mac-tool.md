---
layout: page
title:	
category: blog
description: 
---
# Preface

# brew
## install brew
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

	# install gsed
	brew install gsed
	# intall macvim
	brew install macvim --override-system-vim
	
所有的安装文件都是放在.(通过link连接到其它的地方, 非常方便管理)

	ls /usr/local/Cellar

## install brew-cask
brew-cask 较app store 软件更新, 更简洁

	brew tap phinze/homebrew-cask && brew install brew-cask
	# 所有软件位置
	/opt/homebrew-cask/Caskroom
	# install chrome
	brew cast install chrome
	# cleanup cached downloads
	brew cast cleanup

# Alfred2
比spotlight更强大的高效快捷键工具, 通过它你可以呼起任意的app, url. 而且可以定制呼起关键词, 传递的参数

# scutil
系统配置命令: scutil -- Manage system configuration parameters

	scutil --set ComputerName 'Hilo Book'

## local HostName
	http://support.apple.com/kb/ph3763
	Local hostname (or “local network name”): Other computers on the same network subnet can find your computer by this name using Bonjour, a network technology developed by Apple Inc. Bonjour-compatible devices and services (such as computers or printers) automatically advertise their availability on the local network, so you can easily find devices and services you want to use. You can change the local network name.

To find your network address: 
Choose Apple menu > System Preferences, and then click Sharing.
The network address appears below the Computer Name field.
If the computer name ends in “.local,” it is visible on your local subnet; users on other network subnets or on different networks can’t see it.


#  dict
mac 有非常方便的自带的dict. 可以通过shortcut呼出. 也可能通过alfred2呼出
字典文件在: $ ls /Library/Dictionaries ~/Library/Dictionaries 见[mac-install]

	$ du -sh /Library/Dictionaries/*
	$ du -sh ~/Library/Dictionaries/*
    Apple Dictionary.dictionary
	New Oxford American Dictionary.dictionary
	Oxford American Writer's Thesaurus.dictionary
	Oxford Dictionary of English.dictionary
	Oxford Thesaurus of English.dictionary
	Simplified Chinese - English.dictionary

## install other dict
我觉得自带的Simplified ce 就做中英翻译就非常够用了. 如果需要下载的词典
可以:[在baidu pan下载](http://pan.baidu.com/s/1o6z67dK#dir/path=%2Fdictionary), 下载后解压到字典目录就ok了.

	mv langdao-ec-gb.dictionary -d ~/Library/Dictionaries

安装好了后, 在dict中按`Cmd+,`选择字典就可以了

> 另外我想说明的是dict 支持维基, 可是不支持google translate, 不过可以通过alfred 实现google translate

## shortcut
    Ctrl+Cmd+D #select a word then press this shortcut anywhere.
	
## alfred2
    def word

如果不满足, 也可以直接呼出google/baidu 查询.我自己定义的tl会呼起google tranlate
    tl word
    df word

## text to voice
In System Preference -> [Text to voice](http://computers.tutsplus.com/tutorials/give-your-mac-a-voice-with-text-to-speech--mac-4943)
### shortcut
    Alt+ESC
### say 'word'
    $ say 'word'
### Voice Files Dir
    /System/Library/Speech/Voices

# mail
	mail.md
# clipboard( pbpaste )
1. Copy a string: echo "ohai im in ur clipboardz" | pbcopy
2. Copy the HTML of StackOverflow.com: curl "http://stackoverflow.com/" | pbcopy
2. Open a new buffer in VIM, initialized to the content of the clipboard: pbpaste | vim -
2. Save the contents of the clipboard directly to a file: pbpaste > newfile.txt

# volume/brightness
You can increase or decrease your volume by quarter increments by Pressing:

	⌥ + ⇧ + Volume Up/Down

The same also works for brightness.
> Related to this tip, option+any volume key will open the sound system preference pane, and shift+vol up/down will change volume silently (without the little plink sound.

# open dir from title
In a document-based application (like Finder, TextEdit, Preview, Pages…), after a document has been saved, a proxy icon for the document appears in the title bar. It represent the file itself, and can be likewise manipulated:

click it for a few seconds and drag to another application to open it, or to the desktop/Finder if you want to copy/move it, etc…
⌘-click (or control-click, or right-click) it to view the path menu, useful to open the folder or any subfolders of the file in the Finder.

# cmd-tab
While Cmd tabbing between applications, without releasing CMD, you can hit 'Q' to quit or 'H' to hide the selected application. Works great with the mouse to get rid of a whole bunch of applications quickly.

The bevel won't go away and you can repeat this for as many applications as you like as long as you're holding CMD.


# Thin out
du -s * path | sort -nr > path.du
## /Var
	man hier
	# before restart
	$ sudo du -s /private/var/* | sort -n -r
	7128360	/private/var/db
	4325376	/private/var/vm
	2476936	/private/var/folders
	1.2G	/private/var/folders/
	94528	/private/var/log
	# after 
	
## cache
	/Library/Caches/Homebrew
	/Library/Caches/*
## iPhoto
	uninstall iPhoto or del /Applications/iPhoto.app//iPhoto/Contents/Resources/Themes/
## Speech synthesis voices
	rm /System/Library/Speech/Voices/ #just keep one(My voice is)
	sudo mv Alex.SpeechVoice/ Alex.SpeechVoice.ori
	sudo find . -maxdepth 1 -name '*.SpeechVoice' -exec rm -rf {} \;
	sudo mv Alex.SpeechVoice.ori/ Alex.SpeechVoice

## mail
	rm /Users/hilojack/Library/Containers/com.apple.mail/Data/Library/Mail\ Downloads/*


## dict(this is my Dictionary List)
	 du -sh /Library/Dictionaries/*
	 du -sh ~/Library/Dictionaries/*
	4.3M	/Library/Dictionaries/Apple Dictionary.dictionary
	 65M	/Library/Dictionaries/New Oxford American Dictionary.dictionary
	4.8M	/Library/Dictionaries/Oxford American Writer's Thesaurus.dictionary
	 65M	/Library/Dictionaries/Oxford Dictionary of English.dictionary
	6.7M	/Library/Dictionaries/Oxford Thesaurus of English.dictionary
	 29M	/Library/Dictionaries/Simplified Chinese - English.dictionary

	sudo rm -rf Sanseido\ The\ WISDOM\ English-Japanese\ Japanese-English\ Dictionary.dictionary/
	rm ~/Library/Dictionaries/

>> ps:
在任何文字区域上按下 control+cmd+D 就可呼出取词窗口，词典会根据鼠标的位置自动取词

# ~/Library
## Netbeans
	rm ~/Library/Application\ Support/NetBeans/7.4/var/log/heapdump.hprof.old (800M)
## QQ
	rm -r Library/Containers/com.tencent.qq/Data/Library/Application\ Support/QQ/* (1.2G)
# Music
	rm ~/Music/
# command line tool for xcode（xcode is not necearray）
https://developer.apple.com/downloads/ #gcc complier

# service 
## create service shortcut
	http://computers.tutsplus.com/tutorials/how-to-launch-any-app-with-a-keyboard-shortcut--mac-31463
## delete service
ls ~/Library/Services

# xcode
[xcode](http://esoftmobile.com/2013/10/30/start-developing-mac-apps-today/)

# Automator
## Shortcuts 
[via Automator services]( http://computers.tutsplus.com/tutorials/how-to-launch-any-app-with-a-keyboard-shortcut--mac-31463)

### google in chrome
http://superuser.com/questions/369934/mac-os-x-lion-chrome-shortcut-for-search-with-google
> U can also set shortcut for translate in google.

[Automator mactalk](http://macshuo.com/?tag=automator)
