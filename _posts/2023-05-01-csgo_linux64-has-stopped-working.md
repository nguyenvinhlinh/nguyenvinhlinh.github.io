---
layout: post
title: "How to fix csgo_linux64 has stopped working"
date: 2023-05-01 23:04:11
update:
location: Saigon
tags:
- csgo
- linux
categories:
- CSGO
seo_description: How to fix csgo_linux64 has stopped working
seo_image: /image/posts/2023-05-01-csgo_linux64-has-stopped-working/1.png
comments: true
---
Sometimes, playing CSGO on Fedora (Gnome) gives you this message.

{% include image.html url="/image/posts/2023-05-01-csgo_linux64-has-stopped-working/1.png" description="csgo_linux64 has stopped working"  %}

It's because GNOME detects `csgo_linux64` process unresponsive. You can fix this issue by setting the timeout to 0, by default, it's `5000` milliseconds.
{% highlight shell %}
$ gsettings set org.gnome.mutter check-alive-timeout 0
{% endhighlight %}
