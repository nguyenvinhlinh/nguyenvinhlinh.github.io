---
layout: post
title: Chrome, Firefox, Conkeror redirecting to advertise websites
date: 2015-09-01 15:02:43 +0700
categories: etc
tag: firefox, chrome, conkeror, dns
---

My browsers always automatically redirect to advertise website. That's a pain in
my ass. In particular, While I am reading software API, it change my current
pages to another ad pages. Seemingly, someone did change my default dns to
advertise dns server.

**1. Change the DNS**
Set the current dns to google dns: `8.8.8.8`, `8.8.4.4`

**2. Reset the Network Manager**
{% highlight bash %}
sudo systemclt restart NetworkManager
{% endhighlight %}

After finished this step, firefox should work well

**3. Remove cache in Google Chrome**
{% highlight bash %}
## Go to ~/.cache/google-chrome
cd ~/.cache/google-chrome/Default
## remove file in Cache directory
rm Cache/*
## remove file in Media Cache directory
rm Media\ Cache/*
{% endhighlight %}

**4. Remove cached in Conkeror**
{% highlight bash %}
## move to dir of conkeror cache
cd ~/.cache/conkeror.mozdev.org/conkeror
## remove all cached
rm -rf *
{% endhighlight %}
