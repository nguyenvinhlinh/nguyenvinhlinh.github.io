---
layout: post
title: "XMRig - config.json Template"
date: 2022-06-01 22:09:00
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
  "autosave": true,
  "donate-level": 0,
  "cpu": true,
  "opencl": false,
  "cuda": false,
  "pools": [
    {
      "url": "sg.minexmr.com:443",
      "user": "MONERO_ADDRESS_HERE",
      "rig-id": "2",
      "pass": "x",
      "keepalive": true,
      "tls": true
    }
  ]
}
```

After run the xmrig program, file named `config.json` will be updated with new attributes. Reopen `config.json` again and update attribute named `1gb-pages` to `true`.
