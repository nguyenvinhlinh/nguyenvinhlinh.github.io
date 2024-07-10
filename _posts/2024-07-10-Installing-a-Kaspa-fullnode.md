---
layout: post
title: "Installing a Kaspa fullnode"
date: 2024-07-10 11:22:34
update:
location:
tags:
- Cryptocurrency Node
- Kaspa
categories:
- Cryptocurrency Node
seo_description:
seo_image:
comments: true
---

# I. Systemctl service - /etc/systemd/system/kaspa.service

{% highlight service %}
[Unit]
Description=Kaspa Full Node
After=network.target mnt-disk_2.mount

[Service]
WorkingDirectory=/opt/rusty-kaspa-v0.14.1-linux-gnu-amd64
ExecStart=/opt/rusty-kaspa-v0.14.1-linux-gnu-amd64/bin/kaspad --appdir=/mnt/disk_2/CryptoCurrency/Kaspa --utxoindex --rpclisten=0.0.0.0:16110 --rpclisten-borsh=0.0.0.0:17110
User=nguyenvinhlinh
RemainAfterExit=yes
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
{% endhighlight %}

# II. Firewall-cmd - /etc/firewalld/services/kaspa.xml

{% highlight xml %}
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>Kaspa node</short>
  <description>
    This option allows Kaspa node to use tcp port
    - 16110: gRPC for mining + go wallet
    - 16111: P2P
    - 17110: wRPC Borsh for rusty wallet
  </description>
  <port protocol="tcp" port="16110"/>
  <port protocol="tcp" port="16111"/>
  <port protocol="tcp" port="17110"/>
</service>
{% endhighlight %}

# III. How to use kaspa-wallet?
{% highlight sh %}
$ ./kaspa-wallet
####### You are in kaspa-wallet interactive console
$ server 127.0.0.1:17110
Setting RPC server to: 127.0.0.1:17110
$ connect
Connected to Kaspa node version 0.14.1 at ws://127.0.0.1:17110
$ wallet create test_wallet

$ wallet help
unknown command: 'help'

    close             Close an opened wallet (shorthand: 'close')
    create [<name>]   Create a new bip32 wallet
    hint              Change the wallet phishing hint
    import [<name>]   Create a wallet from an existing mnemonic (bip32 only).

                      To import legacy wallets (KDX or kaspanet) please create
                      a new bip32 wallet and use the 'account import' command.
                      Legacy wallets can only be imported as accounts.

    list              List available local wallet files
    open [<name>]     Open an existing wallet (shorthand: 'open [<name>]')

{% endhighlight %}
