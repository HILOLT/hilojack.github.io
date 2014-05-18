---
layout: page
title:	
category: blog
description: 
---

# query Guest Ip
	# Update arp table
	for i in {1..255}; do ping -c 1 192.168.0.$i & done
	for i in {1..255}; do ping -c 1 10.209.0.$i & done

	# Find vm name
	VBoxManage list runningvms

	# Find MAC: subsitute vmname with your vm's name
	VBoxManage showvminfo vmname

	# Find IP: substitute vname-mac-addr with your vm's mac address in ':' notation
	arp -a | grep vmname-mac-addr
