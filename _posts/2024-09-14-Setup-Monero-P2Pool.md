---
layout: post
title: "Setup Monero P2Pool"
date: 2024-09-14 19:11:51
update:
location:
tags:
categories:
- Cryptocurrency Node
seo_description:
seo_image:
comments: true
---

# I. Go to [https://github.com/SChernykh/p2pool](https://github.com/SChernykh/p2pool), download & extract to `/opt/`

{% highlight shell %}
$ tree /opt/p2pool-v4.1-linux-x64

/opt/p2pool-v4.1-linux-x64
├── LICENSE
├── p2pool
├── p2pool.cache
├── p2pool_peers.txt
└── README.md

{% endhighlight %}

# II. Create and edit `/etc/systemd/system/p2pool.service`

{% highlight systemd %}
[Unit]
Description=Monero P2Pool
After=network.target

[Service]
WorkingDirectory=/opt/p2pool-v4.1-linux-x64
ExecStart=/opt/p2pool-v4.1-linux-x64/p2pool --host 127.0.0.1 --wallet YOUR_MAIN_WALLET_HERE
User=nguyenvinhlinh
RemainAfterExit=yes
Restart=on-failure
RestartSec=10
TimeoutStopSec=180

[Install]
WantedBy=multi-user.target
{% endhighlight %}
