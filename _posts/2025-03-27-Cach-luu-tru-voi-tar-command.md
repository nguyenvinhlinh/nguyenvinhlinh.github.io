---
layout: post
title: "Cách lưu trữ với tar command"
date: 2025-03-27 09:58:40
update:
location: Saigon
tags:
- Linux
- tar
- cheatsheet
categories: cheatsheet
seo_description: Cheatsheet để nhớ cách archive‌‌/compress/extract file, thư mục với command tar.
seo_image:
comments: true
---
Xin chào, khi tôi quyết định viết bài này, tôi buộc lòng phải thừa nhận, tôi không thể nhớ command cũng như các tham số của tar. Bài viết này là dành cho tôi xem lại sử dụng lệnh `tar`.

# 1. Cách tạo lưu trữ (archive) và nén

```shell
$ tar -cJvf file_name.tar.xz directory_full_path
```

Giải thích các tham số:
- `-c`: tạo archive‌/lưu trữ
- `-J`: nén với định dạng xz
- `-v`: verbose, hiện thông tin chi tíết khi chạy lệnh
- `-f`: tên file `file_name.tar.xz`


# 2. Cách mở lưu trữ (extract)

```shell
$ tar -xvf file_name.tar.xz
```
Giải thích các tham số:
- `-x`: extract, mở lưu trữ
- `-v`: verbose, hiện thông tin chi tíết khi chạy lệnh
- `-f`: tên file `file_name.tar.xz`
