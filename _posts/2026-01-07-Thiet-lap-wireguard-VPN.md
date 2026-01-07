---
layout: post
title: "Cài đặt Wireguard VPN Server cho phép ping 2 chiều LAN <-> VPN"
date: 2026-01-07 12:13:36
update:
location: Saigon
tags:
- vpn
- wireguard
categories:
- Linux
seo_description: Thiết lập Wireguard VPN cho phép ping VPN client từ mạng LAN
seo_image: /image/posts/2026-01-07-Thiet-lap-wireguard-VPN/seo.png
comments: true
---

{% include image.html url="/image/posts/2026-01-07-Thiet-lap-wireguard-VPN/1.png" description="[1] Sơ đồ cơ bản" %}

Bài viết này tập trung giải quyết một vấn đề duy nhất: **Làm sao để máy tính trong mạng LAN có thể ping máy tính trong mạng VPN**. Cụ thể ở đây, trên sơ đồ chúng ta có:

- 1 Wireguard VPN server [wg-easy](https://github.com/wg-easy/wg-easy) đang được cài đặt ở máy tính `PC 1 - IP 192.168.1.2`.
- 2 VPN client `PC 3, PC 4` kết nối từ xa đến Wireguard VPN server
- `PC 3, PC 4` hoàn toàn có thể ping đến `PC 2 - IP 192.168.1.3` (`ping 192.168.1.3`)
- Nhưng `PC 2 IP 192.168.1.3` lại **KHÔNG THỂ PING** `PC 3, PC 4`

## Bước 1: Thiết lập Wireguard Server [wg-easy](https://github.com/wg-easy/wg-easy) với thiết lập mặc định
Cài đặt `wg-easy` sẽ sử dụng `docker`, `docker-compose`. Bài viết này sẽ bỏ qua cách cài đặt `docker`, `docker-compose`. Trước tiên, hay lấy file `docker-compose.yaml` mẫu từ [github repo của wg-easy](https://github.com/wg-easy/wg-easy/blob/master/docker-compose.yml)

```sh
$ mkdir /opt/01-wg_easy
$ curl https://raw.githubusercontent.com/wg-easy/wg-easy/refs/heads/master/docker-compose.yml -o docker-compose.yml
$ docker compose up -d
```

Trước khi làm mọi thứ đao to búa lớn, chúng ta cần đảm bảo là Wireguard VPN Server chạy được đã.

Vào [http://127.0.0.1:51821](http://127.0.0.1:51821), thiết lập cơ bản, và tạo VPN Client đầu tiên.

## Bước 2: Vào Router, thiết lập port forwarding cho cổng 51820 cho nó trỏ vào đúng LAN IP có Wireguard VPN Server

- `51821`: port này dành cho dashboard quản trị VPN Client. Hoàn toàn không nên làm port forwarding
- `51820`: port này dành cho vpn tunnel, tín hiệu giao liên là ở port này.

## Bước 3: Test thử xem VPN Client có kết nối được không
Có thể test IP xem có trùng với `WAN_IP` của VPN server hay không với command sau.
```sh
$ curl https://api.ipify.org
```

Khi bạn làm đến bước này:
- Đã hoàn toàn có thể từ `VPN Client 10.8.0.2` `ping` đến LAN IP ví dụ: `192.168.1.[2, 3, 4 ...]`
- Tuy nhiên, từ LAN IP `192.168.1.[2, 3, 4 ...]` **không thể ping** đến `VPN Client 10.8.0.[2, 3 ...]`
- Thậm chí máy có LAN IP là `192.168.1.2` là máy cài đặt wireguard vpn server, nó cũng không biết đường mà ping đến `10.8.0.2, 3...`

## Bước 4: Vào Router ví dụ [192.168.1.1](192.168.1.1), route `10.8.0.0/24` vào `192.168.1.2`
Sau khi làm bước này, Khi LAN IP ví dụ `192.168.1.[2, 3, 4...]` muốn ping `10.8.0.X`, nó hỏi router, router sẽ bảo nó đến gặp `192.168.1.2` (Cái máy có cài Wireguard VPN Server)

{% include image.html url="/image/posts/2026-01-07-Thiet-lap-wireguard-VPN/2.png" description="[2] Route 10.8.0.0/24 đến 192.168.1.2" %}

## Bước 5: Chuyển đổi `network_mode: host` trong docker-compose.yaml

File `docker-compose.yaml` mẫu từ [github repo của wg-easy](https://github.com/wg-easy/wg-easy/blob/master/docker-compose.yml)

Tùy theo phiên bản, nó có thể khác. Nhưng sẽ trông giống như sau:

```
volumes:
  etc_wireguard:

services:
  wg-easy:
    #environment:
    #  Optional:
    #  - PORT=51821
    #  - HOST=0.0.0.0
    #  - INSECURE=false                           # Cái này là về https khi tương tác với wireguard-easy dashboard

    image: ghcr.io/wg-easy/wg-easy:15
    container_name: wg-easy
    networks:                                     # Cụm config network sẽ bị vô hiệu hóa
      wg:                                         # để sử dụng network_mode: host
        ipv4_address: 10.42.42.42                 #
        ipv6_address: fdcc:ad94:bacf:61a3::2a     #
    volumes:
      - etc_wireguard:/etc/wireguard
      - /lib/modules:/lib/modules:ro
    ports:                                        # Cụm config ports sẽ bị vô hiệu hóa
      - "51820:51820/udp"                         # để sử dụng network_mode: host
      - "51821:51821/tcp"                         #
    restart: unless-stopped
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
      # - NET_RAW # ⚠️ Uncomment if using Podman
    sysctls:                                       # Cụm config sysctls sẽ bị vô hiệu hóa
      - net.ipv4.ip_forward=1                      # Sử dụng sysctl trực tiếp từ host
      - net.ipv4.conf.all.src_valid_mark=1         # Hãy lưu lại những config này, nó cần thiết
      - net.ipv6.conf.all.disable_ipv6=0           # Sẽ sử dụng sau.
      - net.ipv6.conf.all.forwarding=1             #
      - net.ipv6.conf.default.forwarding=1         #

networks:
  wg:
    driver: bridge
    enable_ipv6: true
    ipam:
      driver: default
      config:
        - subnet: 10.42.42.0/24
        - subnet: fdcc:ad94:bacf:61a3::/64
```

Sau khi thay đổi, nó sẽ trông như thế này:

```
volumes:
  etc_wireguard:

services:
  wg-easy:
    environment:
      - INSECURE=true
      - HOST=0.0.0.0
      - PORT=51821
    image: ghcr.io/wg-easy/wg-easy:15
    container_name: wg-easy
    network_mode: host
    volumes:
      - etc_wireguard:/etc/wireguard
      - /lib/modules:/lib/modules:ro
    restart: unless-stopped
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
      # - NET_RAW # ⚠️ Uncomment if using Podman

networks:
  wg:
    driver: bridge
    enable_ipv6: true
    ipam:
      driver: default
      config:
        - subnet: 10.42.42.0/24
        - subnet: fdcc:ad94:bacf:61a3::/64
```

Chạy
```sh
$ docker compose down
$ docker compose up -d
```
hoặc là `docker compose up -d --force-recreate`


vào [http://127.0.0.1:51821](http://127.0.0.1:51821)

## Bước 6: Chỉnh sysctl - `/etc/sysctl.d/99-sysctl.conf`

File `/etc/sysctl.d/99-sysctl.conf` sẽ có nội dung như sau:

```conf
net.ipv4.ip_forward=1
net.ipv4.conf.all.src_valid_mark=1
net.ipv6.conf.all.disable_ipv6=0
net.ipv6.conf.all.forwarding=1
net.ipv6.conf.default.forwarding=1
```

Bạn thấy quen chứ, nó chính xác được lấy ra từ `docker-compose.yaml` [link](https://github.com/wg-easy/wg-easy/blob/master/docker-compose.yml#L29)

Edit xong, hãy reboot lại máy tính.

Nếu bạn muốn thử nghiệm, có thể chạy command sau:

```sh
$ sysctl -w net.ipv4.ip_forward=1
$ sysctl -w net.ipv4.conf.all.src_valid_mark=1
$ sysctl -w net.ipv6.conf.all.disable_ipv6=0
$ sysctl -w net.ipv6.conf.all.forwarding=1
$ sysctl -w net.ipv6.conf.default.forwarding=1
```

## Bước 7: Sử dụng `firewall-cmd` và `--add-masquerade` để ngụy trang `gốc IP/SRC` trong data packet

Điều đầu tiên cần làm là kiểm tra xem OS có sử dụng firewalld hay không. `firewalld` được sử dụng mặc định trên Fedora, OS mà tôi đang sử dụng. Còn nếu không, bạn sẽ phải dùng `iptables`

```sh
$ systemctl status firewalld.service

● firewalld.service - firewalld - dynamic firewall daemon
     Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; preset: enabled)
    Drop-In: /usr/lib/systemd/system/service.d
             └─10-timeout-abort.conf
     Active: active (running) since Tue 2026-01-06 15:05:30 +07; 23h ago
```



Tiếp theo Xem danh sách network interface đang có

```
$ ifconfig

enp11s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.2  netmask 255.255.255.0  broadcast 192.168.1.255
        ether 04:7c:16:50:a6:98  txqueuelen 1000  (Ethernet)
        RX packets 236460737  bytes 47024068300 (43.7 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 247516901  bytes 66599026721 (62.0 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wg0: flags=209<UP,POINTOPOINT,RUNNING,NOARP>  mtu 1420
        inet 10.8.0.1  netmask 255.255.255.0  destination 10.8.0.1
        inet6 fdcc:ad94:bacf:61a4::cafe:1  prefixlen 112  scopeid 0x0<global>
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 1000  (UNSPEC)
        RX packets 5513154  bytes 725714116 (692.0 MiB)
        RX errors 15920  dropped 0  overruns 0  frame 15920
        TX packets 6251671  bytes 2973719960 (2.7 GiB)
        TX errors 30  dropped 3481 overruns 0  carrier 0  collisions 0
```

Xem danh sách firewall active zone
```sh
$ firewall-cmd --get-active-zones
FedoraWorkstation (default)
  interfaces: enp11s0
docker
  interfaces: br-1176fcf199ed br-235b70e744fa br-4393a20aab02 docker0
trusted
  interfaces: wg0
```

Thêm network interface `wg0` vào zone `trusted`
```sh
$ firewall-cmd --permanent --zone=trusted --add-interface=wg0
```

Cho phép zone `FedoraWorkstation` (đang có interface `enp11s0`) ngụy trang `SRC` của network data packet.

```
$ firewall-cmd --permanent --zone=FedoraWorkstation --add-masquerade
```

`masquerade` ngụy trang IP `nguồn/SRC` của packet. Ví dụ, khi `192.168.1.3` ping `10.8.0.2`, chiều đi là hợp lệ, tuy nhiên, ở chiều phản hồi, nó sẽ khác.

- SRC: 10.8.0.2 -> DST: 192.168.1.3    (trước khi ngụy trang)
- SRC 192.168.1.2  -> DST: 192.168.1.3 (sau khi ngụy trang)

Sau khi xong bước này là đã xong hết rồi đó. Bạn đã có thể ping 2 chiều LAN <-> VPN.

Nếu mà không thích giải phảp ngụy trang `--add-masquerade` thì cân nhắc xem tiếp với giải pháp route trực tiếp với command `iptables`

## Bước 7A : Tạo rule trên iptables cho phép chuyển tiếp‌/forward package giữa các network interface (vd: eth0, wg0, enp11s0)

Điều đầu tiên cần làm là xem danh sách network interface đang có.
```
$ ifconfig

enp11s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.2  netmask 255.255.255.0  broadcast 192.168.1.255
        ether 04:7c:16:50:a6:98  txqueuelen 1000  (Ethernet)
        RX packets 236460737  bytes 47024068300 (43.7 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 247516901  bytes 66599026721 (62.0 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wg0: flags=209<UP,POINTOPOINT,RUNNING,NOARP>  mtu 1420
        inet 10.8.0.1  netmask 255.255.255.0  destination 10.8.0.1
        inet6 fdcc:ad94:bacf:61a4::cafe:1  prefixlen 112  scopeid 0x0<global>
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 1000  (UNSPEC)
        RX packets 5513154  bytes 725714116 (692.0 MiB)
        RX errors 15920  dropped 0  overruns 0  frame 15920
        TX packets 6251671  bytes 2973719960 (2.7 GiB)
        TX errors 30  dropped 3481 overruns 0  carrier 0  collisions 0
```

Sử dụng command `iptables` và tạo rule `chuyển tiếp/FORWARD`

```sh
$ sudo iptables -A FORWARD -i wg0 -o eth0 -s 10.8.0.0/24 -d 192.168.1.0/24 -j ACCEPT
$ sudo iptables -A FORWARD -i eth0 -o wg0 -s 192.168.1.0/24 -d 10.8.0.0/24 -j ACCEPT
```

Ngay khi bạn làm được bước này, IP trong LAN `192.168.1.X` sẽ ping được đến `10.8.0.X` (VPN).
Ping 2 chiều LAN <-> VPN hoàn tất.
