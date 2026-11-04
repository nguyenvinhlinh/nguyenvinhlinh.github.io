---
layout: post
title: "Cách test tốc độ mạng nội bộ với iperf3"
date: 2026-11-04 22:29:28
update:
location: Saigon
tags:
- linux
- iperf3
- network

categories: Linux
seo_description: Sử dụng iperf3 để test nhanh tốc độ truyền dữ liệu trong mạng nội bộ
seo_image: /image/posts/2026-11-04-Cach-test-toc-do-mang-giua-hai-may-tinh/seo.jpg
comments: true
---

# I. Mở đầu

Để test tốc độ mạng giữa các máy tính nội bộ, chúng ta hoàn toàn có thể cân nhắc sử dụng `iperf3`.

Tôi biết đến công cụ này khi đang tìm cách backup blockchain bitcoin. Thực sự mà nói, tốc độ copy data
từ máy tính cá nhân (client) đến máy NAS (server) khá là chậm.

Điều này khiển tôi phải thực sự kiểm tra network nội bộ của mình. Công cụ mà tôi sử dụng là `iperf3`.

Nó có sẵn trên máy NAS server ([Unraid OS](https://unraid.net/)) và cả trên ([Fedora](https://fedoraproject.org/)).
Thực sự là tôi chả cần phải cài gì thêm cả. Khá là tiện. 😙

# II. Nội dung

{% include image.html url="/image/posts/2026-11-04-Cach-test-toc-do-mang-giua-hai-may-tinh/1.jpg" description="[1] Mô hình truyền dữ liệu" %}

## Bước 1: Trên máy NAS Server, chạy `iperf3` ở chế độ server

Dựa theo hình vẽ trên, máy server có ip là `192.168.1.3`, chạy command sau:

```sh
$ iperf3 -s
# Command outputs
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
```

## Bước 2: Trên máy client, chạy `iperf3` ở chế độ client và kết nối đến server
Ở trên máy client, có ip là `192.168.1.2`, chạy command sau:
```sh
$ iperf3 -c 192.168.1.3
# Command outputs
Connecting to host 192.168.1.3, port 5201
[  5] local 192.168.2.5 port 60954 connected to 192.168.1.3 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  57.5 MBytes   482 Mbits/sec    0    317 KBytes
[  5]   1.00-2.00   sec   112 MBytes   936 Mbits/sec    0    445 KBytes
[  5]   2.00-3.00   sec   112 MBytes   936 Mbits/sec    0    469 KBytes
[  5]   3.00-4.00   sec   112 MBytes   941 Mbits/sec    0    492 KBytes
[  5]   4.00-5.00   sec   112 MBytes   938 Mbits/sec    0    492 KBytes
[  5]   5.00-6.00   sec   112 MBytes   940 Mbits/sec    0    492 KBytes
[  5]   6.00-7.00   sec  72.2 MBytes   606 Mbits/sec    0    492 KBytes
[  5]   7.00-8.00   sec  54.9 MBytes   460 Mbits/sec    0    492 KBytes
[  5]   8.00-9.00   sec  81.2 MBytes   682 Mbits/sec    0    492 KBytes
[  5]   9.00-10.00  sec   111 MBytes   933 Mbits/sec    0    519 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   936 MBytes   785 Mbits/sec    0    sender
[  5]   0.00-10.00  sec   934 MBytes   784 Mbits/sec         receiver
```

Dựa vào command trên, ta thấy được tốc độ upload dữ liệu lên server là `785 Mbits/sec`, tương đương với `98 MBytes/sec`.

Bài viết kết thúc, hi vọng giúp ai đó tiết kiệm 2 phút cuộc đời!

# 3. Trích dẫn
- iperf3: A TCP, UDP, and SCTP network bandwidth measurement tool, [https://github.com/esnet/iperf](https://github.com/esnet/iperf)
