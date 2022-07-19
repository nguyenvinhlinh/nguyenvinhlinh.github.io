---
layout: post
title: "Cách sửa lỗi Microsoft Teams: “We're sorry—we've run into an issue.”"
date: 2022-07-19 12:04:00
tags:
- Window 10
- Microsoft Teams
categories:
- Window
seo_description: "Cách sửa lỗi Microsoft Teams: We're sorry—we've run into an issue."
seo_image: /image/posts/2022-07-19-Cach-sua-loi-Microsoft-Teams/1.png
comments: true
---

Tôi gặp vấn đề khó chịu này khi sử dụng cùng lúc 2 tài khoản Microsoft Teams trên Window 10. Lỗi này xảy ra khi tôi
chuyển đổi giữa hai account. Để khắc phục vấn đề này các bạn hãy làm như sau.

{% include image.html url="/image/posts/2022-07-19-Cach-sua-loi-Microsoft-Teams/1.png" description="[1] We're sorry—we've run into an issue." %}.

Tôi gặp vấn đề khó chịu này khi sử dụng cùng lúc 2 tài khoản Microsoft Teams trên Window 10.
Lỗi này xảy ra khi tôi chuyển đổi giữa hai account. Để khắc phục vấn đề này các bạn hãy làm như sau.


## Bước 1: Vào `%LocalAppData%\Microsoft\Teams\current`

`LocalAppData` là enviroment variable có giá trị chính là `C:\Users\nguye\AppData\Local\`
Tùy vào tên username mà giá trị này có thể thay đổi. Tuy nhiên khi paste
`%LocalAppData%\Microsoft\Teams\current` vào **File Explorer**, **File Explorer** sẽ tự trỏ vào thư mục cần thiết.

{% include image.html url="/image/posts/2022-07-19-Cach-sua-loi-Microsoft-Teams/2.png" description="[2] File Explorer" %}

## Bước 2: Chỉnh `compatibility mode` của file `Teams.exe` thành `Window 8`.

{% include image.html url="/image/posts/2022-07-19-Cach-sua-loi-Microsoft-Teams/3.png" description="[3] Teams.exe Properties" %}

Đã xong, và tận hưởng.
