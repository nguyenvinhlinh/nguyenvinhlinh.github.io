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

## 1. Running bat script - `run.bat`
### a. Dynex Solver 2.2.5
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

Example:
{% highlight bat %}
:loop
C:\Users\LacLongQuan\Desktop\Software\dynexsolve_windows2.2.5\DynexSolveVS.225.exe ^
  -mallob-endpoint https://dnx.sg.ekapool.com ^
  -mining-address XwnTnXV7cSEQszHqM3xihWZp6MiP6n8vqggLFH15VMEBDnpkBKnv1Cz7wn5L18uVrwMDFhdhB2fV3fSTZ7MexKDJ1ZgGx9ZCC ^
  -stratum-url dnx.sg.ekapool.com -stratum-port 19666 -no-cpu -multi-gpu ^
  -stratum-password LAC-LONG-QUAN -adj 1.0898 -sync
goto loop
:exitloop
{% endhighlight %}

### b. SRBMiner 2.2.1
{% highlight bat %}
SRBMiner-MULTI.exe ^
  --algorithm dynex ^
  --disable-cpu ^
  --gpu-id 0 ^ :: enable/disable gpu
  --mallob-endpoint https://dnx.sg.ekapool.com ^
  --pool dnx.sg.ekapool.com:19666 ^
  --wallet WALLET-ADDRESS
  ⁣--password WORKER-NAME
{% endhighlight %}

Example:
{% highlight bat %}
setx GPU_MAX_HEAP_SIZE 100
setx GPU_MAX_USE_SYNC_OBJECTS 1
setx GPU_SINGLE_ALLOC_PERCENT 100
setx GPU_MAX_ALLOC_PERCENT 100
setx GPU_MAX_SINGLE_ALLOC_PERCENT 100

@echo off
cd %~dp0
cls

SRBMiner-MULTI.exe ^
--algorithm dynex ^
--disable-cpu ^
--gpu-id 0 ^
--mallob-endpoint https://dnx.sg.ekapool.com ^
--pool dnx.sg.ekapool.com:19666 ^
--wallet XwnTnXV7cSEQszHqM3xihWZp6MiP6n8vqggLFH15VMEBDnpkBKnv1Cz7wn5L18uVrwMDFhdhB2fV3fSTZ7MexKDJ1ZgGx9ZCC ^
⁣--password AU-CO
pause
{% endhighlight %}

## 2. Nvidia Overclock script - `oc.bat`
- Locked GPU Clock: 1760MHz
- Locked Memory Clock: 5000MHz
- Power Limit: 135W

{% highlight bat %}
nvidia-smi -lgc 1760
nvidia-smi -lmc 5000
nvidia-smi -pl 135
{% endhighlight %}


## 3. Result
- Hashrate for a 3080 GPU: 240H/s
- Power Consumption: 115W
- Temperature: 46C
- Dynex chips: 334

{% include image.html url="/image/posts/2023-03-08-Dynex-mining-configuration---VGA-3080/1.png" description="Dynex Solver 2.2.5" %}
