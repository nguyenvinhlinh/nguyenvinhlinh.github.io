---
layout: post
title: "How to fix csgo_linux64 has stopped working"
date: 2023-05-01 23:04:11
update:
location: Saigon
tags:
- csgo
- Linux
categories:
- csgo
seo_description: How to fix csgo_linux64 has stopped working
seo_image:
comments: true
---
Sometimes, playing CSGO on Fedora (Gnome) give you this message.
{% highlight shell %}
csgo_linux64 has stopped working
{% endhighlight %}

It's because GNOME detects `csgo_linux64` process unresponsive. You can fix this issue by setting the timeout to 0, by default, it's `5000` milliseconds.
{% highlight shell %}
gsettings set org.gnome.mutter check-alive-timeout 0
{% endhighlight %}
