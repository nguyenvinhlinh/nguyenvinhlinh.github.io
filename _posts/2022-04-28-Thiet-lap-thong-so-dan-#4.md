---
layout: post
title: "Thiết lập thông số dàn số 4 - Huyền Vũ"
date: 2022-04-28 00:41:00
update:
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
Tôi sẽ quay lại đây xem.

Trong những thiết bị đào tôi đã từng có cơ hội thử qua, hai thiết bị này cực kì nhạy cảm với nhiệt độ, tôi đã mod,
tuy nhiên là chưa đủ. Để làm hoàn thiện sẽ cần đầu tư nhiều hơn.

{% include image.html url="/image/posts/2022-04-28-Thiet-lap-thong-so-dan-4.md/1.jpg" description="Dàn Huyền Vũ" %}

| No | VGA                                    |
|----|----------------------------------------|
| 1  | 170HX                                  |
| 2  | LEADTEK WinFast RTX 3080 AI BLOWER 10G |

# II. Mức thiết lập - Ethereum - 234MH/s
Lưu ý là nhiệt độ phòng hiện tại là 27C.

## a. Thiết lập với MSI Afterburner

| No | VGA                                    | Power Limit | Temp. Limit | +/- Core Clock | +/- Mem Clock |
|----|----------------------------------------|-------------|-------------|----------------|---------------|
| 1  | 170HX                                  | 78%         | --          | --             | --            |
| 2  | LEADTEK WinFast RTX 3080 AI BLOWER 10G | 70%         | 65C         | -502 MH/s      | 0             |

## b. Kết quả thu được

| No | VGA                                    | Power Consumption | Hashrate        | GPU Temp. | Memory Temp. |
|----|----------------------------------------|-------------------|-----------------|-----------|--------------|
| 1  | 170HX                                  | 200 Walt          | 145.72 MH/s     | 65C       | 83C          |
| 2  | LEADTEK WinFast RTX 3080 AI BLOWER 10G | 221 Walt          | 86.10 MH/s      | 63C       | 104C         |
|    |                                        |                   |                 |           |              |
|    | **Total**                              | **421 Walt**      | **231.82 MH/s** | --        | --           |
