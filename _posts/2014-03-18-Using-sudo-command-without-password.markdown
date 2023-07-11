---
layout: post
title: "Using command 'sudo' without password"
date: 2014-03-18 22:25:37 +0700
categories: Linux
tag: Linux, Fedora, GNOME, sudores, UNIX
---

In the daily work, I may have to type `sudo your_command` and your password many times, it costs your time, in my case, it makes me feel crazy. The solution is that, you will add command which you mostly type into a list, then, when you want to type it with prefix `sudo` it wont ask you for password.

You have to modify file `sudoers` in `/etc/sudoers`. For example, you want to
run command such as "yum", "apachectl" without passwor

#1. Find the path of those commands by using command `which`
in this case, those commands locates in `/usr/sbin/apachectl` and `/usr/bin/yum`.

#2. Modify file `sudoers`

{% highlight bash %}
username ALL=(ALL) NOPASSWD = /usr/sbin/apachectl, /usr/bin/yum
{% endhighlight %}

Now, you can run those command without password, **REMEMBER, You still need prefix `sudo`**

Command Alias, this feature will help you save your time if you want to assign group of command, for example, you have 2,3 user or group, it should be not convenient to type similar commands many times. Now, what you have to do is group them all, then use the command alias instead!

{% highlight bash %}
Cmmd_Alias CommandAliasName = /pathToCommand1, /pathToCommand2, /pathToCommand3
username1 ALL=(ALL) NOPASSWD = CommandAliasName
username2 ALL=(ALL) NOPASSWD = CommandAliasName
{% endhighlight%}
