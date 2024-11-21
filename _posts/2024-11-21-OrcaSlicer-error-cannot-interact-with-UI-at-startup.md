---
layout: post
title: "OrcaSlicer error, cannot interact with UI at startup"
date: 2024-11-21 23:17:21
update:
location: Saigon
tags:
- 3D print
- OrcaSlicer
categories:
- 3D Print
seo_description: OrcaSlicer error due to webkit composition mode!
seo_image: /image/posts/2024-11-21-OrcaSlicer-error-cannot-interact-with-UI-at-startup/seo.png
comments: true
---

I have seen this problem using [OrcaSlicer V2.2.0 Official Release](https://github.com/SoftFever/OrcaSlicer/releases/tag/v2.2.0) on `Fedora 39`. Even though, I clone the source code and build `AppImage` myself. this issue still happens.

The main solution to this problem is to **disable webkit composition mode** before executing `OrcaSlicer`.

{% highlight sh %}
$ export WEBKIT_DISABLE_COMPOSITING_MODE=1
$ ./OrcaSlicer_Linux_V2.3.0-dev.AppImage
{% endhighlight %}


This is a screenshot prove that this solution does work.

{% include image.html url="/image/posts/2024-11-21-OrcaSlicer-error-cannot-interact-with-UI-at-startup/1.png" description="OrcaSlicer is running on Fedora 39" %}
