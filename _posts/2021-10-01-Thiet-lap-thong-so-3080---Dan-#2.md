---
layout: post
title: "Thiết lập thông số 3080 - Dàn #2 Bạch Hổ"
date: 2021-10-01 11:31:00
tags: mining
categories:
- Mining Rig
---
# I. Lời mở đầu

Bài viết này phục vụ mục đích duy nhất là đó là nếu tôi lỡ tay xóa mấy profile trên MSI Afterburner. Tôi sẽ quay lại đây xem.

- MSI 3080 GAMING X TRIO (1 cái)
- MSI 3080 VENTUS (2 cái)
- GIGABYTE 3080 GAMING OC 10G (1 cái)


| Vị Trí trên main | VGA                         | Vị trí trên OS |
|------------------|-----------------------------|----------------|
| 1                | MSI 3080 GAMING X TRIO      | 3              |
| 2                | MSI 3080 VENTUS             | 1              |
| 3                | MSI 3080 VENTUS             | 2              |
| 4                | GIGABYTE 3080 GAMING OC 10G | 4              |


{% include image.html url="/image/posts/2021-10-01-Thiet-lap-thong-so-3080---Dan-2/1.jpg" description="[1] Dàn 3080 - #2 Bạch Hổ" %}

# II. Mức thiết lập - 95MH/s
## a. Tinh chỉnh tốc độ quạt theo nhiệt độ
- 30C -->  40% Fan
- 50C -->  80% Fan
- 60C -->  90% Fan
- 65C --> 100% Fan

{% include image.html url="/image/posts/2021-10-01-Thiet-lap-thong-so-3080---Dan-2/2.jpg" description="[2] Tinh chỉnh tốc độ quạt" %}

## b. Tinh chỉnh MSI Afterburner

| No. VGA                         | Power Limit | Temp. Limit | Core Clock | Mem Clock |
|---------------------------------|-------------|-------------|------------|-----------|
| [1] MSI 3080 VENTUS             | 77%         | 65C         | -502MHz    | +900Mhz   |
| [2] MSI 3080 VENTUS             | 77%         | 65C         | -502MHz    | +900Mhz   |
| [3] MSI 3080 GAMING X TRIO      | 106%        | 65C         | -502MHz    | +900Mhz   |
| [4] GIGABYTE 3080 GAMING OC 10G | 64%         | 65C         | -502MHz    | +900Mhz   |

## c. Kết quả thu được

| No. VGA                         | Power Consumption | Hashrate  | GPU Temperature | Memory Temperature |
|---------------------------------|-------------------|-----------|-----------------|--------------------|
| [1] MSI 3080 VENTUS             | 246W              | 96.50Mh/s | 61C             | 90C                |
| [2] MSI 3080 VENTUS             | 246W              | 96.01Mh/s | 64C             | 90C                |
| [3] MSI 3080 GAMING X TRIO      | 229W              | 94.70MH/s | 62C             | 106C               |
| [4] GIGABYTE 3080 GAMING OC 10G | 236W              | 95.51Mh/s | 65C             | 90C                |
