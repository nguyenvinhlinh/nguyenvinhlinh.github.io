---
layout: post
title: "Thiết lập thông số 3080 - Dàn #3 Chu Tước"
date: 2022-04-23 00:57:47
update: 2022-05-11 20:25:00
location: Saigon
tags:
categories:
- Mining Rig
seo_description:
seo_image:
comments: false
---

# I. Lời mở đầu
Bài viết này phục vụ mục đích duy nhất là đó là nếu tôi lỡ tay xóa mấy profile trên **MSI Afterburner**, **Minerstat**.
Tôi sẽ quay lại đây xem. Hiện tại đây là 4 VGA trực thuộc dàn **#3 Chu Tước**. Cả 4 VGA này đều là dòng Lite Hash Rate (LHR).


| No | VGA                          |
|----|------------------------------|
| 1  | MSI 3080 VENTUS 10G OC (LHR) |
| 2  | MSI 3080 VENTUS 10G OC (LHR) |
| 3  | MSI 3080 VENTUS 10G OC (LHR) |
| 4  | MSI 3080 VENTUS 10G OC (LHR) |

{% include image.html url="/image/posts/2022-04-23-Thiet-lap-thong-so-3080---Dan-3/1.png" description="[1] Chu Tước" %}

# II. Mức thiết lập - Ethereum - 95MH/s
Dàn đào Chu Tước sử dụng phần mềm [NBMiner](https://github.com/NebuTech/NBMiner).
{% include image.html url="/image/posts/2022-04-23-Thiet-lap-thong-so-3080---Dan-3/2.png" description="[2] T-rex miner" %}

## a. Thiết lập với Minerstat

- Power limit (Watt): 280 Walt
- Power limit (%): skip
- Core Clock (-/+ MHz): skip
- Locked Memory Clock (MHz): skip
- Force P2 State: skip
- ClockTune delay: 0

| No | VGA                          | Locked Core | -/+ Memory Clock |
|----|------------------------------|-------------|------------------|
| 1  | MSI 3080 VENTUS 10G OC (LHR) | 1200 MH/s   | +1100 MH/s       |
| 2  | MSI 3080 VENTUS 10G OC (LHR) | 1200 MH/s   | +1100 MH/s       |
| 3  | MSI 3080 VENTUS 10G OC (LHR) | 1200 MH/s   | +1100 MH/s       |
| 4  | MSI 3080 VENTUS 10G OC (LHR) | 1200 MH/s   | +1100 MH/s       |

## b. Kết quả thu được

| No | VGA                          | Power Consumption | Hashrate     | GPU Temp. | Memory Temp. |
|----|------------------------------|-------------------|--------------|-----------|--------------|
| 1  | MSI 3080 VENTUS 10G OC (LHR) | 226 Walt          | 98.28 MH/s   | 62C       | 90C          |
| 2  | MSI 3080 VENTUS 10G OC (LHR) | 243 Walt          | 97.12 MH/s   | 59C       | 88C          |
| 3  | MSI 3080 VENTUS 10G OC (LHR) | 231 Walt          | 98.25 MH/s   | 58C       | 86C          |
| 4  | MSI 3080 VENTUS 10G OC (LHR) | 233 Walt          | 98.36 MH/s   | 56C       | 84C          |
|    |                              |                   |              |           |              |
|    | **Total**                    | **933 Walt**      | **392 MH/s** | --        | --           |
