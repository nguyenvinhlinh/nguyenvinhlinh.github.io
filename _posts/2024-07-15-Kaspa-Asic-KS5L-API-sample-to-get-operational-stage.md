---
layout: post
title: "Kaspa Asic - KS5L - API sample to get operational stage"
date: 2024-07-15 00:04:58
update:
location: Saigon
tags:
categories:
- Mining Rig
seo_description: API Document for KS5L operational stage
seo_image: /image/posts/2024-07-15-Kaspa-Asic-KS5L-API-sample-to-get-operational-stage/1.png
comments: true
---

{% include image.html url="/image/posts/2024-07-15-Kaspa-Asic-KS5L-API-sample-to-get-operational-stage/1.png" description="Ice River - KS5L" %}

This post is all about **HTTP API**  to get `ASIC operational stage`, in particular `KS5L`. I believe that this API is also for `KS0` and other future Ice River's ASICs
This finding is a part of my open source project named  [Mining Rig Monitor](https://github.com/nguyenvinhlinh/Mining-Rig-Monitor).

## This is the HTTP POST example with `curl`.
{% highlight shell %}
$ curl 'http://192.168.1.XXX/user/userpanel' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'Accept-Language: en-US,en;q=0.9,vi-VN;q=0.8,vi;q=0.7' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'Cookie: language=en; ctime=1' \
  -H 'DNT: 1' \
  -H 'Origin: http://192.168.1.XXX' \
  -H 'Referer: http://192.168.1.XXX/' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36' \
  -H 'X-Requested-With: XMLHttpRequest' \
  --data-raw 'post=4' \
  --insecure
{% endhighlight %}


## HTTP 200 - Response
{% highlight json %}
{
  "error": 0,
  "data": {
    "model": "none",
    "algo": "none",
    "online": true,
    "firmver1": "BOOT_3_1",
    "firmver2": "image_1.0",
    "softver1": "ICM168_3_2_10_ks5L_miner",
    "softver2": "ICM168_3_2_10_ks5L_bg",
    "firmtype": "Factory",
    "nic": "eth0",
    "mac": "****:****:****:****:****:**",
    "ip": "192.168.1.XX",
    "netmask": "255.255.255.0",
    "host": "XJGXG_SSYYGB",
    "dhcp": false,
    "gateway": "192.168.1.xxfe80::1",
    "dns": "xx.xx.xx.xx",
    "locate": false,
    "rtpow": "15011G",
    "avgpow": "10789G",
    "reject": 0.0,
    "runtime": "01:04:29:02",
    "unit": "G",
    "pows": {
      "board1": [
        10789,
        9851,
        11728,
        11728,
        9851,
        8913,
        7505,
        7505,
        8913,
        8913,
        13135,
        8444,
        10320,
        7036,
        5629,
        12197,
        9382,
        12666,
        11258,
        9382,
        7505,
        8913,
        15011
      ]
    },
    "pows_x": [
      "0 mins",
      "5 mins",
      "10 mins",
      "15 mins",
      "20 mins",
      "25 mins",
      "30 mins",
      "35 mins",
      "40 mins",
      "45 mins",
      "50 mins",
      "55 mins",
      "60 mins",
      "65 mins",
      "70 mins",
      "75 mins",
      "80 mins",
      "85 mins",
      "90 mins",
      "95 mins",
      "100 mins",
      "105 mins",
      "110 mins"
    ],
    "powstate": true,
    "netstate": true,
    "fanstate": true,
    "tempstate": false,
    "fans": [
      5900,
      5900,
      5900,
      5855
    ],
    "pools": [
      {
        "no": 1.0,
        "addr": "stratum+tcp://asia1.kaspa-pool.org:4441",
        "user": "kaspa:qr3d34p6gzewwjs93fvheruwjyvfn35kn5uu00e6ffsgt6k087c4qsgp8l0mk.worker_1",
        "pass": "x",
        "connect": 1.0,
        "diff": "140737.49 G",
        "priority": 1.0,
        "accepted": 7225.0,
        "rejected": 0.0,
        "diffa": 0.0,
        "diffr": 0.0,
        "state": 1.0,
        "lsdiff": 0.0,
        "lstime": "00:00:00"
      },
      {
        "no": 2.0,
        "addr": "stratum+tcp://eu1.kaspa-pool.org:4441",
        "user": "kaspa:**********.worker_1",
        "pass": "x",
        "connect": -1.0,
        "diff": "0.00 G",
        "priority": 2.0,
        "accepted": 0.0,
        "rejected": 0.0,
        "diffa": 0.0,
        "diffr": 0.0,
        "state": 0.0,
        "lsdiff": 0.0,
        "lstime": "00:00:00"
      },
      {
        "no": 3.0,
        "addr": "stratum+tcp://us1.kaspa-pool.org:4441",
        "user": "kaspa:**********.worker_1",
        "pass": "x",
        "connect": -1.0,
        "diff": "0.00 G",
        "priority": 3.0,
        "accepted": 0.0,
        "rejected": 0.0,
        "diffa": 0.0,
        "diffr": 0.0,
        "state": 0.0,
        "lsdiff": 0.0,
        "lstime": "00:00:00"
      }
    ],
    "boards": [
      {
        "no": 1.0,
        "chipnum": 18.0,
        "chipsuc": 0.0,
        "error": 0.0,
        "freq": 875.0,
        "rtpow": "5160.37G",
        "avgpow": "3831.19G",
        "idealpow": "0.00G",
        "tempnum": "(null)",
        "pcbtemp": "0.00-0.00-0.00-0.00",
        "intmp": 61.0,
        "outtmp": 63.0,
        "state": true,
        "false": [
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18
        ]
      },
      {
        "no": 2.0,
        "chipnum": 18.0,
        "chipsuc": 0.0,
        "error": 0.0,
        "freq": 875.0,
        "rtpow": "5629.50G",
        "avgpow": "3440.25G",
        "idealpow": "0.00G",
        "tempnum": "(null)",
        "pcbtemp": "0.00-0.00-0.00-0.00",
        "intmp": 57.0,
        "outtmp": 61.0,
        "state": true,
        "false": [
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18
        ]
      },
      {
        "no": 3.0,
        "chipnum": 18.0,
        "chipsuc": 0.0,
        "error": 0.0,
        "freq": 875.0,
        "rtpow": "4222.12G",
        "avgpow": "3518.44G",
        "idealpow": "0.00G",
        "tempnum": "(null)",
        "pcbtemp": "0.00-0.00-0.00-0.00",
        "intmp": 62.0,
        "outtmp": 67.0,
        "state": true,
        "false": [
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18
        ]
      }
    ],
    "refTime": "2024-03-08 01:58:25 UTC"
  },
  "message": ""
}
{% endhighlight %}

I hope that you guys could find it useful, good luck!
