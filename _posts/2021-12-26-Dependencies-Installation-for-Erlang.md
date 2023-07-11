---
layout: post
title: "ASDF, Dependencies Installation for Erlang"
date: 2021-12-26 22:59:24 +0700
tags:
- erlang
- asdf
categories:
- Linux
seo_description: ASDF, Dependencies installation for Erlang
seo_image: /image/posts/2021-12-26-Dependencies-Installation-for-Erlang/1.png
comments: true
---

This script should be run before `asdf` erlang installation.

{% highlight zsh %}
#!/usr/bin/zsh
sudo yum groupinstall -y 'Development Tools' 'C Development Tools and Libraries';
sudo yum install -y autoconf;
sudo yum install -y ncurses-devel;
sudo yum install -y wxGTK3-devel wxBase3;
sudo yum install -y openssl-devel;
sudo yum install -y java-1.8.0-openjdk-devel;
sudo yum install -y libiodbc unixODBC-devel.x86_64 erlang-odbc.x86_64;
sudo yum install -y libxslt fop;
{% endhighlight %}

After executing the script above, you can run `asdf install erlang YOUR_ERLANG_VERSION` without a missing erlang features.

{% include image.html url="/image/posts/2021-12-26-Dependencies-Installation-for-Erlang/1.png" description="[1] Example, asdf install erlang 22.3" %}
