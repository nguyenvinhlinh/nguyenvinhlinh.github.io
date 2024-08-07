---
layout: post
title: "Personal Node: Installing a Spectre fullnode"
date: 2024-08-07 22:37:45
update:
location: Saigon
tags:
- Cryptocurrency Node
categories:
- Cryptocurrency Node
seo_description: My personal note about setup a spectre node including systemd & firewall.
seo_image:
comments: true
---

# I. Systemctl service - /etc/systemd/system/spectre.service

{% highlight systemd %}
[Unit]
Description=Spectre Network - Full Node
After=network.target mnt-disk_2.mount

[Service]
WorkingDirectory=/opt/rusty-spectre-v0.3.14-linux-gnu-amd64
ExecStart=/opt/rusty-spectre-v0.3.14-linux-gnu-amd64/bin/spectred  --appdir=/mnt/disk_2/CryptoCurrency/Spectre  --rpclisten=0.0.0.0:18110 --rpclisten-borsh=0.0.0.0:19110 --rpclisten-json=0.0.0.0:20110 --listen=0.0.0.0:18111 --outpeers=64>
User=nguyenvinhlinh
RemainAfterExit=yes
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target

{% endhighlight %}

# II. Firewall-cmd service - /etc/firewalld/services/spectre.xml

|-------|-----------------------------------------|----------|
| Port  | Description                             | Firewall |
|-------|-----------------------------------------|----------|
| 18110 | gRPC, miner/stratum bridge need it      | Closed   |
| 18111 | P2P                                     | Open     |
| 19110 | WebSocket-framed wRPC/Borsh protocol    | Closed   |
| 20110 | WebSocket-framed wRPC/JSON-RPC protocol | Closed   |
|-------|-----------------------------------------|----------|

{% highlight xml %}
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>Spectre node</short>
  <description>
    This option allows Spectre node to use tcp port 18110
    - RPC: 18110
    - P2P: 18111
  </description>
  <port protocol="tcp" port="18110"/>
  <port protocol="udp" port="18110"/>
  <port protocol="tcp" port="18111"/>
  <port protocol="udp" port="18111"/>
</service>
{% endhighlight %}


# References
- gRPC, wRPC, Borsh/JSON, [https://kaspa-mdbook.aspectron.com/rpc.html](https://kaspa-mdbook.aspectron.com/rpc.html)
- Rusty Spectre Github Repository, [https://github.com/spectre-project/rusty-spectre](https://github.com/spectre-project/rusty-spectre)
