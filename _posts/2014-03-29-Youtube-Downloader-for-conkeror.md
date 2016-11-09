---
layout: post
title: "Youtube video downloader for Conkeror"
date: 2014-03-29 15:55:37
categories: Conkeror
tag: Conkeror, Youtube, downloader, grabber, fedora
---
I am now introducing a simple way to download video from Youtube by conkeror and an extra terminal program name `cclive`. This program take role to catch the link of youtube video and download it to assigned directory. In addition, you can choose type of video to download, of course, it also depends on the source.However, I am not going to further to that point.

What you need is: `cclive`, `conkeror-spawn-helper`
Firstly, you need to install `cclive`. if you are using Fedora, you can install it by this simple command on the terminal.

{% highlight bash%}
sudo yum install cclive -y
{% endhighlight %}

Then, you open your conkeror file init.js, and append it with  the following lines

{% highlight javascript%}
//download video from youtube using cclive
interactive("download-video-2-music","Download current playing video.",
			function(I){
			  var path = I.buffer.current_uri.path;
			  path = path.substr(9,30);
   			  I.minibuffer.message("Downloading video to folder Music ");
			  shell_command_blind("cclive -d /home/nguyenvinhlinh/Music \"https://www.
			  							  youtube.com/watch?v=\""+ path);
			});

interactive("download-video-2-downloads","Download current playing video.",
			function(I){
			  var path = I.buffer.current_uri.path;
			  path = path.substr(9,30);
			  I.minibuffer.message("Downloading video to folder Downloads");
			  shell_command_blind("cclive -d /home/nguyenvinhlinh/Downloads \"https:
			  							  	 //www.youtube.com/watch?v=\""+ path);
			});

{% endhighlight %}

You can active these functions by `M-x download-video-2-download`, `M-x download-video-2-music` or assign these function to hot keys, for example:

{% highlight javascript%}
define_key(default_global_keymap, "C-M", "download-video-2-music" );
define_key(default_global_keymap, "C-D", "download-video-2-downloads" );
{% endhighlight %}
