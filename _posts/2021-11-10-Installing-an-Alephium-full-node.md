---
layout: post
title: "Personal Note: Installing an Alephium full node"
date:   2021-11-10 23:56:14 +0700
update: 2022-12-14 00:05:56 +0700
tags:
- Cryptocurrency Node
- Alephium
categories:
- Cryptocurrency Node
comments: true
---
# I. Alephium node config - $ALEPHIUM_HOME/user.conf
```config
alephium.network.external-address="x.x.x.x:9973"
alephium.api.network-interface = "0.0.0.0"
alephium.mining.api-interface="0.0.0.0"

alephium.mining.miner-addresses=[
 "miner_address_1",
 "miner_address_2",
 "miner_address_3",
 "miner_address_4",
]
```

# II. Systemctl EnvironmentFile - /opt/alephium/alephium.env
``` config
ALEPHIUM_HOME=/mnt/CaHeoNas/disk_3/Alephium
```

# III. Systemctl service - /etc/systemd/system/alephium.service

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

# IV. Firewall-cmd service - /etc/firewalld/services/alephium.xml
Port List:
- 9973: p2p
- 10973: miner
- 12973: api (danger to expose to the internet.)

```xml
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>Alephium node</short>
  <description>
    This option allows Alephium node to use tcp port 9973, 10973
  </description>
  <port protocol="tcp" port="9973"/>
  <port protocol="tcp" port="10973"/>
</service>
```

# IV. Balance checking script
All Credit goes this guy Mark Rahmani (diomark#8272) [https://www.facebook.com/diomark/](https://www.facebook.com/diomark/)

```sh
#!/bin/zsh

#first need to unlock wallet. not putting password in here

#check wallet
curlResult=`curl -X 'GET'   'http://127.0.0.1:12973/wallets/MINER_WALLET_NAME/balances'   -H 'accept: application/json' 2>/dev/null | json_pp | grep totalBalanceHint| cut -f1 -d","`
lastdate=`date +%s`


if echo $curlResult | grep -q ALPH; then
  datestr=`date +"%x %R"`
  echo -n "$datestr "
  echo Wallet unlocked - $curlResult;
else
  echo Please unlock wallet first
  exit
fi

while true; do
 oldResult=$curlResult

 datestr=`date +"%x %R"`; echo -n "."; curlResult=`curl -X 'GET'   'http://127.0.0.1:12973/wallets/MINER_WALLET_NAME/balances'   -H 'accept: application/json' 2>/dev/null | json_pp | grep totalBalanceHint| cut -f1 -d","`
 if [ "$oldResult" != "" ]; then
    if [ "$curlResult" != "$oldResult" ]; then
       echo
       echo -n "$datestr "
       newdate=`date +%s`
       secs=`expr $newdate - $lastdate`
       mins=`expr $secs / 60`
       echo  -n "Won a block after $mins minutes! "
       echo $curlResult
       lastdate=$newdate
    fi
 fi

 sleep 30
done

```


{% include image.html url="/image/posts/2021-11-10-Installing-an-Alephium-full-node/1.png" description="Balance Checking Script Output." %}
