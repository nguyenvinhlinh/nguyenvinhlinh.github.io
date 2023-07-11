---
layout: post
title: "How to create an application shortcut on Fedora?"
date:   2020-10-12 15:35:39 +0700
update: 2023-06-06 09:42:00 +0700
tags: Linux, Gnome, Fedora
categories: Linux
---

Inside `$HOME`, there is a directory named `~/.local/share/applications` which containts all application shortcuts for the `current user`.
To make a new application shortcut you need to make a new file named `*.desktop` with the following schema.

{% highlight txt %}
[Desktop Entry]
Type=Application
Name=Postman
Comment=Postman
Icon=/home/nguyenvinhlinh/Software/Postman-7.0.9/icon.png
Path=/home/nguyenvinhlinh/Software/Postman-7.0.9
Exec=/home/nguyenvinhlinh/Software/Postman-7.0.9/Postman
Terminal=false
Categories=Development;
{% endhighlight %}

To refresh/update `application.desktop`, you can use the following command:
{% highlight sh %}
update-desktop-database ~/.local/share/applications
{% endhighlight %}

If it all works correctly, a new application shortcut will be displayed on Gnome Search.
{% include image.html url="/image/posts/2020-10-12-How-to-create-application-shortcut-on-Fedora/1.png" description="[1] GNOME Search" %}
