---
layout: post
title: "XMRig - config.json Template"
date: 2022-06-01 22:09:00 +0700
tags:
- Mining Rig
- Monero
- XMRig
categories:
- Mining Rig
---

```config
# XMRig configuration file config.json
{
  "api": {
    "worker-id": "worker-x"
  },
  "http": {
    "enabled": true,
    "host": "0.0.0.0",
    "port": 8080,
    "access-token": null,
    "restricted": true
  },
  "autosave": true,
  "opencl": false,
  "cuda": false,
  "pools": [
    {
      "coin": "monero",
      "algo": "rx/0",
      "url": "pool.hashvault.pro:443",
      "user": "MONERO_ADDRESS_HERE",
      "pass": "worker-x",
      "tls": true,
      "keepalive": true,
      "nicehash": false
    }
  ],
  "randomx": {
    "1gb-pages": true
  },
  "cpu": {
    "enabled": true,
    "huge-pages": true
  }
}

```
