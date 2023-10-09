---
layout: post
title: "Rigel, mining ALPH script"
date: 2023-10-09 20:47:48
update:
location: Saigon
tags:
- mining
- alph
- 3080
categories:
- Mining Rig
seo_description:
seo_image:
comments: true
---

Miner Software: Rigel\
Version: 1.9.1\
Link: [https://github.com/rigelminer/rigel](https://github.com/rigelminer/rigel)\
Gear: Nvidia 3080

Keynote:
- `--temp-limit tc[60-65]`: Set temperature limit for GPU core to max 65. mining will be back when temperature is 60.
- `--lock-cclock X`: Reset GPU core clock, no config, leave it stock config.
- `--lock-mclock 810`: Set GPU memory clock to 810Mhz
- `--pl 160`: Set power limit to 160W
- `--fan-control 85`: Set fan speed to 85%


{% highlight bat %}
@echo off
@cd /d "%~dp0"

rigel.exe -a alephium -o stratum+tcp://as.pool.metapool.tech:20032 -u ALPH_ADDRESS_HERE ^
          -w SON_TINH --temp-limit tc[60-65]  --lock-cclock X --lock-mclock 810 --pl 160 --fan-control 85 ^
          --log-file logs/miner.log
pause
{% endhighlight %}

{% include image.html url="/image/posts/2023-10-09-Rigel-mining-ALPH-script/1.png" description="Rigel, mining ALPH 3080" %}
