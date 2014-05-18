---
layout: page
title:	
category: blog
description: 
---
# Preface

# rsync
service
rsync --daemon --config=/etc/rsync/rsyncd_8875.conf --port=8875
## include
Just change your include pattern adding a trailing / at the end of include pattern and it'll work:

	rsync -avz --delete --include=specs/install/project1/ \
    --exclude=specs/* /srv/http/projects/project/ \
    user@server.com:~/projects/project

Or, in alternative, prepare a filter file like this:

	$ cat << EOF >pattern.txt
	> + specs/install/project1/
	> - specs/*
	> EOF

Then use the --filter option:

	rsync -avz --delete --filter=". pattern.txt" \
    /srv/http/projects/project/ \
    user@server.com:~/projects/project

For More: search RULES in man rsync

# ftp
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf #chroot_local_user=YES listen=YES use_localtime=YES


