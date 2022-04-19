---
layout: post
title: "Thiết lập thông số 3080 - Dàn #1 Thanh Long"
date: 2021-03-10 15:51:00
tags: mining
categories:
- Mining Rig
---
# I. Lời mở đầu

Bài viết này phục vụ mục đích duy nhất là đó là nếu tôi lỡ tay xóa mấy profile trên MSI Afterburner. Tôi sẽ quay lại đây xem. Hiện tại đây là 4 VGA trực thuộc dàn **#1 Thanh Long**

| No | VGA                           |
|----|-------------------------------|
| 1  | MSI 3080 GAMING X TRIO        |
| 2  | ASUS 3080 ROG STRIX GAMING OC |
| 3  | MSI 3080 VENTUS 10G OC        |
| 4  | MSI 3080 GAMING X TRIO        |




{% include image.html url="/image/posts/2021-03-10-Thiet-lap-thong-so-3080---Dan-1/1.jpg" description="[1] Dàn 3080 - #1 Thanh Long" %}

# II. Mức thiết lập - 95MH/s
## a. Tinh chỉnh tốc độ quạt theo nhiệt độ
- 30C -->  40% Fan
- 50C -->  80% Fan
- 60C -->  90% Fan
- 65C --> 100% Fan

{% include image.html url="/image/posts/2021-03-10-Thiet-lap-thong-so-3080---Dan-1/2.png" description="[2] Tinh chỉnh tốc độ quạt" %}


## b. Tinh Chinh MSI Afterburner


| No. VGA                           | Power Limit | Temp. Limit | Core Clock | Mem Clock |
|-----------------------------------|-------------|-------------|------------|-----------|
| [1] MSI 3080 GAMING X TRIO        | 106%        | 65C         | -502MHz    | +825Mhz   |
| [2] ASUS 3080 ROG STRIX GAMING OC | 67%         | 65C         | -502MHz    | +800Mhz   |
| [3] MSI 3080 VENTUS 10G OC        | 77%         | 65C         | -502MHz    | +800Mhz   |
| [4] MSI 3080 GAMING X TRIO        | 106%        | 65C         | -502MHz    | +825Mhz   |

## c. Kết quả thu được

| No. VGA                           | Power Consumption | Hashrate   | GPU Temperature | Memory Temperature |
|-----------------------------------|-------------------|------------|-----------------|--------------------|
| [1] MSI 3080 GAMING X TRIO        | 235 Walt          | 95.436MH/s | 58C             | 98C                |
| [2] ASUS 3080 ROG STRIX GAMING OC | 248 Walt          | 95.474MH/s | 58C             | 96C                |
| [3] MSI 3080 VENTUS 10G OC        | 246 Walt          | 95.443MH/s | 62C             | 94C                |
| [4] MSI 3080 GAMING X TRIO        | 235 Walt          | 95.436MH/s | 58C             | 98C                |
