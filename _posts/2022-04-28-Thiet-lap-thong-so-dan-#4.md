---
layout: post
title: "Thiết lập thông số 170HX - Dàn #4 Huyền Vũ"
date: 2022-04-28 00:41:00
update: 2022-05-03 17:24:00
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

# II. Mức thiết lập - Ethereum - 333 MH/s
Thiết lập này sử dụng với phần mềm [Phoenix Miner 6.1b](https://bitcointalk.org/index.php?topic=2647654.0). Đánh giá
sơ bộ của tôi về **phoenix miner** đó là phần mềm này chưa khai thác hết khả năng của `170hx`, [T-Rex 0.25.12](https://github.com/trexminer/T-Rex/releases/tag/0.25.12)
nhanh hơn.

Tuy nhiên, **t-rex** lại gặp vấn đề trong việc giao tiếp với vga `[3]LEADTEK WinFast RTX 3080 AI BLOWER 10G` qua chân riser, sau một thời gian
đào, vga này sẽ bị lỗi `undefined` khi kiểm tra trên website `127.0.0.1:4068/trex` và không đào được, thậm chí lỗi này còn nặng đến mức,
tinh chỉnh trên **MSI Afterburner**  không có tác dụng, buộc phải restart lại cả máy đào.


## a. Thiết lập với MSI Afterburner

| No | VGA                                    | Power Limit | Temp. Limit | +/- Core Clock | +/- Mem Clock |
|----|----------------------------------------|-------------|-------------|----------------|---------------|
| 1  | 170HX                                  | 80%         | --          | --             | --            |
| 2  | MSI 3080 VENTUS 10G OC (FHR)           | 77%         | 65C         | -502 MH/s      | +800 MH/s     |
| 3  | LEADTEK WinFast RTX 3080 AI BLOWER 10G | 70%         | 65C         | -502 MH/s      | 0             |


## b. Kết quả thu được

| No | VGA                                    | Power Consumption | Hashrate         | GPU Temp. | Memory Temp. |
|----|----------------------------------------|-------------------|------------------|-----------|--------------|
| 1  | 170HX                                  | 199 Walt          | 151.098 MH/s     | 63C       | 84C          |
| 2  | MSI 3080 VENTUS 10G OC (FHR)           | 246 Walt          | 95.460 MH/s      | 60C       | 84C          |
| 3  | LEADTEK WinFast RTX 3080 AI BLOWER 10G | 223 Walt          | 87.304 MH/s      | 61C       | 102C         |
|    |                                        |                   |                  |           |              |
|    | **Total**                              | **668 Walt**      | **333.862 MH/s** | --        | --           |
