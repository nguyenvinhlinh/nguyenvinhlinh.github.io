---
layout: post
title: "So sánh các loại HDD của Western Digital(repost)"
date: 2026-10-12 15:31:56
update:
location:
tags:
- HDD
categories: etc
seo_description: Danh sách tất cả các loại HDD của Western Digital
seo_image: /image/posts/2026-10-12-So-sanh-cac-loai-HDD-Western-Digital/seo_1200x630px.avif
comments: true
---

{% include image.html url="/image/posts/2026-10-12-So-sanh-cac-loai-HDD-Western-Digital/1.avif" description="[1] danh sách HDD của Western Digital" %}

Chú thích:
- `CMR (Conventional Magnetic Recording)`: Ghi từ tính thông thường
- `SMR (Shingled Magnetic Recording)`: Ghi từ tính kiểu lợp ngói

| Tiêu chí           | CMR                             | SMR                                       |
|--------------------|---------------------------------|-------------------------------------------|
| Tên đầy đủ         | Conventional Magnetic Recording | Shingled Magnetic Recording               |
| Cách bố trí track  | Không chồng lấn                 | Chồng lấn một phần                        |
| Mật độ lưu trữ     | Thấp hơn                        | Cao hơn                                   |
| Ghi tuần tự        | Tốt                             | Tốt                                       |
| Ghi ngẫu nhiên     | Tốt                             | Chậm hơn                                  |
| Ghi đè dữ liệu     | Tốt                             | Chậm hơn                                  |
| Giá trên mỗi TB    | Cao hơn                         | Rẻ hơn                                    |
| Ứng dụng điển hình | NAS, máy chủ, workload hỗn hợp  | Backup, lưu trữ lạnh, dữ liệu ít thay đổi |

`SMR` do thiết kế theo kiểu lợp ngói, các rãnh từ bị chồng lấn(1), đầu ghi thì lớn(2). Hai nguyên nhân trên gây ảnh hưởng không tốt đến quá trình ghi dữ liệu.

Khi `ghi` dữ liệu trên `một rãnh từ tính`, việc này hoàn toàn có thể làm `sai dữ liệu ở các rãnh từ tính lân cận`.

Rãnh từ tính xếp lớp, đầu ghi thì lại to. Chỉ cần ghi dữ liệu trên `một rãnh từ tính`, HDD thực tế phải ghi dữ liệu trên `hai rãnh lân cận`, nhằm đảm bảo độ chính xác 🥲!

Tóm tắt lại thì nếu mà mua ổ đĩa làm NAS, 100% là nên chọn `CMR - Conventional Magnetic Recording` 👨🏻‍🔧.


## References
- WD Colours Hard Drive Buyers Guide 2022-2023, 13 December 2022,[https://nascompares.com/2022/12/21/wd-colours-hard-drive-buyers-guide-2022-2023/](https://nascompares.com/2022/12/21/wd-colours-hard-drive-buyers-guide-2022-2023/)
- Chatgpt, [https://chatgpt.com](https://chatgpt.com)
