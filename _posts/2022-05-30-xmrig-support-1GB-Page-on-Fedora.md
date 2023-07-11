---
layout: post
title: "XMRig, Support 1GB Page on Fedora"
date: 2022-05-30 21:08:02 +0700
update:
location: Saigon
tags:
- Linux
- Mining Rig
- Monero
categories:
- Mining Rig
seo_description: XMRig, Support 1GB Page on Fedora
seo_image: /image/posts/2022-05-30-xmrig-support-1GB-Page-on-Fedora/1.png
comments: true
---

By default, running **xmrig** to mine Monero will got `1GB PAGES` disabled eventhough `config.json` has been configured.

{% include image.html url="/image/posts/2022-05-30-xmrig-support-1GB-Page-on-Fedora/1.png" description="[1] XMRig without 1GB pages supported." %}

While running xmrig, you can caught the following log.

{% highlight text  %}
[2021-03-15 15:14:59.732]  randomx  failed to allocate RandomX dataset using 1GB pages
{% endhighlight %}

The solution is to edit grub file located at `/etc/default/grub` with the  following config:

{% highlight text %}
GRUB_CMDLINE_LINUX_DEFAULT="hugepagesz=1G hugepages=3"
{% endhighlight %}

Then, update `grub.cfg` with this command and do reboot.

{% highlight sh %}
grub2-mkconfig -o /boot/grub2/grub.cfg
{% endhighlight %}

Finally, run your `xmrig` with sudo and enjoy!

{% include image.html url="/image/posts/2022-05-30-xmrig-support-1GB-Page-on-Fedora/2.png" description="[2] XMRig with 1GB pages supported." %}
