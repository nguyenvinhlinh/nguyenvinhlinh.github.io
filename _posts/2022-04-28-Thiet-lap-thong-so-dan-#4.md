---
layout: post
title: "Thiết lập thông số 170HX - Dàn #4 Huyền Vũ"
date:   2022-04-28 00:41:00 +0700
update: 2022-05-03 17:24:00 +0700
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

Trong những thiết bị đào tôi đã từng có cơ hội thử qua, hai vga `[1] 170HX` và `[3] LEADTEK WinFast RTX 3080 AI BLOWER 10G`
trong dàn này cực kì nhạy cảm với nhiệt độ, tôi đã mod, tuy nhiên là chưa đủ. Để làm hoàn thiện sẽ cần đầu tư nhiều hơn.
Ngoài ra thì `[2] MSI 3080 VENTUS 10G OC (FHR)` đã được tôi thay pad tản nhiệt **Gelid 2mm**  và tra lại keo **Noctua NT-H2**.

{% include image.html url="/image/posts/2022-04-28-Thiet-lap-thong-so-dan-4.md/1.jpg" description="Dàn Huyền Vũ" %}

| No | VGA                                    |
|----|----------------------------------------|
| 1  | 170HX                                  |
| 2  | MSI 3080 VENTUS 10G OC (FHR)           |
| 3  | LEADTEK WinFast RTX 3080 AI BLOWER 10G |

# II. Ethereum - 345 MH/s

## a. Thiết lập với MSI Afterburner

| No | VGA                                    | Power Limit    | Temp. Limit | +/- Core Clock | +/- Mem Clock |
|----|----------------------------------------|----------------|-------------|----------------|---------------|
| 1  | 170HX                                  | 88%            | --          | --             | --            |
| 2  | MSI 3080 VENTUS 10G OC (FHR)           | 75% (priority) | 65C         | -502 MH/s      | +950 MH/s     |
| 3  | LEADTEK WinFast RTX 3080 AI BLOWER 10G | 70% (priority) | 65C         | -502 MH/s      | 0             |


## b. Kết quả thu được

| No | VGA                                    | Power Consumption | Hashrate         | GPU Temp. | Memory Temp. |
|----|----------------------------------------|-------------------|------------------|-----------|--------------|
| 1  | 170HX                                  | 219 Walt          | 163.153 MH/s     | 65C       | 84C          |
| 2  | MSI 3080 VENTUS 10G OC (FHR)           | 239 Walt          | 96.726 MH/s      | 58C       | 84C          |
| 3  | LEADTEK WinFast RTX 3080 AI BLOWER 10G | 223 Walt          | 86.414 MH/s      | 60C       | 102C         |
|    |                                        |                   |                  |           |              |
|    | **Total**                              | **681 Walt**      | **346.293 MH/s** | --        | --           |

{% include image.html url="/image/posts/2022-04-28-Thiet-lap-thong-so-dan-4.md/2.png" description="[2] Minerstat" %}
