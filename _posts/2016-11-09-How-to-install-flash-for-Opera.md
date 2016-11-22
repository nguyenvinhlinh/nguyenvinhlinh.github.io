---
layout: post
title: How to install Flash for Opera manually
date: 2016-11-09 19:43:15 +0700
categories: etc
tag: tweak, opera, fedora
comments: true
---
Since the documentation of Opera has been out of date, this article is all about installing flash plugin manually, I strongly believe that this can help you in any version of Opera or any operating system. In my free time, I have spent time researching on the resouce files of Opera and trace the directory that Opera use to read the `flashplayer.so`.

{% highlight shell %}
$ cat /lib64/opera-developer/resources/pepper_flash_config.json

{
  "PepperFlashPaths" : [
    "/usr/lib/adobe-flashplugin/libpepflashplayer.so",
    "/usr/lib/pepperflashplugin-nonfree/libpepflashplayer.so",
    "/usr/lib/PepperFlash/libpepflashplayer.so",
    "/usr/lib64/PepperFlash/libpepflashplayer.so",
    "/usr/lib/chromium-browser/PepperFlash/libpepflashplayer.so",
    "/usr/lib/chromium/PepperFlash/libpepflashplayer.so",
    "/usr/lib64/chromium-browser/PepperFlash/libpepflashplayer.so",
    "/usr/lib64/chromium/PepperFlash/libpepflashplayer.so",
    "/opt/google/chrome-beta/PepperFlash/libpepflashplayer.so",
    "/opt/google/chrome-unstable/PepperFlash/libpepflashplayer.so",
    "/opt/google/chrome/PepperFlash/libpepflashplayer.so"
  ]
}

{% endhighlight %}

As you can guess, we gonna download flash plugin from its [official site](https://get.adobe.com/flashplayer/) then extract into any of these directory such as `/usr/lib/adobe-flashplugin/`. Remember to set extracted files with appropriate permission `(chmod command)`.