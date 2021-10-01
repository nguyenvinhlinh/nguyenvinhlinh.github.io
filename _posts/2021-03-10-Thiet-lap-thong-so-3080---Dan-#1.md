---
layout: post
title: "Thiết lập thông số 3080 - Dàn #1 Thanh Long"
date: 2021-03-10 15:51:00
tags: mining
categories:
- Mining Rig
---
# I. Lời mở đầu

Bài viết này phục vụ mục đích duy nhất là đó là nếu tôi lỡ tay xóa mấy profile trên MSI Afterburner. Tôi sẽ quay lại đây xem. Hiện tại đây là 4 VGA trực thuộc dàn #1

- MSI 3080 VENTUS 10G OC (1 cái)
- MSI 3080 GAMING X TRIO (2 cái)
- ASUS 3080 ROG STRIX GAMING OC (1cái)

{% include image.html url="/image/posts/2021-03-10-Thiet-lap-thong-so-3080---Dan-1/1.jpg" description="[1] Dàn 3080 - #1" %}

# II. Mức thiết lập - 95MH/s
## a. Tinh chỉnh tốc độ quạt theo nhiệt độ
{% include image.html url="/image/posts/2021-10-01-Thiet-lap-thong-so-3080---Dan-2/2.jpg" description="[2] Tinh chỉnh tốc độ quạt" %}

## b. MSI 3080 VENTUS 10G OC
- Power Limit: 77%
- Temperature Limit: 65C
- Core Clock: -502Mhz
- Memory Clock: 800MHz
- Fan: User define - Auto

Kết quả thu được:

- Hashrate: 95.443MH/s
- Công suất: 246Walt
- Nhiệt độ GPU: 62C
- Nhiệt độ VRAM: 94C


## c. MSI 3080 GAMING X TRIO
- Power Limit: 106%
- Temperature Limit: 65C
- Core Clock: -502Mhz
- Memory Clock: 825Mhz
- Fan: User define - Auto

Kết quả thu được:
- Hashrate: 95.436MH/s
- Công suất: 235W
- Nhiệt độ GPU: 58C
- Nhiệt độ VRAM: 98C


## d. ASUS 3080 ROG STRIX GAMING OC
- Power Limit: 67%
- Temperature Limit: 65C
- Core Clock: -502Mhz
- Memory Clock: 800Mhz
- Fan: User define - Auto

Kết quả thu được:
- Hashrate: 95.474MH/s
- Công suất: 248W
- Nhiệt độ GPU: 58C
- Nhiệt độ VRAM: 96C
