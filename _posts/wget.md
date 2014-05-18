---
layout: page
title:	wget
category: blog
description: 
---
# Dump Site
	wget --random-wait -r -p -e robots=off -U mozilla http://pcottle.github.io/learnGitBranching/

	-p parameter tells wget to include all files, including images.
	-e robots=off you don’t want wget to obey by the robots.txt file
	-U mozilla as your browsers identity.
	--random-wait to let wget chose a random number of seconds to wait, avoid get into black list.
	--limit-rate=20k limits the rate at which it downloads files.
	-b continues wget after logging out.
	-o $HOME/wget_log.txt logs the output
