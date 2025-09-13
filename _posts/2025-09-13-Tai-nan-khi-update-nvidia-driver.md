---
layout: post
title: "Tai nạn khi update nvidia driver"
date: 2025-09-13 16:26:29
update:
location: Saigon
tags:
- nvidia
- dracut
- nouveau
- grub
categories: Linux
seo_description: Khi update nvidia driver với multi-user.target, gỡ bỏ version cũ làm màn hình đen. Tại sao nó xảy ra.
seo_image: /image/posts/2025-09-13-Tai-nan-khi-update-nvidia-driver/seo.png
comments: true
---

# I. Tình huống
Tôi sẽ tóm tắt gọn lại tình huống xảy ra:
- Mục tiêu: tìm cách update lên nvidia-driver phiên bản mới nhất `NVIDIA-Linux-x86_64-580.82.09` [https://www.nvidia.com/en-us/drivers/details/254126/](https://www.nvidia.com/en-us/drivers/details/254126/)
- Vào `multi-user.target` để chạy `NVIDIA-Linux-x86_64-580.82.09.run`
- Ngay sau khi gỡ bỏ nvidia driver cũ, màn hình đen xì. Không thể tương tác với OS.
- Giai đoạn này chỉ có 1 cách là giữ nút nguồn và reboot lại OS.
- Cầu nguyện cho nó hiện ra được cái terminal để mà còn gõ command được.

# II. Tại sao màn hình đen
Cái này là tôi phỏng đoán, lúc này OS mặc dù đang là `multi-user.target` mode, tuy nhiên nó vẫn đang sử dụng nvidia
driver. Việc gỡ nvidia driver ra khỏi OS làm màn hình đen.

Tuy nhiên, trước đây, tôi hoàn toàn không bao giờ gặp vấn đề này, khi tôi cài nvidia driver mới, cùng lắm là màn hình
chớp một cái thôi, chứ không đến mức màn hình đen xì, không thể tương tác được. Phải đến mức giữ nguồn reboot thì là
mới gặp đầu tiên.

# III. Định hướng xử lý
Khi **cài mới** hay **update** nvidia driver, nên đưa máy sử dụng `nouveau` thay vì là `nvidia`. Sau khi đã cài đặt
xong hoàn toàn, chúng ta sẽ `blacklist nouveau` và chỉ sử dụng nvidia.

Đi sâu một chút, chúng ta sẽ cần hiểu thứ tự boot của hệ điều hành Fedora:
- [**Giai đoạn 1**] Load initramfs, nó là phiên bản OS tinh gọn load trên ram.
- [**Giai đoạn 2**] `switch_root` chuyển qua rootfs (root filesystem) thật.

Tôi không biết tại sao nó như vậy, nhưng đây là quá trình xảy ra.

Ở bước load initramfs lên ram, phiên bản tinh gọn này sẽ dùng `nouveau`, một khi đã load xong rồi, đến giai đoạn
`switch_root`, lúc này sẽ disable `nouveau` đi và sử dụng `nvidia driver`.

Tôi đã nghĩ là hoàn toàn không cần phải vào `multi-user.target` khi `update` hoặc `install`
nvidia driver, ta hoàn toàn có thể mở `gnome-terminal` và chạy command như bình thường. Tuy nhiên, sau khi tôi test xong,
hoàn toàn không được, buộc phải vào `multi-user.target`.

# IV. Thực sự sẽ phải làm thế nào làm ra sao
Trước tiên đi sâu hơn, tôi muốn nói là để tinh gọn file `/boot/initramfs-*.img`. Tôi đã cố tình loại bỏ nvidia driver,
kernel object `.ko` liên quan rồi. Nói cách khác thì trong `initramfs` hoàn toàn không có nvidia driver.

Bạn có thể tìm `$ dracut --omit-drivers`, nó liên quan đến quá trình tạo initramfs, Mỗi khi mà OS update kernel,
dracut sẽ chạy để tạo ra `initramfs.img` mới. Ví dụ khi chạy `dracut` thủ công

```sh
$ dracut --omit-drivers "nvidia-drm nvidia nvidia-modeset nvidia-peermem nvidia-uvm" \
    initramfs-6.16.5-200.fc42.x86_64.img  6.16.5-200.fc42.x86_64
```

## 1. Chế độ dùng `nvidia` (mặc định, khi chạy OS)
Cái này liên quan mật thiết đến `GRUB_CMDLINE_LINUX`, hãy xem `/etc/default/grub`

```config
File: /etc/default/grub
~~~~
GRUB_CMDLINE_LINUX="rhgb quiet rd.driver.blacklist=nouveau modprobe.blacklist=nouveau  nvidia-drm.modeset=1"
~~~~
~~~~
```

Giải thích:
- `rd.driver.blacklist=nouveau`: mặc dù trong initramfs có module `nouveau`, tuy nhiên sẽ không load nó. (giai đoạn 1)
- `modprobe.blacklist=nouveau`: sau khi `switch_root`, sẽ không load kernel module có tên là `nouveau`. Bên cạnh đó, nếu
bất cứ ứng dụng nào tìm cách kích hoạt `nouveau`, đều sẽ không có  hiệu quả. <br> <br>
Lưu ý nhé, đây là giai đoạn 2, kernel module được load từ `/usr/lib/modules/${KERNEL_VERSION}/` chứ không phải trong `initramfs.img`.
- `nvidia-drm.modeset=1`: Còn `nvidia-drm` thì sẽ mở.

`nouveau` chưa bao giờ được load kể cả từ `initramfs` hay là sau khi `switch_root`. Nvidia driver 100% sẽ được sử dụng.

## 2. Chế độ dùng `nouveau` (chỉ dùng khi cần update nvidia)

Khi mà bạn cần vào chế độ `nouveau`, thì ở màn hình grub, hãy ấn `e` để edit grub entry.

```config
File: /etc/default/grub
~~~~
GRUB_CMDLINE_LINUX="rhgb quiet nvidia-drm.modeset=0 nouveau.modeset=1 3"
~~~~
~~~~
```

- `nvidia-drm.modeset=0`: sau khi `switch_root` không load `nvidia-drm`
- `nouveau.modeset=1`: còn `nouveau` thì sẽ load.
- `3`: cái số này ám chỉ là sẽ sử dụng `multi-user.target`. Đây là chiêu rất hay nếu bạn không muốn dùng command
  `$ systemctl set-default multi-user.target/graphical.target` trước khi reboot để install hay update nvidia driver.


Sau đó ấn `F10` để boot vào.

# V. Các command hữu dụng

## 1. Để kiểm tra xem OS đang dùng `nvidia` hay `nouveau` hãy dùng command sau:

```sh
$ lspci -k | grep -EA3 'VGA|3D|Display'

02:00.0 VGA compatible controller: NVIDIA Corporation GA102 [GeForce RTX 3080 Lite Hash Rate] (rev a1)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 389b
-->	Kernel driver in use: nvidia  <-------
	Kernel modules: nouveau, nvidia_drm, nvidia

```

```sh
$ lspci -k | grep -EA3 'VGA|3D|Display'
02:00.0 VGA compatible controller: NVIDIA Corporation GA102 [GeForce RTX 3080 Lite Hash Rate] (rev a1)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 389b
-->	Kernel driver in use: nouveau <-------
	Kernel modules: nouveau, nvidia_drm, nvidia
```

## 2. Để biết `grub_cmdline_linux` đã chạy là gì

```sh
$ cat /proc/cmdline

BOOT_IMAGE=(hd2,msdos2)/vmlinuz-6.16.5-200.fc42.x86_64 root=UUID=e33a7af8-24bf-4be0-b954-327da689e4fb ro rootflags=subvol=root rhgb quiet nouveau.modeset=1 nvidia-drm.modeset=0 hugepagesz=1G hugepages=3
```
