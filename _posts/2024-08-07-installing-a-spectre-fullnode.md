---
layout: post
title: "Personal Node: Installing a Spectre fullnode"
date: 2024-08-07 22:37:45
update: 2025-06-03 20:17:48
location: Saigon
tags:
- Cryptocurrency Node
categories:
- Cryptocurrency Node
seo_description: My personal note about setup a spectre node including systemd & firewall.
seo_image:
comments: true
---

# I. Systemctl service - `/etc/systemd/system/spectre.service`

{% highlight systemd %}
[Unit]
Description=Spectre Node
Requires=network.target

[Service]
WorkingDirectory= /opt/rusty-spectre-v0.3.17-linux-gnu-amd64
ExecStart=/opt/rusty-spectre-v0.3.17-linux-gnu-amd64/bin/spectred --configfile /opt/rusty-spectre-v0.3.17-linux-gnu-amd64/spectred.conf
User=nguyenvinhlinh
RemainAfterExit=yes
Restart=on-failure
RestartSec=10
TimeoutStopSec=infinity

[Install]
WantedBy=multi-user.target
{% endhighlight %}

# II. Spectred.config - `/opt/rusty-spectre-v0.3.17-linux-gnu-amd64/spectred.conf`

{% highlight conf %}
appdir="/opt/spectre-blockchain-data"
disable-upnp=true
utxoindex=true
outpeers=128
{% endhighlight %}

# III. Firewall-cmd service - `/etc/firewalld/services/spectre.xml`

|-------|---------------------------------------------------------------------------|----------|
| Port  | Description                                                               | Firewall |
|-------|---------------------------------------------------------------------------|----------|
| 18110 | gRPC, miner/stratum bridge/golang wallet need it                          | Closed   |
| 18111 | P2P                                                                       | Open     |
| 19110 | WebSocket-framed wRPC/Borsh protocol. It's used for (rust) spectre wallet | Closed   |
| 20110 | WebSocket-framed wRPC/JSON-RPC protocol                                   | Closed   |
|-------|---------------------------------------------------------------------------|----------|

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
