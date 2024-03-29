---
layout: post
title: "Alephium Miner Bot"
date: 2022-02-16 10:16:43 +0700
tags:
- Alephium
- Kaspa
- Telegram
categories: Projects
comments: true
---
[Github - Alephium Miner Bot](https://github.com/nguyenvinhlinh/alephium-miner-bot)

**Alephium Miner Bot is a telegram bot that sends the following messages**
- Global network hashrate
- Current IP
- Balance & mining reward

{% include image.html url="/image/posts/2022-02-16-Alephium-Miner-Bot/telegram.png" description="Telegram" %}

This bot is inspired by [Diomark](https://www.facebook.com/diomark/). His shell script about checking alph balance & mining time reward is really cool.

## Dependencies
- Alephium Node: 1.2.0 (if used alephium worker)
- Kaspa Node: 0.11.9 (if use kaspa worker)
- Erlang: 22.3
- Elixir: 1.12

## Elixir Processes

{% include image.html url="/image/posts/2022-02-16-Alephium-Miner-Bot/elixir-process.png" description="Elixir Processes" %}

## Release
Execute the following command, then project release will be generated at `/alephium_miner_bot/_build/prod/rel/alephium_miner_bot`
```sh
$ mix deps.get
$ MIX_ENV=prod mix release
```

## Execute Release
Make a file named `release_run.sh` or copy it from `release_run.sh.sample`. If you download release from github release, after unzip it, you can also use this
script named `release_run.sh` to launch the program, however beaware of your current directory.

```sh
#!/bin/bash
ALEPHIUM_WORKER=false \
ALPH_NODE_IP=127.0.0.1 \
ALPH_NODE_PORT=12973 \
ALPH_NODE_API_KEY=cf5062725e62d2096228cd6f7ab0f2a0 \
ALPH_NODE_WALLET_NAME=main \
ALPH_NODE_WALLET_PASSWORD="" \
WORKER_HASHRATE_INTERVAL=1800000 \
WORKER_IP_INTERVAL=60000 \
TELEGRAM_BOT_TOKEN=cf5062725e62d2096228cd6f7ab0f2a0 \
TELEGRAM_CHAT_ID=cf5062725e62d2096228cd6f7ab0f2a0 \
KASPA_WORKER=false \
KASPA_WALLET_PATH=/opt/kaspa/bin/kaspawallet \
_build/prod/rel/alephium_miner_bot/bin/alephium_miner_bot start
```

To execute the release, it's important to provide the following parameters:

Alephium Configration:

- `ALEPHIUM_WORKER`: enable/disable alephium worker, value: true/false
- `ALPH_NODE_IP`: self-explained
- `ALPH_NODE_PORT`: self-explained
- `ALPH_NODE_API_KEY`: self-explained
- `ALPH_NODE_WALLET_NAME`: self-explained
- `ALPH_NODE_WALLET_PASSWORD`: self-explained
- `WORKER_HASHRATE_INTERVAL`: interval in microsecond that fetching network hashrate.
- `WORKER_IP_INTERVAL`: interval in microsecond that fetching IP
- `TELEGRAM_BOT_TOKEN`: self-explained
- `TELEGRAM_CHAT_ID`: self-explained

Kaspa Configuration:
- `KASPA_WORKER`: enable/disable kaspa worker, value: true/false
- `KASPA_WALLET_PATH`: path to kaspa wallet executable file

Finally, make the file `release-run.sh` executable and run it
```sh
# Current directory: Project Root
$ ./release_run.sh
```

You should see the following output on terminal.

```text
[Worker.WorkerIP] started.
[Alephium][Worker.WorkerReward] started.
[Alephium][Worker.WorkerHashrate] started.
[Kaspa][Worker.WorkerReward] started.
2022-02-02 13:07 [Kaspa] Total Balance: 635,292.823
2022-02-02 13:07 IP: 42.112.xxx.xxx
2022-02-02 13:07 [Alephium] Global Hashrate: 27.1 TH/s
2022-02-02 13:07 [Alephium] Total Balance Hint: 0 ALPH
2022-02-02 13:07 [Kaspa] Won a block after 0.1 minute(s). Total Balance Hint: 638,292.823
```

And your telegram should show:

{% include image.html url="/image/posts/2022-02-16-Alephium-Miner-Bot/telegram.png" description="Telegram" %}

## Donation
If you want to buy me a coffee, this is my addresses.
- Alephium: `16ZcUrPRFafXdSjkTq5uWqkSrg6n5zwGB26pc7xrcjM7m`
- Kaspa: `kaspa:qz3997w4ew30rgp8wxp2aaj5zk7ect68nnzy80fhrpw0d7fdervkw8lpwrmry`

Thank you from Vietnam.
