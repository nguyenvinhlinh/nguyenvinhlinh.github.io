---
layout: post
title: "How to block suspend/hibernate/sleep on Fedora?"
date: 2025-04-16 16:04:52
update:
location: Saigon
tags:
categories:
- Linux
seo_description: Blocking suspend/hibernate/sleep on Fedora!
seo_image:
comments: true
---

Execute the following command to block Fedora going to suspend/hibernate/sleep mode

{% highlight sh %}
systemctl mask sleep.target;
systemctl mask hibernate.target;
systemctl mask sleep.target;
systemctl mask hybrid-sleep.target;
{% endhighlight %}
