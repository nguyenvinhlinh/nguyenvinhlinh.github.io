---
layout: post
title: "Cách thiết lập GPG cho Emacs trên Window"
date: 2021-09-01 11:07:00 +0700
tags:
- emacs
- gpg
- window
categories: Emacs
comments: false
---

Bài viết này hướng dẫn cách cài đặt GPG cho emacs trên window. Đầu tiên, cần vào trang web [https://gnupg.org/download/index.html](https://gnupg.org/download/index.html) và tải `Gpg4Win`

{% include image.html url="/image/posts/2021-08-01-Cach-configure-gpg-cho-emacs-tren-window/1.png" description="[1] Download Gpg4Win" %}

Sau khi cài đặt xong Gpg4Win. Trong emacs, thiết lập các biến sau:
- epg-gpg-home-directory
- epg-gpg-program
- epg-gpgconf-program


Ví dụ như sau:
```elisp
(custom-set-variables
 '(epg-gpg-home-directory "C:/Users/nguye/AppData/Roaming/gnupg")
 '(epg-gpg-program "D:/Software/GnuPG/bin/gpg.exe")
 '(epg-gpgconf-program "D:/Software/GnuPG/bin/gpgconf.exe")
 )

(provide 'window-gpg)
```
