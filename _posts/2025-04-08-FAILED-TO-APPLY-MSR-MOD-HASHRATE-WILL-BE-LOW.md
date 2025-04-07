---
layout: post
title: "XMRig: FAILED TO APPLY MSR MOD, HASHRATE WILL BE LOW"
date: 2025-04-08 00:32:49
update:
location: Saigon
tags:
categories:
- Mining Rig
seo_description: Fixing MSR MOD on Linux and Window
seo_image: /image/posts/2025-04-08-FAILED-TO-APPLY-MSR-MOD-HASHRATE-WILL-BE-LOW/seo.jpg
comments: true
---
This post is all about resolve MSR error while running XMRig on Linux and Window.

**Error: FAILED TO APPLY MSR MOD, HASHRATE WILL BE LOW**


{% highlight text %}
 * ABOUT        XMRig/6.22.2 gcc/13.2.1 (built for Linux x86-64, 64 bit)
 * LIBS         libuv/1.49.2 OpenSSL/3.0.15 hwloc/2.11.2
 * HUGE PAGES   supported
 * 1GB PAGES    supported
 * CPU          AMD Ryzen 9 7950X3D 16-Core Processor (1) 64-bit AES
                L2:16.0 MB L3:128.0 MB 16C/32T NUMA:1
 * MEMORY       6.8/30.5 GB (22%)
                DIMMA1: <empty>
                DIMMA2: 16 GB DDR5 @ 6000 MHz F5-6000J3038F16G
                DIMMB1: <empty>
                DIMMB2: 16 GB DDR5 @ 6000 MHz F5-6000J3038F16G
 * MOTHERBOARD  Micro-Star International Co., Ltd. - MAG B650 TOMAHAWK WIFI (MS-7D75)
 * DONATE       1%
 * ASSEMBLY     auto:ryzen
 * POOL #1      pool.hashvault.pro:443 coin Monero
 * COMMANDS     hashrate, pause, resume, results, connection
 * HTTP API     0.0.0.0:8080
[2025-04-08 00:19:57.673]  net      use pool pool.hashvault.pro:443 TLSv1.3 157.20.104.252
[2025-04-08 00:19:57.673]  net      fingerprint (SHA-256): "420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14"
[2025-04-08 00:19:57.673]  net      new job from pool.hashvault.pro:443 diff 72000 algo rx/0 height 3384982 (124 tx)
[2025-04-08 00:19:57.673]  cpu      use argon2 implementation AVX-512F
[2025-04-08 00:19:57.673]  msr      cannot set MSR 0xc0011020 to 0x0004400000000000
[2025-04-08 00:19:57.673]  msr      FAILED TO APPLY MSR MOD, HASHRATE WILL BE LOW   <<-------------------- ERROR HERE
[2025-04-08 00:19:57.673]  randomx  init dataset algo rx/0 (32 threads) seed fbd882390916fe90...
[2025-04-08 00:19:57.782]  randomx  allocated 3072 MB (2080+256) huge pages 100% 3/3 +JIT (109 ms)
[2025-04-08 00:19:58.896]  randomx  dataset ready (1114 ms)
{% endhighlight %}

## For Linux, I test it with Fedora 41.

- Run as sudo
- Disable `Secure Boot` in BIOS
- Turn off `Intel Virtualization Technology`, on MSI Motherboard, `Bios Click 5 dashboard`, its name is `SVM` (`Overlocking >> Advanced CPU Configuration >> SVM mode`)

## For Window, I did not test, but the concept is the same.

- Run as administrator (Window)
- Disable `Secure Boot` in **BIOS**
- Turn off `Intel Virtualization Technology` in **BIOS**, on MSI Motherboard, `Bios Click 5 dashboard`, its name is `SVM` (`Overlocking >> Advanced CPU Configuration >> SVM mode`)
- Turn off `core isolation` (Window)
- Turn off `memory integrety` (Window)
