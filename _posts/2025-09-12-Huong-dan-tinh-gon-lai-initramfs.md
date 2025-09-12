---
layout: post
title: "Hướng dẫn tinh gọn lại initramfs"
date: 2025-09-12 18:38:24
update:
location: Saigon
tags:
- linux
- initramfs
- fedora
- kernel
- dracut
categories: Linux
seo_description: initramfs chiếm quá nhiều dung lượng của /boot, bài viết này hướng dẫn loại bỏ kernel driver không cần thiết.
seo_image: /image/posts/2025-09-12-Huong-dan-tinh-gon-lai-initramfs/seo.png
comments: true
---

# I. Điều gì đã xảy ra?
Trước khi đi sâu về mặt kỹ thuật, bạn cần hiểu lý do nào mà tôi cần phải tinh gọn, việc tạo ram file system image (`initramfs.img`) là mặc định khi update Fedora. Những việc này, người dùng như tôi, thường không phải đụng tay vào. Hoặc rất đen mới phải đụng tay vào.

Tuy nhiên, mọi thứ phát sinh sau khi tôi update lên kernel `6.16.5-200.fc42.x86_64`, việc build `initramfs` tự động tạo ra file `initramfs-6.16.5-200.fc42.x86_64.img` với dung lượng hơn **300MB**, và nó là quá nhiều với `/boot` vốn khi cài đặt mặc định chỉ có **1GB** mà thôi.

``` sh
$ ls -lah /boot
164M Aug 31 02:19 initramfs-6.16.3-200.fc42.x86_64.img
164M Sep 12 18:25 initramfs-6.16.4-200.fc42.x86_64.img
320M Sep 12 18:50 initramfs-6.16.5-200.fc42.x86_64.img
```

Bạn thấy chứ, có gì đó đã xảy ra, `initramfs-6.16.5-200.fc42.x86_64.img` có dung lượng cao đột biến so với các `.img` tiền nhiệm. Tôi có sử dụng **nvidia driver** tôi nghi ngờ rằng, **nvidia driver** đã được tích hợp vào `initramfs` theo cách không cần thiết, và thêm nữa, nó quá chiếm dung lượng.

Vốn dĩ, `initramfs.img` chỉ dùng ban đầu như là một bước mồi trước khi `chroot` (change root). Nó thực sự không cần:
- Hình ảnh (nvidia, amd)
- Âm thanh
- Bluetooth
- Internet

Nhân tiện, việc build `initramfs.image` sử dụng command `dracut`.

# II. Cách liệt kê những module tích hợp trong initramfs
## Cách 1: `lsinitrd file.img`
Ở cách này, chúng ta đã có file `.img` rồi, chúng ta muốn khám xem trong `.img` đang có cái gì.

``` sh
$ lsinitrd initramfs-6.16.5-200.fc42.x86_64.img | grep "\.ko" | grep nvidia

usr/lib/modules/6.16.5-200.fc42.x86_64/extra/nvidia-drm.ko.xz
usr/lib/modules/6.16.5-200.fc42.x86_64/extra/nvidia.ko.xz
usr/lib/modules/6.16.5-200.fc42.x86_64/extra/nvidia-modeset.ko.xz
```

Có 3 module có chữ `nvidia`:

- `nvidia`
- `nvidia-drm`
- `nvidia-modeset`

Một lần nữa, `initramfs.img` không cần graphic, những module này là không cần thiết.

## Cách 2: Vào `/lib/modules/KERNEL_VERSION/extra/`

Mặc định, những module `.ko (kernel object)` phụ sẽ nằm ở `/lib/modules/KERNEL_VERSION/extra/`.

```sh
$ ls /lib/modules/6.16.5-200.fc42.x86_64/extra

nvidia-drm.ko.xz
nvidia.ko.xz
nvidia-modeset.ko.xz
nvidia-peermem.ko.xz
nvidia-uvm.ko.xz
```

Tôi không hiểu hay quan tâm tại sao `nvidia-peermem` và `nvidia-uvm` không xuất hiện trong `.img`. Tuy nhiên, nó là đủ để hiểu `dracut` lấy các file kernel object `nvidia` từ đâu.

# 3. Cách bỏ qua‌/omit những module không cần thiết khi tạo initramfs
Để build `.img` mà bỏ qua những driver không cần thiết, ta sử dụng flag `--omit-drivers` trong `dracut`. Dưới đây là command build `.img` có loại trừ các driver sau:

- `nvidia-drm`
- `nvidia`
- `nvidia-modeset`
- `nvidia-peermem`
- `nvidia-uvm`

``` sh
$ dracut --omit-drivers "nvidia-drm nvidia nvidia-modeset nvidia-peermem nvidia-uvm" \
    initramfs-6.16.5-200.fc42.x86_64.img  6.16.5-200.fc42.x86_64
```

Nhìn dung lượng mới mà xem, **164MB**.

``` sh
$ du -h initramfs-6.16.5-200.fc42.x86_64.img
164M	initramfs-6.16.5-200.fc42.x86_64.img
```

# 4. Cài thiết lập mặc định cho dracut
Tất nhiên việc cứ tạo `initramfs.img` thủ công sau mỗi lần kernel update là rất bất tiện. Để can thiệp vào bước tự động hóa đang có, ta sẽ cần vào thư mục `/etc/dracut.conf.d/` và tạo file `omit-driver-nvidia.conf` với nội dung như sau:

```conf
omit_drivers+=" nvidia-drm nvidia nvidia-modeset nvidia-peermem nvidia-uvm "
```

Sau khi tạo xong, việc chạy dracut sẽ không cần đến flag `--omit-drivers` nữa. Bên cạnh đó, khi Fedora OS update, nó cũng sẽ bỏ qua việc tích hợp nvidia module khi tạo `initramfs.img`.

```sh
$ dracut initramfs-6.16.5-200.fc42.x86_64.img 6.16.5-200.fc42.x86_64
```

Hi vọng ai đó có thể tiết kiệm được 2 phút cuộc đời nếu gặp vấn đề tương tự!

# 5. Reference
- Linux man page, dracut, [https://linux.die.net/man/8/dracut](https://linux.die.net/man/8/dracut)
- Chatgpt, [https://chatgpt.com/](https://chatgpt.com/)

Cảm ơn **Chatgpt** đã giúp tôi hiểu thêm về `dracut` và `initramfs`.
