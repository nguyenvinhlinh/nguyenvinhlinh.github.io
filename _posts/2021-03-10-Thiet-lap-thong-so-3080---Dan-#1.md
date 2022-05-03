---
layout: post
title: "Thiết lập thông số 3080 - Dàn #1 Thanh Long"
date: 2021-03-10 15:51:00
tags: mining
update: 2022-05-04 00:14:00
location: Saigon
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

# II. Ethereum - MSI Afterburner - 95MH/s

Mức thiết lập này được tinh chỉnh hoàn toàn trên **MSI Afterburner**. Có thể sử dụng cách này kết hợp với lệnh `nvidia-smi` để hỗ trợ việc overclock.

## a. Tinh chỉnh tốc độ quạt theo nhiệt độ
- 30C -->  40% Fan
- 50C -->  80% Fan
- 60C -->  90% Fan
- 65C --> 100% Fan

{% include image.html url="/image/posts/2021-03-10-Thiet-lap-thong-so-3080---Dan-1/2.png" description="[2] Tinh chỉnh tốc độ quạt" %}


## b. Tinh chỉnh MSI Afterburner

| No. VGA                           | Power Limit | Temp. Limit | Core Clock | Mem Clock |
|-----------------------------------|-------------|-------------|------------|-----------|
| [1] MSI 3080 GAMING X TRIO        | 106%        | 65C         | -502MHz    | +825Mhz   |
| [2] ASUS 3080 ROG STRIX GAMING OC | 67%         | 65C         | -502MHz    | +800Mhz   |
| [3] MSI 3080 VENTUS 10G OC        | 77%         | 65C         | -502MHz    | +800Mhz   |
| [4] MSI 3080 GAMING X TRIO        | 106%        | 65C         | -502MHz    | +825Mhz   |

## c. Kết quả thu được

| No. VGA                           | Power Consumption | Hashrate        | GPU Temperature | Memory Temperature |
|-----------------------------------|-------------------|-----------------|-----------------|--------------------|
| [1] MSI 3080 GAMING X TRIO        | 235 Walt          | 95.436MH/s      | 58C             | 98C                |
| [2] ASUS 3080 ROG STRIX GAMING OC | 248 Walt          | 95.474MH/s      | 58C             | 96C                |
| [3] MSI 3080 VENTUS 10G OC        | 246 Walt          | 95.443MH/s      | 62C             | 94C                |
| [4] MSI 3080 GAMING X TRIO        | 235 Walt          | 95.436MH/s      | 58C             | 98C                |
|                                   |                   |                 |                 |                    |
| **Total**                         | **964 Walt**      | **381.789MH/s** | --              | --                 |


# III. Ethereum - Minerstat - 95MH/s

Đây là thiết lập sử dụng trong **Minerstat**, khi sử dụng các thiết lập này, hoàn toàn không cần thiết sử dụng **MSI Afterburner**.
Lợi thế nhiều nhất sử dụng thiết lập này là lượng điện tiêu thụ ít hơn hẳn so với **MSI Afterburner**, tầm 50 Walt, lý do là vì `gpu-clock`
tinh chỉnh ở mức thấp hơn mức cho phép trên **MSI Afterburner** (nhỏ nhất là -502MHz).

## a. Tinh chỉnh ClockTune
- Mode: Built-in (Default)
- Power Limit (%): skip
- Core Clock (-/+ MHz): skip
- Locked Memory Clock (MHz): skip
- Force P2 State: skip
- ClockTune delay: 30

| No | VGA                           | Power Limit (Walt) | Locked Core Clock (MHz) | Memory Clock (-/+ MHz) |
|----|-------------------------------|--------------------|-------------------------|------------------------|
| 1  | MSI 3080 GAMING X TRIO        | 392                | 1170                    | 825                    |
| 2  | ASUS 3080 ROG STRIX GAMING OC | 240                | 1170                    | 800                    |
| 3  | MSI 3080 VENTUS 10G OC        | 240                | 1170                    | 800                    |
| 4  | MSI 3080 GAMING X TRIO        | 392                | 1170                    | 825                    |

