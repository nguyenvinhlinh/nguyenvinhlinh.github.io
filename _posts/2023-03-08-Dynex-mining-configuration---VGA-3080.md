---
layout: post
title: "Dynex mining configuration - VGA 3080"
date: 2023-03-08 15:09:31
update:
location: Saigon
tags:
- mining
- dynex
categories:
- Mining Rig
seo_description: Dynex mining configuration & overclock for VGA 3080.
seo_image:
comments: true
---

## Running bat script - `run.bat`
{% highlight bat %}
:loop
C:\Users\CHANGE_ME\Desktop\Software\dynexsolve_windows2.2.5\DynexSolveVS.225.exe ^
  -mallob-endpoint https://dnx.sg.ekapool.com ^
  -mining-address WALLET_ADDRESS ^
  -stratum-url POOL_URL -stratum-port POOL_PORT -no-cpu -multi-gpu ^
  -stratum-password WORKER_NAME -adj 1.0898 -sync
goto loop
:exitloop
{% endhighlight %}

## Nvidia Overclock script - `oc.bat`
- Locked GPU Clock: 1760MHz
- Locked Memory Clock: 5000MHz
- Power Limit: 135W

{% highlight bat %}
nvidia-smi -lgc 1760
nvidia-smi -lmc 5000
nvidia-smi -pl 135
{% endhighlight %}

## Result
- Hashrate for a 3080 GPU: 240H/s
- Power Consumption: 115W
- Temperature: 46C
- Dynex chips: 334

{% include image.html url="/image/posts/2023-03-08-Dynex-mining-configuration---VGA-3080/1.png" description="Dynex Solver 2.2.5" %}
