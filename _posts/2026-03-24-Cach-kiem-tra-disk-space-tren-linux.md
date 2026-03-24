---
layout: post
title: "Cách kiểm tra disk space trên linux"
date: 2026-03-24 14:18:00
update:
location: Saigon
tags:
- Linux
- Diskspace
categories: Linux
seo_description: "'df' và 'du' là hai command hữu dụng nhất khi kiểm tra disk space."
seo_image: /image/posts/2026-03-24-Cach-kiem-tra-disk-space-tren-linux/seo.jpg
comments: true
---

## 1. Kiểm tra tình trạng mount point - `df -h`

```sh
$ df -h

Filesystem                                  Size  Used Avail Use% Mounted on
/dev/nvme0n1p3                              930G  919G  4.5G 100% /
devtmpfs                                    4.0M     0  4.0M   0% /dev
tmpfs                                        16G  1.1M   16G   1% /dev/shm
...
/dev/nvme0n1p3                              930G  919G  4.5G 100% /home
```

Dựa vào cột `Use%`, ta dễ dàng thấy được đâu là `mount point` cần quan tâm:

- `/`
- `/home`

## 2. Kiểm tra tình trạng sử dụng chi tiết trong mount mount - `du -h`

- Thay `/` bằng path khác, mặc định là directory hiện tại.
- Xem tổng dung lượng của từng directory, chỉ lấy 1 level (`max-depth=1`)
- Sắp xếp lại từ cao xuống thấp (`sort -hr`)

```sh
$ du -h --max-depth=1 / | sort -hr
```

Từng bước một, đi vào các thư mục sâu hơn, bạn hoàn toàn có thể giải phỏng bớt `disk space`. Chúc may mắn.
