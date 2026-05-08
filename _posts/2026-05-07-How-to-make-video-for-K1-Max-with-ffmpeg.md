---
layout: post
title: "How to record video for K1 Max with ffmpeg?"
date: 2026-05-07 22:49:46
update:
location: Saigon
tags:
- 3dprint
- k1max
- ffmpeg
- mjpg
categories:
- 3D Print
seo_description: Recording video from K1 Max 3D printer
seo_image: /image/posts/2026-05-07-How-to-make-video-for-K1-Max-with-ffmpeg/seo.jpg
comments: true
---

## Step 1: Find K1 Max livestream url

- stream: `http://K1_MAX_IP:8080/?action=stream`
- snapshot: `http://K1_MAX_IP:8080/?action=snapshot`

For more details, go to `http://K1_MAX_IP:8080`

## Step 2: Use ffmpeg command to take stream input (mjpg) and create video
I use encoder `libvpx-vp9` to create

```sh
ffmpeg -i http://K1_MAX_IP:8080/?action=stream \
       -c:v libvpx-vp9 -vf fps=12 \
       -crf 30 -b:v 0 \
       -f segment \
       -segment_time 3600 \
       -reset_timestamps 1 \
       -strftime 1 \
       "%Y-%m-%dT%H%M%S.webm"
```

- `-c:v`: Use video encoder named `libvpx-vp9`
- `fps=12`: Use 12 frame per second for output video
- `-crf 30`: Constant Rate Factor. It refers to video quality. `0` means the best quality, `40+` means super compressed, worse quality. (tbh, I only test `Constant Rate Factor 30`)
- `-b:v 0`: Do not configure fixed video bitrate.
- `-f segment -segment_time 3600`: For each one hour, create a video file.
- `-reset_timestamps 1`: when create video, start timestamps at 1 (by default, it starts from the end timestamps of previous video)
- `-strftime 1 "%Y-%m-%dT%H%M%S.webm"`: Output with filename format.

## Credit
ChatGPT helps me so much with `ffmpeg`, without it, I can't understand all the `ffmpeg` options quickyly.
