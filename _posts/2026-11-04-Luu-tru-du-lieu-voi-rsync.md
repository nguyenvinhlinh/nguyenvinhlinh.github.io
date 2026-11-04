---
layout: post
title: "Lưu trữ dữ liệu với rsync"
date: 2026-11-04 14:19:35
update:
location: Saigon
tags:
- etc
- linux
- rsync
categories: Linux
seo_description: Rsync - Nó quá đơn giản, nó quá dễ dàng. Nhưng tôi không thể nhớ được nó.
seo_image: /image/posts/2026-11-04-Luu-tru-du-lieu-voi-rsync/seo.jpg
comments: true
---

## 1. Mở đầu
Tôi cần phải nói là tôi không bao giờ nghĩ đến việc mình sẽ viết blog về chủ đề này.

`Rsync` - Nó quá đơn giản, nó quá dễ dàng.

Nhưng mà mỗi lần đụng đến `rsync`, tôi đều phải `rsync --help` hoặc tệ hơn là dùng `chatgpt`. Tôi
luôn đặt ra những ranh giới cho chính mình khi nào cần và khi nào không cần dùng đến chatgpt.
Và tôi cảm giác thật là con người khi làm như vậy.

Nói sơ qua một chút thì `rsync` là một command dùng để sao lưu dữ liệu. Tôi đang có nhu cầu sao lưu
dữ liệu của bitcoin knots (Bitcoin Blake2B). Việc này sẽ giúp tôi giảm thời gian khi triển khai node mới.

{% include image.html url="/image/posts/2026-11-04-Luu-tru-du-lieu-voi-rsync/1.jpg" description="[1] Sao lưu bitcoin" %}

## 2. Nội dung

```sh
$ rsync --archive --human-readable --info=progress2 \
  /mnt/disk_2/CryptoCurrency/Bitcoin_knots/ \
  /mnt/disk_2/CryptoCurrency/Bitcoin_knots_height_980396
```

Tôi sẽ giải thích các flag:
- `--archive`: chế độ lưu trữ, nó là tổng hợp của rất nhiều flag. ([xem kỹ ở đây](https://linux.die.net/man/1/rsync))
- `--human-readable`: khi show log, dữ liệu dễ đọc hơn
- `--info=progress2`: hiển thị progress với phần trăm

Lưu ý:
- Path của thư mục gốc `SRC` `/mnt/disk_2/CryptoCurrency/Bitcoin_knots/` sẽ cần `/` ở cuối nếu mục đích là copy toàn bộ nội dung của nó đến thư mục đích đến `DEST`.
- Nếu mà không có `/` ở cuối của `SRC`, `rsync` sẽ tạo thư mục con có tên là `Bitcoin_knots` nằm bên trong `DEST`.
