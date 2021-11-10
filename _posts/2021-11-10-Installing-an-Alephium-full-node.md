---
layout: post
title: "Personal Note: Installing an Alephium full node"
date: 2021-11-10 23:56:14
tags:
- Cryptocurrency Node
- Alephium
categories:
- Cryptocurrency Node
---
# I. Alephium node config - Alephium/user.conf

```config
alephium.network.external-address="42.117.91.143:9973"
```

# II. Systemctl service - /etc/systemd/system/alephium.service

```systemd
[Unit]
Description=Alphelium Full Node
After=network.target mnt-CaHeoNas-disk_3.mount

[Service]
WorkingDirectory=/opt/alephium
EnvironmentFile=/opt/alephium/alephium.env
ExecStart=java -jar -Xms512m -Xmx1028m alephium-1.0.0.jar
User=nguyenvinhlinh
RemainAfterExit=yes
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
```

# III. Firewall-cmd service - /etc/firewalld/services/alephium.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>Alephium node</short>
  <description>This option allows Alephium node to use tcp port 8333</description>
  <port protocol="tcp" port="9973"/>
  <port protocol="udp" port="9973"/>
</service>
```
