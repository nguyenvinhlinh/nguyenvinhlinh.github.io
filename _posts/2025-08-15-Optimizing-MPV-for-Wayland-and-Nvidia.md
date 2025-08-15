---
layout: post
title: "Optimizing MPV for Wayland and Nvidia"
date: 2025-08-15 16:13:10
update:
location: Saigon
tags:
- Linux
- Wayland
- Nvidia
categories: Linux
seo_description: Playing video with MPV is worse than Google Chrome on Fedora 42, Wayland. This post optimizes mpv's flags while playing video.
seo_image: /image/posts/2025-08-15-Optimizing-MPV-for-Wayland-and-Nvidia/seo.png
comments: true
---

## I. What is it?
[MPV](https://github.com/mpv-player/mpv) is my favorite open source media player. On Fedora 42, the default display manager
is Wayland (as a replacement for X11). MPV does not play well with **Wayland**, playing videos is delay/lagging.
In addition, I am using an NVIDIA graphic card 3080. it could be a reason that my video playing is delay.

This post is all about customize mpv's flags to work with Wayland and NVIDIA graphic card.


## II. How to do?
Go to `~/.local/share/applications` and create a new file named `mpvfast.desktop`.

{% highlight text %}
[Desktop Entry]
Type=Application
Name=mpv (Fast Mode)
Exec=mpv --gpu-context=wayland -vo=gpu --video-sync=display-resample --profile=gpu-hq --hwdec=auto --demuxer-max-bytes=8G %U
Icon=mpv
Terminal=false
Categories=AudioVideo;Player;Video;
MimeType=video/x-matroska;video/mp4;video/x-msvideo;video/webm;audio/mpeg;audio/x-flac;audio/x-wav;
{% endhighlight %}

- `--gpu-context=wayland`: Tells mpv to create its GPU rendering context using Wayland APIs instead of X11, SDL, or other backends.
- `-vo=gpu`: select GPU as video output
- `--video-sync=display-resample`: Syncs video playback to the display refresh rate and dynamically resamples audio to keep A/V in perfect sync.
- `--profile=gpu-hq`: GPU high quality — enables higher-quality scaling algorithms
- `--hwdec=auto`: Enables automatic hardware video decoding if available.
- `--demuxer-max-bytes=8G`: The demuxer buffer is where mpv stores pre-read data from a file/network before decoding.

Then execute `update-desktop-database` to update desktop.

``` sh
$ update-desktop-database ~/.local/share/applications
```

## III. Credit
Thank for ChatGPT, it helps me so much! I can't understand all **1250 options of MPV**.
