---
layout: post
title: "How to install Talend Open Studio on Fedora 37, 38?"
date: 2023-05-08 16:29:58
update:
location: Saigon
tags:
- Talend Open Studio
categories:
- Talend Open Studio
seo_description: How to install Talend Open Studio on Fedora 37?
seo_image: /image/posts/2023-05-08-How-to-install-Talend-Open-Studio-on-Fedora-38/3.png
comments: true
---

# Step 1: Install `java-11-openjdk`
Due to Talend Open Studio prerequisites [link](https://help.talend.com/r/en-US/8.0/installation-guide-linux/compatible-java-environments), we need to install `OpenJDK 11 (recommended distribution: Zulu)` or `OracleJDK 11`.
In this tutorial, I used `OpenJDK 11` provided by **Fedora package repository**.
{% include image.html url="/image/posts/2023-05-08-How-to-install-Talend-Open-Studio-on-Fedora-38/1.png" description="[1] Talend Open Studio prerequisites" %}


Package information:
{% highlight sh %}
$ sudo dnf info java-11-openjdk

Installed Packages
Name         : java-11-openjdk
Epoch        : 1
Version      : 11.0.18.0.10
Release      : 1.fc37
Architecture : x86_64
Size         : 1.2 M
Source       : java-11-openjdk-11.0.18.0.10-1.fc37.src.rpm
Repository   : @System
From repo    : updates
Summary      : OpenJDK 11 Runtime Environment
URL          : http://openjdk.java.net/
License      : ASL 1.1 and ASL 2.0 and BSD and BSD with advertising and GPL+ and GPLv2 and
               GPLv2 with exceptions and IJG and LGPLv2+ and MIT and MPLv2.0 and Public
               Domain and W3C and zlib and ISC and FTL and RSA
Description  : The OpenJDK 11 runtime environment.
{% endhighlight %}

Package installation:
{% highlight sh %}
$ sudo dnf install java-11-openjdk
{% endhighlight %}

# Step 2: Setup `java` with `alternatives` command
In this step, we use command `alternatives` to set java version systemwide, `java-11-openjdk.x86_64` is selected with option 3.

{% highlight sh %}
sudo alternatives --config java

There are 3 programs which provide 'java'.

  Selection    Command
-----------------------------------------------
*  1           java-17-openjdk.x86_64 (/usr/lib/jvm/java-17-openjdk-17.0.6.0.10-1.fc37.x86_64/bin/java)
   2           java-1.8.0-openjdk.x86_64 (/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.362.b09-2.fc37.x86_64/jre/bin/java)
 + 3           java-11-openjdk.x86_64 (/usr/lib/jvm/java-11-openjdk-11.0.18.0.10-1.fc37.x86_64/bin/java)

Enter to keep the current selection[+], or type selection number: 3

{% endhighlight %}

# Step 3: Set `JAVA_HOME`
I used shell named `zsh`, I will configure `JAVA_HOME` in `.zshrc` file which located in `~/.zshrc`. If you use `bash`, you will need
to configure `.bashrc`. You can trace the java home path using `alternatives` in Step 2. For me, the value is `/usr/lib/jvm/java-11-openjdk-11.0.18.0.10-1.fc37.x86_64`

{% highlight sh %}
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-11.0.18.0.10-1.fc37.x86_64
{% endhighlight %}

# Step 4: Download, Extract and Execute **Talend Open Studio**
After download **Talend Open Studio** `TOS_DI-20211109_1610-V8.0.1.zip`, and extract, you gonna see a list of file & directory.
{% highlight sh %}

$ ls -l
total 280
drwxr-xr-x. 1    136 Aug 26  2014 about_files
drwxr-xr-x. 1    660 May  8 17:00 configuration
drwxr-xr-x. 1   7170 Nov  9  2021 features
-rwxr-xr-x. 1    605 Nov  9  2021 license.txt
-rwxr-xr-x. 1  11840 Nov  9  2021 NOTICE.txt
drwxr-xr-x. 1    112 Nov  9  2021 p2
drwxr-xr-x. 1  59446 Nov  9  2021 plugins
drwxr-xr-x. 1      0 May  8 16:26 temp
-rwxr-xr-x. 1  80160 Jun 11  2021 TOS_DI-linux-gtk-aarch64
-rwxr-xr-x. 1    259 Nov  9  2021 TOS_DI-linux-gtk-aarch64.ini
-rwxr-xr-x. 1  74675 Aug 20  2014 TOS_DI-linux-gtk-x86_64
-rwxr-xr-x. 1    259 Nov  9  2021 TOS_DI-linux-gtk-x86_64.ini
drwxr-xr-x. 1     16 Oct 29  2021 TOS_DI-macosx-cocoa-aarch64.app
drwxr-xr-x. 1     16 Oct 29  2021 TOS_DI-macosx-cocoa.app
-rwxr-xr-x. 1    410 Nov  9  2021 TOS_DI-macosx-cocoa.ini
-rwxr-xr-x. 1  91512 Aug 19  2021 TOS_DI-win-x86_64.exe
-rwxr-xr-x. 1    259 Nov  9  2021 TOS_DI-win-x86_64.ini
drwxr-xr-x. 1     76 May  8 16:27 workspace
{% endhighlight %}

You need to execute this file named `TOS_DI-linux-gtk-x86_64` and done. Good luck.
{% include image.html url="/image/posts/2023-05-08-How-to-install-Talend-Open-Studio-on-Fedora-38/2.png" description="[2] Open Talend Open Studio" %}
