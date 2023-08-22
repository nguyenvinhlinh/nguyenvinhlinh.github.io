---
layout: post
title: "How to change DBeaver's heap size?"
date: 2023-08-22 21:10:36
update:
location: Saigon
tags:
- DBeaver
- Fedora
- rpm
categories: etc
seo_description:
seo_image: /image/posts/2023-08-22-How-to-change-DBeaver-heap-size/1.png
comments: true
---

Edit `/usr/share/dbeaver-ce/dbeaver.ini`, change the `-Xms` and `-Xmx`. In the example belows, check line **20** and **21**.
- `-Xms`: It is used for setting the initial and minimum heap size. I set to **1GB**.
- `-Xmx`: It is used for setting the maximum heap size. I set to **6GB**.


{% highlight sh linenos %}
-vmargs
-XX:+IgnoreUnrecognizedVMOptions
-Dosgi.requiredJavaVersion=17
--add-modules=ALL-SYSTEM
--add-opens=java.base/java.io=ALL-UNNAMED
--add-opens=java.base/java.lang=ALL-UNNAMED
--add-opens=java.base/java.lang.reflect=ALL-UNNAMED
--add-opens=java.base/java.net=ALL-UNNAMED
--add-opens=java.base/java.nio=ALL-UNNAMED
--add-opens=java.base/java.nio.charset=ALL-UNNAMED
--add-opens=java.base/java.text=ALL-UNNAMED
--add-opens=java.base/java.time=ALL-UNNAMED
--add-opens=java.base/java.util=ALL-UNNAMED
--add-opens=java.base/java.util.concurrent=ALL-UNNAMED
--add-opens=java.base/java.util.concurrent.atomic=ALL-UNNAMED
--add-opens=java.base/jdk.internal.vm=ALL-UNNAMED
--add-opens=java.base/sun.nio.ch=ALL-UNNAMED
--add-opens=java.base/sun.security.ssl=ALL-UNNAMED
--add-opens=java.base/sun.security.util=ALL-UNNAMED
-Xms1G
-Xmx6G
-Ddbeaver.distribution.type=rpm

{% endhighlight %}
