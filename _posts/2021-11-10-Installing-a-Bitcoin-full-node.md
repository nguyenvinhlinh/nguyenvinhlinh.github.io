---
layout: post
title: "Personal Note: Installing a Bitcoin full node"
date: 2021-11-10 23:35:14
tags:
- Cryptocurrency Node
- Bitcoin
categories:
- Cryptocurrency Node
---

# I. Systemctl service - /etc/systemd/system/bitcoin.service

```systemd
[Unit]
Description=Bitcoin Full Node
After=network.target  mnt-disk_2.mount

[Service]
WorkingDirectory=/opt/bitcoin-0.21.1/
ExecStart=/opt/bitcoin-0.21.1/bin/bitcoind -datadir=/mnt/disk_2/Bitcoin -daemon
ExecStop=/opt/bitcoin-0.21.1/bin/bitcoin-cli -datadir=/mnt/disk_2/Bitcoin stop
User=nguyenvinhlinh
RemainAfterExit=yes
Restart=on-failure
RestartSec=10
TimeoutStopSec=infinity

[Install]
WantedBy=multi-user.target
```

# II. Firewall-cmd service - /etc/firewalld/services/bitcoin.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>Bitcoin node</short>
  <description>This option allows Bitcoin node to use tcp port 8333</description>
  <port protocol="tcp" port="8333"/>
</service>
```
