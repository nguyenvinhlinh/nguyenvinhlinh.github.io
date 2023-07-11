---
layout: post
title: "Run gnome-terminal and open new program"
date: 2014-10-14 21:55:37 +0700
categories: Linux
tags: gnome-terminal, linux
---
This is script which open a new `gnome-terminal` window and automatically run,
execute program on this gnome-terminal.
{% highlight bash %}
gnome-terminal  -x zsh -c "echo hello;pwd;whoami;zsh"
{% endhighlight  %}

The workflow of this script is:
{% highlight text %}
1. Open new gnome-terminal
2. execute command `echo hello`
3. execute command `pwd`
4. execute command `whoami`
5. execute command `zsh`
{% endhighlight %}

!!!NOTE: THE END OF EXECUTE SENTENCE SHOULD END WITH `zsh`
