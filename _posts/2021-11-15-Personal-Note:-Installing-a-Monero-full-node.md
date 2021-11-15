---
layout: post
title: "Personal Note: Installing a Monero full node"
date: 2021-11-15 23:44:58
tags:
- Monero
- Cryptocurrency Node
categories:
- Cryptocurrency Node
---
# I. Monero Node Config - monerod.conf
``` config
# /opt/monero-gui-v0.17.2.3/monerod.conf

# Data directory (blockchain db and indices)
data-dir=/mnt/disk_2/Monero/  # Remember to create the monero user first

# Log file
log-file=/mnt/disk_2/Monero/log/monerod.log
max-log-file-size=0            # Prevent monerod from managing the log files; we want logrotate to take care of that

# P2P full node
p2p-bind-ip=0.0.0.0            # Bind to all interfaces (the default)
p2p-bind-port=18080            # Bind to default port

# RPC open node
rpc-bind-ip=0.0.0.0            # Bind to all interfaces
rpc-bind-port=18081            # Bind on default port
confirm-external-bind=1        # Open node (confirm)
restricted-rpc=1               # Prevent unsafe RPC calls
no-igd=1                       # Disable UPnP port mapping

# Slow but reliable db writes
db-sync-mode=safe:sync
block-sync-size=100

# Emergency checkpoints set by MoneroPulse operators will be enforced to workaround potential consensus bugs
# Check https://monerodocs.org/infrastructure/monero-pulse/ for explanation and trade-offs
enforce-dns-checkpointing=1

out-peers=64              # This will enable much faster sync and tx awareness; the default 8 is suboptimal nowadays
in-peers=1024             # The default is unlimited; we prefer to put a cap on this

limit-rate-up=1048576     # 1048576 kB/s == 1GB/s; a raise from default 2048 kB/s; contribute more to p2p network
limit-rate-down=1048576   # 1048576 kB/s == 1GB/s; a raise from default 8192 kB/s; allow for faster initial sync
```

# II. Systemctl service - /etc/systemd/system/monero.service
``` systemd
[Unit]
Description=Monero Full Node
After=network.target  mnt-disk_2.mount

[Service]
WorkingDirectory=/opt/monero-gui-v0.17.2.3
ExecStart=/opt/monero-gui-v0.17.2.3/monerod --config-file /opt/monero-gui-v0.17.2.3/monerod.conf --detach
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
