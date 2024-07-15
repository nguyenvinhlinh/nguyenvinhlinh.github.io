---
layout: post
title: "Setup kaspa stratum bridge for solo mining"
date: 2024-07-16 00:37:01
update:
location: Saigon
tags:
- Kaspa
categories:
- Cryptocurrency Node
seo_description:
seo_image: /image/posts/2024-07-16-How-to-setup-kaspa-stratum-bridge-for-solo-mining/1.png
comments: true
---

# I. Clone repo [https://github.com/rdugan/kaspa-stratum-bridge](https://github.com/rdugan/kaspa-stratum-bridge)

Or copy relase to `/opt/kaspa-ks-bridge`
{% highlight sh %}
$  kaspa_ks_bridge pwd
/opt/kaspa_ks_bridge

$  kaspa_ks_bridge tree
.
├── bridge.log
├── config.yaml
└── ks_bridge

1 directory, 3 files

{% endhighlight %}

# II. Modify `config.yaml`
{% highlight yaml %}
stratum_port: :5555
kaspad_address: localhost:16110
min_share_diff: 8192
pow2_clamp: true
var_diff: true
shares_per_min: 20
var_diff_stats: true
block_wait_time: 500ms
extranonce_size: 2
print_stats: true
log_to_file: true
prom_port: :2114
{% endhighlight %}

# III. Systemctl service - `/etc/systemd/system/kaspa_ks_bridge.service`
{% highlight systemd %}
[Unit]
Description=Kaspa - KS Bridge
Requires=network.target

[Service]
WorkingDirectory=/opt/kaspa_ks_bridge
ExecStart=/opt/kaspa_ks_bridge/ks_bridge
User=nguyenvinhlinh
RemainAfterExit=yes
Restart=on-failure
RestartSec=10
TimeoutStopSec=180

[Install]
WantedBy=multi-user.target
{% endhighlight %}

# IV. Config ASIC's Mining Settings

The pool address should be `stratum+tcp://192.168.1.XXX:5555` (your local stratum node ip)

{% include image.html url="/image/posts/2024-07-16-How-to-setup-kaspa-stratum-bridge-for-solo-mining/1.png" description="ASIC's Mining setting" %}
