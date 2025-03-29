---
layout: post
title: "Personal note: Installing a Beam fullnode"
date: 2025-03-30 00:04:41
update:
location: Saigon
tags:
- beam
- crypto
categories:
- Cryptocurrency Node
seo_description:
seo_image:
comments: true
---

# I. Systemctl service /etc/systemd/system/beam.service

```systemd
[Unit]
Description=Beam Node
Requires=network.target

[Service]
WorkingDirectory=/opt/beam-node-7.5.13882/
ExecStart=/opt/beam-node-7.5.13882/beam-node --config_file=/opt/beam-node-7.5.13882/beam-node.cfg
User=nguyenvinhlinh
RemainAfterExit=yes
Restart=on-failure
RestartSec=10
TimeoutStopSec=180

[Install]
WantedBy=multi-user.target#
```

# II. Firewall-cmd service - /etc/firewalld/services/beam.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>Beam</short>
  <description>
    P2P: 10000
  </description>
  <port protocol="tcp" port="10000"/>
  <port protocol="udp" port="10000"/>
</service>
```

# III. Beam node config - /opt/beam-node-7.5.13882/beam-node.cfg
```
################################################################################
# General options:
################################################################################

# port to start server on
port=10000

# log level [info|debug|verbose]
log_level=debug

# file log level [info|debug|verbose]
file_log_level=debug

# old logs cleanup period (days)
log_cleanup_days=5

################################################################################
# Node options:
################################################################################

# node storage path
storage=/opt/beam-node-7.5.13882/data/node.db
network=mainnet

# nodes to connect to
peer=eu-nodes.mainnet.beam.mw:8100
peer=us-nodes.mainnet.beam.mw:8100

# port to start stratum server on
# stratum_port=0

# path to stratum server api keys file, and tls certificate and private key
# stratum_secrets_path=.

# Enforce re-synchronization (soft reset)
# resync=0

# Owner viewer key
# owner_key=

# Standalone miner key
# miner_key=

# password for keys
# pass

# Fork1 height
# Fork1=

# Path to treasury for testing
# treasury_path=

```
