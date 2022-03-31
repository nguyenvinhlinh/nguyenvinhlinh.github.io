---
layout: post
title: "Cách chỉ định IP sẽ bị định tuyến qua VPN"
date: 2022-03-30 11:34:06
tags:
- network
- vpn
categories:
- Linux
seo_description:
seo_image: /image/posts/2022-03-30-Cach-chi-dinh-IP-se-bi-dinh-tuyen-qua-VPN/1.png
comments: true
---

Ở bài viết này, chúng ta sẽ mặc định là VPN đã được kết nối thành công. Vấn đề bây h là làm sao để quá trình định tuyến sẽ chỉ và chỉ sử dụng
VPN khi bị yêu cầu đến một IP nhất định. Để hiểu rõ hơn, hãy nhìn hình minh họa sau.

{% include image.html url="/image/posts/2022-03-30-Cach-chi-dinh-IP-se-bi-dinh-tuyen-qua-VPN/1.png" description="[1] Mô hình network" %}

Ví dụ cụ thể ở đây là máy tính của tôi muốn `ping 192.168.1.200` và tôi muốn rằng **chỉ có IP** `192.168.1.200` là sẽ chạy qua VPN, những yêu cầu
khác ví dụ như đến `192.168.1.4` sẽ không có thông qua VPN. `192.168.1.4` sẽ phải được định tuyền trong mạng nội bộ.

Để làm được điều trên, đầu tiên cần phải xác định được **vpn network adapter** với lệnh `ifconfig`.
Lý do cần tìm **vpn network adapter** là để tìm:

- Netmask
- Gateway

Sau khi gõ lệnh `ifconfig`, **vpn network adapter** sẽ có thể trông như sau:

``` text
ppp0: flags=4305<UP,POINTOPOINT,RUNNING,NOARP,MULTICAST>  mtu 1400
        inet 192.168.1.21  netmask 255.255.255.255  destination 192.168.1.1
        ppp  txqueuelen 3  (Point-to-Point Protocol)
        RX packets 19  bytes 1241 (1.2 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 80  bytes 30120 (29.4 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

Dựa vào thông tin trên, ta thu được:

- Netmask: 255.255.255.255
- Gateway: 192.168.1.1 (chính là giá trị destination)




Tiếp theo, vào **Setting > Network** , chọn tùy chỉnh kết nối VPN. Lưu ý phần **Routes**, những thông số cần chỉnh bao gồm

- Address (192.168.1.200)
- Netmask (255.255.255.255)
- Gateway (192.168.1.1)
- Tick chọn **use this connection only for resources on its network**

Sau khi tinh chỉnh xong, tắt và mở lại VPN. Cuối cùng là tận hưởng thành quả.

{% include image.html url="/image/posts/2022-03-30-Cach-chi-dinh-IP-se-bi-dinh-tuyen-qua-VPN/2.png" description="[2] VPN Routes" %}

Đây là terminal trước khi tỉnh chỉnh, lúc này chưa có ping được `192.168.1.200`
{% highlight sh %}
➜ ~ ping 192.168.1.200
PING 192.168.1.200 (192.168.1.200) 56(84) bytes of data.
From 192.168.1.5 icmp_seq=1 Destination Host Unreachable
From 192.168.1.5 icmp_seq=2 Destination Host Unreachable
From 192.168.1.5 icmp_seq=3 Destination Host Unreachable
{% endhighlight %}

Và đây là terminal sau khi tinh chỉnh, lúc này đã ping được 192.168.1.200
{% highlight sh %}
➜ ~ ping 192.168.1.200
PING 192.168.1.200 (192.168.1.200) 56(84) bytes of data.
64 bytes from 192.168.1.200: icmp_seq=1 ttl=63 time=6.52 ms
64 bytes from 192.168.1.200: icmp_seq=2 ttl=63 time=4.45 ms
64 bytes from 192.168.1.200: icmp_seq=3 ttl=63 time=4.99 ms
64 bytes from 192.168.1.200: icmp_seq=4 ttl=63 time=4.95 ms
{% endhighlight %}
