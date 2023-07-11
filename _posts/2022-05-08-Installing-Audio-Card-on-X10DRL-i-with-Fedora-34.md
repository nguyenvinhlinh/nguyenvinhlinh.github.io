---
layout: post
title: "Installing an Audio Card - CMI8738 on X10DRL-i with Fedora 34"
date: 2022-05-08 12:30:17 +0700
update:
location: Saigon
tags:
- Linux
- Audio Card
- X10DRL-i
- CMI8738
categories: Linux
seo_description: Installing an Audio Card - CMI8738 on X10DRL-i with Fedora 34
seo_image: /image/posts/2022-05-08-Installing-Audio-Card-on-X10DRL-i-with-Fedora-34/2.jpg
comments: true
---

I am the owner of  a motherboard named **X10DRL-i** from **Supermicro**. Regarding its specification,
there is no audio component on this motherboard which means that I cannot listen to music or do voice
call.

Of course, there are few tricks to output/input audio via USB components however it’s not a method
that I would like to use in long term.

I really don’t want to waste an USB socket on this motherboard.

First of all, this is the motherboard layout that I rererence from [Supermicro](https://www.supermicro.com/en/products/motherboard/X10DRL-i).

{% include image.html url="/image/posts/2022-05-08-Installing-Audio-Card-on-X10DRL-i-with-Fedora-34/1.png" description="[1] Supermicro X10DRL-i" %}

And this is the the audio card [**Cmedia CMI8738**](https://www.cmedia.com.tw/products/EOL_PRODUCTS/CMI8738-MX),
this audio card has reached its end of life. I bought it from [Shopee](https://shopee.vn/CARD-%C3%82M-THANH-CARD-SOUND-PCI-EXPRESS-1X-PC(PCI-Express-to-Sound-5.1)-i.10383705.4577157409).

{% include image.html url="/image/posts/2022-05-08-Installing-Audio-Card-on-X10DRL-i-with-Fedora-34/2.jpg" description="[2] Audio Card - Cmedia CMI8738" %}

Right now, I am using a **NVIDIA GeForce GTX 1060 6GB**, as a consequence, I cannot test `CPU 1 SLOT 5 PCI-E 3.0 X16`
socket on the motherboard. Meanwhile, after testing all available sockets, **there is only one socket
which works, it’s** `PCH SLOT 1 PCI-E 2.0`.

`lspci` gives more information.

{% highlight sh %}
$ lspci -nnk | grep -A3 Audio

08:00.0 Multimedia audio controller [0401]: C-Media Electronics Inc CMI8738/CMI8768 PCI Audio [13f6:0111] (rev 10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device [13f6:0111]
        Kernel driver in use: snd_cmipci
        Kernel modules: snd_cmipci
{% endhighlight %}

**Other failed tests lead to an unknown conflict with Graphic Card. A dark blank screen with flashing cursor.**

After installing the audio card on `PCH SLOT 1 PCI-E 2.0`. I have tested the `Pink Socket - Mic In` and
`Green Socket - Front Out`. They all works flawlessly.
Of course, it’s a must to configure an audio setting on Fedora 34, this is my audio setting.

{% include image.html url="/image/posts/2022-05-08-Installing-Audio-Card-on-X10DRL-i-with-Fedora-34/3.png" description="[3] Audio Settings " %}

In case, you wonder my server specification:
- OS: Fedora 34 (Workstation Edition) x8
- Kernel: 5.17.5-100.fc34.x86_64
- Desktop Environment: GNOME 40.9
- CPU: Intel Xeon E5-2680 v4 (56) @ 3.300GHz
- GPU: NVIDIA GeForce GTX 1060 6GB

References:
- Supermicro X10DRL-i motherboard, [https://www.supermicro.com/en/products/motherboard/X10DRL-i](https://www.supermicro.com/en/products/motherboard/X10DRL-i)
- Cmedia CMI8738 Audio Card, [https://www.cmedia.com.tw/products/EOL_PRODUCTS/CMI8738-MX](https://www.cmedia.com.tw/products/EOL_PRODUCTS/CMI8738-MX)
- CARD ÂM THANH -CARD SOUND PCI EXPRESS 1X PC(PCI Express to Sound 5.1), [https://shopee.vn/CARD-%C3%82M-THANH-CARD-SOUND-PCI-EXPRESS-1X-PC(PCI-Express-to-Sound-5.1)-i.10383705.4577157409](https://shopee.vn/CARD-%C3%82M-THANH-CARD-SOUND-PCI-EXPRESS-1X-PC(PCI-Express-to-Sound-5.1)-i.10383705.4577157409)