## b. Triggers trong Minerstat
- IF GPU temperature OF Any IS >=40°C THEN Set fans TO 60%
- IF GPU temperature OF Any IS >=50°C THEN Set fans TO 85%
- IF GPU temperature OF Any IS >=55°C THEN Set fans TO 90%
- IF GPU temperature OF Any IS >=60°C THEN Set fans TO 95%
- IF GPU temperature OF Any IS >=65°C THEN Set fans TO 100%

## c. Kết quả thu được

| No. VGA                           | Power Consumption | Hashrate         | GPU Temperature | Memory Temperature |
|-----------------------------------|-------------------|------------------|-----------------|--------------------|
| [1] MSI 3080 GAMING X TRIO        | 224 Walt          | 96.128 MH/s      | 51C             | 98C                |
| [2] ASUS 3080 ROG STRIX GAMING OC | 239 Walt          | 95.574 MH/s      | 52C             | 96C                |
| [3] MSI 3080 VENTUS 10G OC        | 228 Walt          | 95.878 MH/s      | 55C             | 96C                |
| [4] MSI 3080 GAMING X TRIO        | 224 Walt          | 96.096 MH/s      | 48C             | 90C                |
|                                   |                   |                  |                 |                    |
| **Total**                         | **915 Walt**      | **383.676 MH/s** | --              | --                 |

{% include image.html url="/image/posts/2021-03-10-Thiet-lap-thong-so-3080---Dan-1/3.png" description="[3] MinerStat" %}

# II. Mức thiết lập - Kaspa - 835MH/s
Tinh chỉnh quạt sẽ giống như cho Ethereum

## a. Tinh chỉnh **MSI Afterburner**

| No. VGA                           | Power Limit | Temp. Limit | Core Clock | Mem Clock |
|-----------------------------------|-------------|-------------|------------|-----------|
| [1] MSI 3080 GAMING X TRIO        | --          | 65C         | +170Mhz    | -502MHz   |
| [2] ASUS 3080 ROG STRIX GAMING OC | --          | 65C         | +170Mhz    | -502MHz   |
| [3] MSI 3080 VENTUS 10G OC        | --          | 65C         | +170Mhz    | -502MHz   |
| [4] MSI 3080 GAMING X TRIO        | --          | 65C         | +170Mhz    | -502MHz   |

## b. Tinh chỉnh thêm với  **nvidia-smi**
Mục tiêu là giảm memory clock xuống thấp hơn nữa, thấp hơn cả mức chỉnh trên **MSI Afterburner**. Nếu sử dụng phương án này thì chỉ cần quan tâm đến
chỉnh quạt trên **MSI Afterburner** mà thôi. Powerlimit cũng sẽ không cần quan tâm.
{% highlight cmd %}
nvidia-smi --lock-memory-clocks 800 --lock-gpu-clocks 1900
{% endhighlight %}

Để reset overclock settings chaỵ lệnh sau:
{% highlight cmd %}
nvidia-smi --reset-gpu-clocks --reset-memory-clocks
{% endhighlight %}

## c. Kết quả thu được

| No. VGA                           | Power Consumption | Hashrate     | GPU Temperature | Memory Temperature |
|-----------------------------------|-------------------|--------------|-----------------|--------------------|
| [1] MSI 3080 GAMING X TRIO        | 211 Walt          | 837.96MH/s   | 56C             | 56C                |
| [2] ASUS 3080 ROG STRIX GAMING OC | 235 Walt          | 838.56MH/s   | 56C             | 58C                |
| [3] MSI 3080 VENTUS 10G OC        | 217 Walt          | 839.68MH/s   | 59C             | 58C                |
| [4] MSI 3080 GAMING X TRIO        | 219 Walt          | 838.01MH/s   | 52C             | 52C                |
|                                   |                   |              |                 |                    |
| **Total**                         | **892 Walt**      | **3.35GH/s** | --              | --                 |
