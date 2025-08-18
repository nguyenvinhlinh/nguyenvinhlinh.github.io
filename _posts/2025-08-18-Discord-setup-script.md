---
layout: post
title: "Discord setup script"
date: 2025-08-18 13:39:11
update:
location:
tags:
- linux
- discord
categories: Linux
seo_description: Setup discord for each update should be easy. This post helps you save 1 minute.
seo_image: /image/posts/2025-08-18-Discord-setup-script/seo.png
comments: true
---

I am tired downloading Discord `discord.tar.gz` and setup manually. This post is all about doing it automatically!

{% highlight sh %}
#!/bin/zsh
discord_setup() {
    DISCORD_DIRECTORY=/home/nguyenvinhlinh/Software/Discord # change it to yours
    echo "Create directory $DISCORD_DIRECTORY"
    mkdir -p $DISCORD_DIRECTORY;
    echo "Remove temporary files: /tmp/discord.tar.gz"
    /usr/bin/rm -rf /tmp/discord.tar.gz;
    echo "Remove temporary files: /tmp/Discord/"
    /usr/bin/rm -rf /tmp/Discord/;
    echo "Remove old discord files: $DISCORD_DIRECTORY/*"
    /usr/bin/rm -rf /home/nguyenvinhlinh/Software/Discord/*;
    echo "Download discord and save to /tmp/discord.tar.gz";
    wget -O /tmp/discord.tar.gz "https://discord.com/api/download?platform=linux&format=tar.gz"
    echo "Extract discord.tar.gz to /tmp/Discord"
    tar -xf /tmp/discord.tar.gz --directory /tmp/;
    echo "Copy new Discord files to $DISCORD_DIRECTORY/"
    cp -r /tmp/Discord/* /home/nguyenvinhlinh/Software/Discord/;
}
{% endhighlight %}

Then, when you want to update your **Discord**, you can open your terminal and execute `discord_setup`.

Good luck!
