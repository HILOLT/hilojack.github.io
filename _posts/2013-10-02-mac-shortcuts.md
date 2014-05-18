---
layout: page
title:  Mac shortcuts
category: blog
description: 
---

# Preface
This is my note about shortcuts in Mac OS X.Any suggestion would be appreciated..
> In this paper,  `Opt` and `Alt` are exactly the same.

# Alfred2.0
看看池建强的[alfred2.0 使用](http://www.zhihu.com/question/20656680)

	1 安装
	2、基础快捷键：option+space
	3、打开应用程序：Alfred 几乎是一切程序的入口，你再也不需要找妈妈要开始菜单了。用快捷键呼出Alfred，输入任何一款应用程序的中文或英文名称，即可快速定位程序，回车打开。
	4、简单查找文件：用快捷键呼出Alfred，键入空格，输入你要查找文件名，即可定位文件，回车打开，command+回车打开文件所在文件夹。
	5、复杂操作文件：通过find、open、in等关键词搜索文件。find是定位文件，open是定位并打开文件，in是在文件中进行全文检索，三种检索方式基本上可以找到任何你想找的文件。
	6、直接当做计算器使用。
	7、操作Shell：输入>即可直接运行shell命令。比如>cat *.py | grep print，可以直接打开终端并查找当前py文件中包含 print 的语句。
	8、输入iTunes，会出现一个 iTunes mini play，打开可以通过 Alfred 控制音乐播放。用快捷键也能完成这个功能：shift+option+command+p
	9、输入email，后面跟邮件地址，可以直接打开写邮件的界面
	10、定义文字片段，在 Alfred 的设置-Features 选中Clipboard，在Snippets里定义自己常用的文字片段，比如代码、地址等等等，之后以option+command+c 呼出界面，输入文字片段的关键字回车即可。
	11、在option+command+c 呼出的界面里还包括剪贴板历史，输入关键字自动匹配。
	12、简单搜索：直接输入你要查询的内容，回车即可打开默认浏览器进行搜索。
	13、自定义搜索，这个稍微复杂些，打开设置窗口，点击Features-Custom Search，在右侧栏添加自定义搜索。举几个例子帮助大家理解下规则：


# App
	⌘ +,	Setting
	⌘ +i	App Info
	⌘ +?	Help
	⌘ +n	New Tab
	⌘ +o	Open File
	⌘ +<num>	Switch Tab
	按住ctrl+单击 弹出右键菜单.
	<F5> get suggestions while typing. 
	⌘ + click on a dock icon takes you to the respective app in /applications
	⌥ +<function> will bring up the System Preference panel for that key. Here's a list:

		⌥ +Brightness: Displays
		⌥ +Exposé/Dashboard: Exposé and Spaces
		⌥ +Mute/Volume: Sound
		⌥ +Keyboard Brightness: Keyboard (for Macs with backlit keyboards)

	Remember that if you have checked the option to use F1, F2, etc. keys as standard function keys, done in System Preferences>Keyboard, then you will need to add the fn to the afore mentioned sequences.


# Edit

	ctrl+p shell中上一个命令,或者 文本中移动到上一行
	ctrl+n shell中下一个命令,或者 文本中移动到下一行
	ctrl+r 往后搜索历史命令 
	ctrl+s 往前搜索历史命令
	ctrl+f 光标前移
	ctrl+b 光标后退
	ctrl+a 到行首
	ctrl+e 到行尾
	ctrl+d 删除一个字符,删除一个字符，相当于通常的Delete键
	ctrl+h 退格删除一个字符,相当于通常的Backspace键
	ctrl+u 删除到行首
	ctrl+k 删除到行尾
	ctrl+l 类似 clear 命令效果 
	ctrl+y 粘贴(粘贴的是ctrl+k ctrl+u所删除的字符串)
	Alt+Del Delete a word
	Alt+Left/Right Move cursor step by word
	Shift+Alt+Left/Right Select  by word
	Fn+Del	Backspace
	Ctrl+Left/Right Move cursor to Head/End of line

## Action
	⌘ +C/V		Copy/Paste
	⌘ +P		Print
	⌘ +S		Save
	⇧ +⌘ +S		Save As
	⌘ +Z		Undo/Redo
	⌘ +O		Open
	⌘ +Del		Selects "Don't Save" in dialogs that contain a Don't Save button, in OS X Lion and Mountain Lion
	⌥ +⌘ +F	Move to the search field control
	⌘ +G		Find The Next occurence of the Selection
	⇧ +⌘ +G		Find The Previous occurence of the Selection
	⌘ +Click		Right Button Menu
	⌘ +[/]		Backward/Forward
	⌘ +Left/Right		Backward/Forward(When Input Method Unactived ) 
	⌘ +Left/Right		Move Cursor To Line Head/End(When Input Method Actived ) 
	⌥ +Left/Right		Move Cursor By Word(Input Method)
	⌘ +F		Search
	⌘ +A		Select All (Alt+Cmd+A undo in Finder)

## Format
### Font
	⌘ +B 		Toggle Boldface the Selected Text
	⌘ +I	Italicize the selected text or toggle italic text on or off
	⌘ +T	Display the Fonts window
	⌘ +U	Underline the selected text or turn underlining on or off

### Style
	⌥ +⌘ +C/V Copy/Apply the Style of Selected Text
	⇧ +⌥ +⌘ +V	Apply the style of the surrounding text to the inserted object (Paste and Match Style)
	Ctrl-⌘ +C/V	Copy/Apply the formatting settings of the selected item and store on the Clipboard

### Color
	⇧ +⌘ +C	Display Color Window

## Cursor Move
### By Page
	⌘ +Up/Down	Home/End
	Control-V	Move Down one Page
	Fn-Up/Down	Move Up/Down one Page
### By Line
	Control-A/E 	Move to Beginning/End
	Control-P/N		Move to Previous/Next Line
### By Word
	⌥ +Left/Right
### By Character
	Left/Right
	Control-B/F		Move one character backward/forward
### By Area
	Control-L		Center the cursor

## Delete
### By Line
	Control-U/K Delete the Char Behind/In_front of the cursor.
### By Word
	Control-W	Delete One Word Behind the cursor
	⌥ +Del		Delete One Word Behind the cursor
### By Character
	Control-H/D	Delete one Char Backward/Forward
	Fn-Del		Forward delete
## Insert
	Control-O	Insert a new line after the cursor
	Control-T	Transpose the character behind the cursor and the character in front of the cursor

# Dictionary
	Ctrl-⌘ +D	Display the definition of the selected word in the Dictionary application


# Window & App
## Desktop
	Control-Left/Right	Switch between Full apps
	Control-Up/Down		Switch Mission Control(Also U could )
	⌥ +⌘ +D			Show/Hide Dock

## Window & Function
	⌘ +M		Minimize Windows
	⇧ +⌘ +F Full Screen
	⌥ +⌘ +M	Minimize All Windows
	⌘ +H		Hide Current Window
	⌘ +⌥ +H	Hide Other Window
	F11			Hidden All Windows
	F12			Show/Hidden Dashboard
	⌘ +N		New Window
	⌘ +T		New Tab
	⌘ +W		Close Tab or the frontmost Window
	⇧ +⌘ +W	Close a file and its associated Windows
	⌥ +⌘ +W	Close All Windows in the app without quit it
	⌘ +Q		Quit App
	⌘ +Tab		Move forward to next most recently application in a list open application
	⌘ +Tab(Then Press Opt)		Move forward to next most recently application in a list open application(maxmized application)
	⌘ +:		Display spelling Window
	⌘ +?		Open Help
	⌥ +⌘ +I	Display an inspector window

## Action
	⌘ +,		Preference
	⌘ +`		Acitvate the next open window in the frontmost application
	⌘ +Tab		Switch app-cycle forward
	⌘ +M		Minimize Window
	⌘ ++/-		Increase/Decrease the size of the selected item
	⌘ +0		Normal Size(in Chrome)
	⌘ +{/} 	Left/Right-align a selection
	⌥ +⌘ +Left/Right 	Left/Right-align a selection
	⌘ +| 		Center-align a selection

## Toolbar
	⌥ +⌘ +T	Show/Hide Toolbar

## Capture
	⌘ +# Capture the screen to a file
	Ctrl-⌘ +# Capture the screen to a Clipboard
	⌘ +$ Capture a selection to a file
	Ctrl-⌘ +$ Capture a selection to a Clipboard


## dock
	⌥ +⌘ +D		Hide Dock Toggle

# Chrome
	⌘ +L Highlight address bar
	⌘ +1/2/3/...9		Go to tab 1/2/3...9
	⌘ +0		Normal Size(in Chrome)
	⇧ +⌘ +N		Incognito(Chrome)
	⌘ +{/}		Previous/Next Tab
	⌥ +⌘ +Left/Right		Previous/Next Tab
	⌥ +⌘ +I 	Developer Tools
	⌥ +⌘ +U 	View Source
	⌥ +⌘ +J 	JS Console
	⌥ +⌘ +C 	Select an element to inspect it
	⌥ +⌘ +B 	Bookbar Manager
	⇧ +⌘ +B Show Bookbar 

## Text
	⌥ +⌘ +C	Copy url to Clipboard
	⇧ +⌥ +⌘ +V	Paste without format
	

# Terminal
	⌘ +{/}		Previous/Next Tab
	⇧ +⌘ +Left/Right	Previous/Next Tab
	


# Finder
## Action
	⌘ +T		Add to Sidebar(New Tab)
	⌥ +⌘ +While-dragging Make alias of dragged item
	⇧ +⌘ +N		New Folder(finder) 
	⌘ +Del		Move to Trash
	⇧ +⌘ +Del		Empty Trash
	⇧ +⌥ +⌘ +Del		Empty Trash without confirmation dialog

## Goto
	⌘ +R		Show Original(Of alias)
	⇧ +⌘ +G		Go To Dirtory
	⌘ +Double_click Open a folder in separate window
	⌘ +Click_the_window_title	See ther folders that contain current window
	⌘ +Up		Open parent folder
	⌘ +Down		Open parent folder
	Control-⌘ +Up		Opend parent folder in new Window

	⌘ +[/]	Previous/Later Dirctory

	⌥ +⌘ +N		New Smart Folder
	⌥ +⌘ +F		Search File By FileName and Contents within Current Window
	⇧ +⌘ +T		Add to favorites
	⇧ +⌘ +H/A/U/D		Home/Applications/Uitilities/Desktop
	⇧ +⌘ +C		Computer
	⇧ +⌘ +O		Documents
	⇧ +⌘ +K		Network
	⇧ +⌘ +F		All Files
	⌥ +⌘ +L		Downloads
### Goto Server
	⌘ +K		Connect To Server(ftp)

## Select
	⌥ +⌘ +A		Undo Select in Finder

## Copy(Cut) & paste
	#copy file
	⌘ +C #copy
	⌘ +V #paste

	#cut file
	⌘ +C #cut
	⌥ +⌘ +V #paste

	⌘ +drag	copy file
	⌥ +drage	cut file
	⌘ +D		Create Copy
	⌥ +While-dragging Create Copy
	⌘ +L		Make alias of the selected item //

## View
	⌘ +1/2/3/4		View as icon/list/columns/CoverFlow
	Space or ⌘ +Y	Quick Look
	⌥ +⌘ +Y		Slideshow selected item
	⌘ +I		Show Info(focused)
	⌥ +⌘ +I		Show Info(unfocued)
	⌘ +J		Show View Options
	⌥ +⌘ +T		Hide/Show toolbar in window


# System

	⇧ +⌘ +Q		Log out
	Ctrl-⌘ +⏏ /Power		Restart
	⌥ +⌘ +⏏ /Power		Sleep
	ctrl + ⌥ + ⌘ + ⏏/Power 	Shuts the computer down
	⇧ + ctrl + ⏏/Power 		send display only to sleep (great for locking your computer instantly)
	ctrl + ⌘ + ⏏ restarts the Mac
	⌥ + ⌘ + esc lets you kill not responding programs (including the Finder)

# QQ
	⌘ +1	Contact list
	⌘ +f	Find contact
	Ctrl+⌘ +s	Open latest unread message
	Ctrl+⌘ +x	Open latest unread message list
	Ctrl+⌘ +z	Open all unread messages
	⌘ +up/down	Select Pre/Next chat

# Input Symbols
	⌥ +K 	
	⌥ +R ‰
	⌥ += ≠
	⌥ ++ ±
	⌥ +@ €
	⌥ +2 ™
	⌥ +3 £
	⌥ +5 ∞
	⌥ +6 §
	⌥ +( ·
	⌥ +z Ω
	⌥ +o ø
	⌥ +p π
	⌥ +v √
	⌥ +w ∑
	⌥ +b ∫
	⌥ +r ®
	⌥ +g ©
	⌥ +, ≤
	⌥ +. ≥
	⌥ +j ∆
	⌥ +x ≈
	⌥ +m µ

For more details,refer to [Type Symbols](http://www.wikihow.com/Type-Symbols-Using-the-ALT-Key)

## Some Symbols
	⎋	Escape	U+238B
		Apple symbol 1	U+F8FF
	⌃	Control key
	⌥	Option key
	⇧	Shift Key
	⇪	Caps Lock
	Fn	Function Key
	⇥	Tab forward	U+21E5
	⇤	Tab back	U+21E4
	⇪	Capslock	U+21EA
	⇧	Shift	U+21E7
	⌃	Control	U+2303
	⌥	Option (Alt, Alternative)	U+2325
	⌘	Command (Open Apple) 2	U+2318
	␣	Space	U+2423
	⏎
	↩	Return	U+23CE
	⌫	Delete back	U+232B
	⌦	Delete forward	U+2326
	﹖⃝	Help	U+003F & U+20DD
	⇱
	↖
	↸	Home	U+21F1
	⇲
	↘	End	U+21F2
	U+2198
	⇞	Pageup	U+21DE
	⇟	Pagedown	U+21DF
	↑
	⇡	Up arrow	U+2191
	↓
	⇣	Down arrow	U+2193
	←
	⇠	Left arrow	U+2190
	→
	⇢	Right arrow	U+2192
	⌧	Clear	U+2327
	⇭	Numberlock	U+21ED
	⌤	Enter	U+2324
	⏏	Eject	U+23CF
	⌽	Power 3	U+233D

# Reference
[The shortcuts in Mac]
[mac hide feature]

[The shortcuts in Mac]: http://support.apple.com/kb/ht1343
[mac hide feature]: http://apple.stackexchange.com/questions/400/please-share-your-hidden-os-x-features-or-tips-and-tricks
