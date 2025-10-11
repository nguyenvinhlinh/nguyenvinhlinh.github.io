---
layout: post
title: "Solo mining Bitcoin với cpuminer"
date: 2025-10-12 00:31:12
update:
location: Saigon
tags:
categories:
- Cryptocurrency Node
seo_description: Solo mining bitcoin không khó
seo_image: /image/posts/2025-10-12-Solo-mining-Bitcoin-with-cpuminer/seo.png
comments: true
---

Cách đây vài hôm, tôi đã tìm hiểu về bitcoin và việc làm dụng ô nhớ trên các giao dịch (tx). Tôi đã selfhost bitcoin
knots với các quy tắc khó chịu như:

- từ chối giao dịch có `OP_RETURN`
- từ chối giao dịch lạm dụng ô nhớ witness `Taproot`

Ở bài viết này, nó sẽ là hành trình tôi tự compile cpuminer - [https://github.com/pooler/cpuminer](https://github.com/pooler/cpuminer)
và đào solo bitcoin. Điều này nghĩa là tôi sẽ kết nối máy tính của tôi vào pool trực tiếp, nếu tôi đào được block. Block của tôi sẽ là
siêu sạch sẽ.

# 1. Build `cpuminer`
Hướng dẫn đã được đề cập chi tiết trong readme của repo. Xem ở đây: [https://github.com/pooler/cpuminer](https://github.com/pooler/cpuminer)

```sh
$ git clone https://github.com/pooler/cpuminer
$ cd cpuminer
$ ./autogen.sh
$ make
```

Khi build thành công, nó sẽ tạo ra file `minerd`. Phần mềm `minerd` sẽ có nhiệm vụ khai thác bitcoin.

# 2. Chạy `cpuminer`
Trước khi chạy, bạn có thể xem chi tiết cách dùng với lệnh `./cpuminer --help`

Đây là command mà tôi chạy:

```sh
./minerd --algo=sha256d --url=127.0.0.1:8332 --user=$USER --pass=$PASS \
         --coinbase-addr=$ADDRESS --coinbase-sig=hexalink.xyz   \
         --threads=28 -q
```

Giải thích:

- `--url`: đây là địa chỉ mà minerd sẽ call API, chỉ đơn giản là IP:PORT, mặc định là port `8332` nếu bạn không đổi gì ở file `bitcoin.conf`
khi triển khai node bitcoin.
- `--user` và `--pass`: hai cái này là giá trị của `--rpcuser` và `rpcpass` trong file `bitcoin.conf` (mặc định là không có, cần thay đổi và
khởi động lại bitcoin node)
- `--coinbase-addr`: địa chỉ ví, khi đào được block, bitcoin sẽ vào đây.
- `coinbase-sig`: gài coinbase signature để thiên hạ còn biết nếu tôi đào được 1 block nào đó.
- `threads`: số threads muốn sử dụng để khai thác. Xem tối đa với command `nproc`

Ngoài ra, có các flag quan trọng sau:

- `-q`: quite, yên lặng, không hiển thị báo hashrate trên terminal.
- `-P` hay `--protocol-dump`: Xem data lúc call API đến bitcoin node.
- `-D` hay `--debug`: Sử dụng khi cần debug

{% include image.html url="/image/posts/2025-10-12-Solo-mining-Bitcoin-with-cpuminer/1.png" description="Hình ảnh thực tế" %}
