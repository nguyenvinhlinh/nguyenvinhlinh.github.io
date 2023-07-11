---
layout: post
title: "CSGO, binding để nhảy ném smoke"
date: 2021-09-15 12:52:39 +0700
tags: csgo
categories: CSGO
---

Trong trường hợp này phím nhảy ném là phím `mouse-5`. Mở console lên và gõ lệnh sau:

```sh
alias +jumpthrow "+jump;-attack";
alias -jumpthrow "-jump";
bind mouse5 +jumpthrow;
```

Cách sử dụng tương đối đơn giản, bắt đầu bằng giữ chuột trái, tiếp theo là căn góc ném, cuối cùng là ấn phím `mouse-5`.
