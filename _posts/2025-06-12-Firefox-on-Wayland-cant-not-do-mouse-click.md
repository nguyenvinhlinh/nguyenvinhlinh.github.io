---
layout: post
title: "Firefox on Wayland, can't not do mouse click"
date: 2025-06-12 11:14:05
update:
location: Saigon
tags:
- linux
- firefox
- wayland
- fedora
categories: Linux
seo_description: No mouse click on UI? This trick'll help you run Firefox smoothly with Wayland, Fedora.
seo_image: /image/posts/2025-06-12-Firefox-on-Wayland-cant-not-do-mouse-click/seo.png
comments: true
---

Hi, I am running Firefox on Fedora 41, my display manager is wayland by default. While using Firefox, sometime, I
can't do `mouse click` on Firefox. This post will help you save 5 minutes.

First of all, the key point here is environment variable `MOZ_ENABLE_WAYLAND=1`. We need it before running firefox.

You can test by running this command. If it works, you can read futher, else, stop wasting your time reading my post.

```shell
$ export MOZ_ENABLE_WAYLAND=1
$ firefox
```

I assume that you have play with your firefox smoothly. Now, we will edit `.desktop` file. So what is it?
it's a application shortcut for GNOME. You can find it `/usr/share/applications`.

```shell
$ ll /usr/share/applications  | grep firefox
-rw-r--r--. 1 root root 9.4K Jun 12 11:16 org.mozilla.firefox.desktop
```

Now, edit `/usr/share/applications/org.mozilla.firefox.desktop`, add `env MOZ_ENABLE_WAYLAND=1` on `Exec=` line.
Remember that there are many places need to update.

Example:
```shell
# Before
Exec=firefox %u

# After
Exec=env MOZ_ENABLE_WAYLAND=1 firefox %u
```

Done, and good luck!

# References:
- Enabling Wayland on Linux, [https://www.reddit.com/r/firefox/comments/c8itj2/enabling_wayland_on_linux/](https://www.reddit.com/r/firefox/comments/c8itj2/enabling_wayland_on_linux/)
