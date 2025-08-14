---
layout: post
title: "Personal Note: Installing a Monero full node"
date: 2021-11-15 23:44:58 +0700
update: 2025-08-14 14:54:20
tags:
- Monero
- Cryptocurrency Node
categories:
- Cryptocurrency Node
---

## I. Monero Node Config - `/opt/monero-x86_64-linux-gnu-v0.18.4.1/monerod.conf`
``` config
# Data directory (blockchain db and indices)
data-dir=/mnt/disk_2/CryptoCurrency/Monero  # Remember to create the monero user first

# Log file
log-file=/mnt/disk_2/CryptoCurrency/Monero/log/monerod.log
max-log-file-size=0            # Prevent monerod from managing the log files; we want logrotate to take care of that
log-level=0

# P2P full node
p2p-bind-ip=0.0.0.0            # Bind to all interfaces (the default)
p2p-bind-port=18080            # Bind to default port

add-peer=nodes.hashvault.pro:18080

# RPC Restricted IP/PORT
rpc-restricted-bind-ip=0.0.0.0
rpc-restricted-bind-port=18081

# RPC Full Permission, local access only
rpc-bind-ip=127.0.0.1          # Bind to all interfaces
rpc-bind-port=18084            # Bind on default port

confirm-external-bind=1        # Open node (confirm)
no-igd=1                       # Disable UPnP port mapping

zmq-pub=tcp://127.0.0.1:18083

# Slow but reliable db writes
db-sync-mode=safe:sync
block-sync-size=10
prep-blocks-threads=28

# Emergency checkpoints set by MoneroPulse operators will be enforced to workaround potential consensus bugs
# Check https://monerodocs.org/infrastructure/monero-pulse/ for explanation and trade-offs
enforce-dns-checkpointing=1

out-peers=128              # This will enable much faster sync and tx awareness; the default 8 is suboptimal nowadays
in-peers=128             # The default is unlimited; we prefer to put a cap on this

limit-rate-up=1048576     # 1048576 kB/s == 1GB/s; a raise from default 2048 kB/s; contribute more to p2p network
limit-rate-down=1048576   # 1048576 kB/s == 1GB/s; a raise from default 8192 kB/s; allow for faster initial sync
```

# II. Systemctl service - /etc/systemd/system/monero.service
``` systemd
[Unit]
Description=Monero Full Node
After=network.target  mnt-disk_2.mount

[Service]
WorkingDirectory=/opt/monero-x86_64-linux-gnu-v0.18.4.1
ExecStart=/opt/monero-x86_64-linux-gnu-v0.18.4.1/monerod --config-file /opt/monero-x86_64-linux-gnu-v0.18.4.1/monerod.conf --non-interactive
User=nguyenvinhlinh
RemainAfterExit=yes
Restart=on-failure
RestartSec=10
TimeoutStopSec=infinity

[Install]
WantedBy=multi-user.target
```

# III. Firewall-cmd service - /etc/firewalld/services/monero.xml
``` xml
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>Monero node</short>
  <description>
    This option allows Monero node to use tcp port:
    - 18080: p2p network
    - 18081: JSON-RPC server
  </description>
  <port protocol="tcp" port="18080"/>
  <port protocol="tcp" port="18081"/>
</service>
```
