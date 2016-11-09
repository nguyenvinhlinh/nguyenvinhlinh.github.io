---
layout: post
title: Tweak to ssh quickly any server
date: 2016-01-24 23:39:50
categories: tweak
tag: ssh
--- 

To ssh to server, I used to type `ssh --flags`, the command line too long and replication. Here is a solution reduce the pain.  

Go to file `~/.ssh/config`, and add the following configuration. If the file is not exist, you can make a new one. 

{% highlight text %}
Host server-dev1
Hostname  xxx.xxx.xxx.xxx
Port 1022
User nguyenvinhlinh

Host server-dev2
Hostname  xxx.xxx.xxx.xxx
Port 1023
User nguyenhoangson
{% endhighlight %}

Right after that, you can use ssh with server alias name.
{% highlight bash %}
$ ssh server-dev1
$ ssh server-dev2
{% endhighlight %}
