---
layout: post
title: "Cách lấy lại unallocated space cho btrfs "
date: 2026-03-28 09:36:22
update:
location: Saigon
tags:
- linux
- btrfs
- unallocated
categories: Linux
seo_description:
seo_image: /image/posts/2026-03-28-Cach-lay-lai-unallocated-space-cho-btrfs/seo.jpg
comments: true
---

Bài này tôi viết ra sau khi gặp tình huống như sau:
- Diskspace bị đầy 99% (kiểm tra với `df -h -T`)
- Tôi đã tìm ra và muốn xóa các thư mục không cần thiết. Tuy nhiên, `rm` chạy rất lâu, treo máy
- Từ bước này trở đi, tôi bắt đầu sử dụng ChatGPT để hỗ trợ.
- Thư mục muốn xóa nằm trong file system `btrfs`. (check với command `findmnt /PATH_TO_DELETE_DIR`)
- Kiểm tra tình trạng process `rm` với command `cat /proc/pid/stack`

```
[<0>] read_extent_buffer_pages+0x1de/0x220
[<0>] btrfs_read_extent_buffer+0x94/0x1c0
[<0>] read_tree_block+0x32/0x90
[<0>] read_block_for_search+0x247/0x360
[<0>] btrfs_search_slot+0x375/0x1050
[<0>] lookup_inline_extent_backref+0x174/0x810
[<0>] lookup_extent_backref+0x41/0xd0
[<0>] __btrfs_free_extent.isra.0+0x107/0x9f0
[<0>] __btrfs_run_delayed_refs+0x66b/0xfa0
[<0>] btrfs_run_delayed_refs+0x3b/0xd0
[<0>] flush_space+0x183/0x5b0                     <----
[<0>] priority_reclaim_metadata_space+0x94/0x150  <----
[<0>] __reserve_bytes+0x2a7/0x6e0
[<0>] btrfs_reserve_metadata_bytes+0x1d/0xc0      <----
[<0>] btrfs_block_rsv_refill+0x6b/0xa0
[<0>] evict_refill_and_join+0x4b/0xc0
[<0>] btrfs_evict_inode+0x30a/0x3c0
[<0>] evict+0xcd/0x1d0
[<0>] do_unlinkat+0x2de/0x330
[<0>] __x64_sys_unlinkat+0x56/0xc0
[<0>] do_syscall_64+0x82/0x160
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

```
- ChatGPT nghi ngờ rằng có áp lực lớn bên phía `btrfs`, do trên stack có các lệnh sau:
    - `flush_space`
    - `priority_reclaim_metadata_space`
    - `btrfs_reserve_metadata_bytes`

- Từ điểm này, bắt đầu kiểm tra `unallocated space` của `btrfs`.

Thực sự là cảm ơn **ChatGPT** rất nhiều, những kiến thức liên quan đến `btrfs` tôi thực sự không biết.

# 1. Kiểm tra unallocated space

```sh
$ btrfs filesystem usage /

Overall:
    Device size:		 929.93GiB
    Device allocated:		 929.92GiB
    Device unallocated:		   1.00MiB    <----
    Device missing:		     0.00B
    Device slack:		     0.00B
    Used:			 877.81GiB
    Free (estimated):		  43.98GiB	(min: 43.98GiB) <----
    Free (statfs, df):		  43.98GiB
    Data ratio:			      1.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 0.00B)
    Multiple profiles:		        no

Data,single: Size:883.91GiB, Used:839.92GiB (95.02%)
   /dev/nvme0n1p3	 883.91GiB

Metadata,DUP: Size:23.00GiB, Used:18.94GiB (82.36%)
   /dev/nvme0n1p3	  46.00GiB

System,DUP: Size:8.00MiB, Used:112.00KiB (1.37%)
   /dev/nvme0n1p3	  16.00MiB

Unallocated:
   /dev/nvme0n1p3	   1.00MiB    <----
┌[root@caheo-workstation-hocmon] [/dev/pts/3]
└[~]> btrfs filesystem df /
Data, single: total=883.91GiB, used=838.96GiB
System, DUP: total=8.00MiB, used=112.00KiB
Metadata, DUP: total=23.00GiB, used=18.92GiB
GlobalReserve, single: total=512.00MiB, used=0.00B
```

Lưu ý con số này nhé: `Device unallocated: 1.00MiB`.
Tại vì không còn `Device unallocated`, tôi không thể chạy lệnh `rm` như bình thường được nữa (^,.,^)!

Còn một chỉ số rất quan trọng nữa đó là `Free (estimated): 43.98GiB (min: 43.98GiB)`. Nó có nghĩa là dung lượng còn trống khả dĩ.

Bạn thấy sự chênh lệch giữa `Device unallocated` và `Free (estimated)` chứ. Nó cần cân bằng, xấp xỉ bằng nhau hoặc ít nhất là đừng có lệch quá.

# 2. Cân bằng (balance) lại btrfs
Lưu ý siêu quan trọng, để việc cân bằng tốt hơn, cực kỳ hạn chế các tác vụ `đọc/ghi` dữ liệu.

## 2.1 Start
```sh
$ btrfs balance start -dusage=75 ‌/your_mount_path
```

## 2.2 Pause - Tạm dừng

Btrfs cho phép dừng tạm thời quá trình cân bằng, reboot rồi quay lại làm tiếp cũng được.

```sh
$ btrfs balance pause /your_mount_path
```

## 2.3 Resume - Làm tiếp

Nếu mà đang cân bằng, và bạn `reboot`. Sau khi `reboot`, `btrfs` sẽ tự động quay lại quá trình cân bằng.

```sh
$ btrfs balance resume /your_mount_path
```

## 2.4 Cancel - Hủy bỏ
```
$ btrfs balance cancel /your_mount_path
```

## 2.5 Status - Xem trạng thái

```
$ btrfs balance status /your_mount_path
```

# 3. Kết quả

Sau quá trình cân bằng‌/balance, tôii có thử `rm` với thư mục lúc trước bị treo, hoàn toàn không có trục trặc.

Đây là trạng thái của `btrfs` sau khi balance
```sh
$ btrfs filesystem usage /

Overall:
    Device size:		 929.93GiB
    Device allocated:		 891.92GiB
    Device unallocated:		  38.00GiB
    Device missing:		     0.00B
    Device slack:		     0.00B
    Used:			 829.75GiB
    Free (estimated):		  77.77GiB	(min: 58.77GiB)
    Free (statfs, df):		  77.77GiB
    Data ratio:			      1.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 0.00B)
    Multiple profiles:		        no

Data,single: Size:833.91GiB, Used:794.14GiB (95.23%)
   /dev/nvme0n1p3	 833.91GiB

Metadata,DUP: Size:29.00GiB, Used:17.80GiB (61.40%)
   /dev/nvme0n1p3	  58.00GiB

System,DUP: Size:8.00MiB, Used:128.00KiB (1.56%)
   /dev/nvme0n1p3	  16.00MiB

Unallocated:
   /dev/nvme0n1p3	  38.00GiB
```

# 4. Credit

Thực sự phải cảm ơn ChatGPT. Đây là lần đầu tiên tôi gặp phải tình huống phải `balance btrfs`.
