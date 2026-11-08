---
layout: post
title: "Cách build Monero GUI"
date: 2026-11-08 17:19:14
update:
location: Saigon
tags:
- Linux
- Fedora
- Monero
categories:
- Cryptocurrency Node
seo_description: Build Monero GUI với Fedora
seo_image: /image/posts/2026-11-08-Cach-build-Monero-GUI/seo.png
comments: true
---

## I. Mở đầu
Nối tiếp bài viết [Cách build Monero](), bài viết này tập trung nói về cách build [Monero-GUI](https://github.com/monero-project/monero-gui), release [v0.18.5.4](https://github.com/monero-project/monero-gui/tree/v0.18.5.4).
Sau khi build xong, bạn sẽ sử dụng Monero GUI dễ dàng hơn. Ở phiên bản này, vẫn đang sử dụng là `QT5` cho giao diện GUI. Ở phiên bản kế tiếp sẽ là `QT6`

## II. Nội dung

### Bước 1: Cài đặt các thư viện liên quan
```
$ sudo dnf install make automake cmake ninja gcc-c++ boost-devel graphviz doxygen unbound-devel pkgconfig openssl-devel libcurl-devel hidapi-devel libusb-devel zeromq-devel libgcrypt-devel
```

Cái này dành cho `qt5`, khi `monero-gui` chuyển qua `qt6`, sẽ không chạy command sau:
```
$ sudo dnf install qt5-qtdeclarative-devel qt5-qtsvg-devel
```

### Bước 2: Clone source code & repository phụ

```sh
$ git clone --recursive git@github.com:monero-project/monero-gui.git
$ git checkout v0.18.5.4
$ git submodule update --init --recursive
```

Ở lần build tới, để update các repository phụ, chạy command sau:
```
$ git submodule update --init --recursive
```

### Bước 3: Build

```
$ make release
```

Và đây là kết quả thu được.
```sh
$ tree build/release/bin
build/release/bin
├── monerod
└── monero-wallet-gui
```

Khi bạn chạy `monero-wallet-gui`, mọi config của bạn bao gồm nơi chứa `wallet` và `node` nằm ở `~/.config/monero-project/monero-core.conf`. Mỗi khi chạy lại, `monero-wallet-gui` sẽ đọc file này.

Bài viết đến đây là kết thúc! Nhân tiện thì giả sử bạn đang cần giao dịch ngay mà không muốn mất thời gian đồng bộ hóa giữ liệu. Bạn có thể sử dụng node của tôi: `monero.hexalink.xyz:18081`.

{% include image.html url="/image/posts/2026-11-08-Cach-build-Monero-GUI/1.png" description="Node: monero.hexalink.xyz || Port: 18081" %}

Nếu bạn sử dụng node `monero.hexalink.xyz:18081` này, tôi khẳng định là tôi mới giúp bạn tiết kiệm được ít nhất là 3-5 ngày đồng bộ hóa dữ liệu rồi đó!
