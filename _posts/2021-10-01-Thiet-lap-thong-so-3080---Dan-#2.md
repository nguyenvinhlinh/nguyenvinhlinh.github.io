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

|------------------|-----------------------------|----------------|
| Vị Trí trên main | VGA                         | Vị trí trên OS |
|------------------|-----------------------------|----------------|
| 1                | MSI 3080 GAMING X TRIO      | 3              |
| 2                | MSI 3080 VENTUS             | 1              |
| 3                | MSI 3080 VENTUS             | 2              |
| 4                | GIGABYTE 3080 GAMING OC 10G | 4              |
|------------------|-----------------------------|----------------|

{% include image.html url="/image/posts/2021-10-01-Thiet-lap-thong-so-3080---Dan-2/1.jpg" description="[1] Dàn 3080 - #2 Bạch Hổ" %}

# II. Mức thiết lập - 95MH/s
## a. Tinh chỉnh tốc độ quạt theo nhiệt độ
- 30C -->  40% Fan
- 50C -->  60% Fan
- 60C -->  85% Fan
- 65C --> 100% Fan

{% include image.html url="/image/posts/2021-10-01-Thiet-lap-thong-so-3080---Dan-2/2.jpg" description="[2] Tinh chỉnh tốc độ quạt" %}

## b. MSI 3080 GAMING X TRIO
- Power Limit: 105%
- Temperature Limit: 65C
- Core Clock: -502Mhz
- Memory Clock: 825Mhz
- Fan: User define - Auto

Kết quả thu được:
- Hashrate: 95.436MH/s
- Công suất: 235W
- Nhiệt độ GPU: 58C
- Nhiệt độ VRAM: 98C

## c. MSI 3080 VENTUS
- Power Limit: 77%
- Temperature Limit: 65C
- Core Clock: -502Mhz
- Memory Clock: 800Mhz
- Fan: User define - Auto

Kết quả thu được:
- Hashrate: 95.426MH/s
- Công suất: 238W
- Nhiệt độ GPU: 61C
- Nhiệt độ VRAM: 110C

## c. GIGABYTE 3080 OC
- Power Limit: 64%
- Temperature Limit: 65C
- Core Clock: -502 Mhz
- Memory Clock: 850Mhz
- Fan: User define - Auto

Kết quả thu được:
- Hashrate: 96.013MH/s
- Công suất: 237W
- Nhiệt độ GPU: 61C
- Nhiệt độ VRAM: 84C
