---
layout: post
title: "Kaspa, Mining Script"
date: 2022-01-14 22:15:44
tags:
- mining rig
- kaspa
categories:
- Mining Rig
seo_description:
seo_image:
comments: false
---

1. Download the latest `kaspa-miner` [https://github.com/tmrlvi/kaspa-miner/releases](https://github.com/tmrlvi/kaspa-miner/releases) and unzip.
2. Create a bat file named `run-kaspa-miner.bat` at the directory which is unzip at previous step.

{% highlight text %}
::run-kaspa-miner.bat
kaspa-miner-v0.2.1-GPU-0.2-win64-amd64.exe --mining-address=kaspa:qp30cee96qejpnz236fu8gn5yv9dkjdhp9s5hk8tfz8u7w068g7v7tlkvxn90 ^
                                           --threads 0 --devfund-percent 0 --cuda-workload 256 ^
                                           --kaspad-address IP_HERE --port 16110
{% endhighlight %}
{:start="3"}
3. Execute `run-kaspa-miner.bat` to start mining. Good Luck!
