---
layout: post
title: "Trải nghiệm mệt mỏi khi backup & restore Monero blockchain"
date: 2026-01-03 00:14:56
update:
location: Saigon
tags:
- monero
categories:
- Cryptocurrency Node
seo_description: BTRFS và LMDB, không ổn đâu. Phân mảnh rất nhiều (^,.,^)!
seo_image: /image/posts/2026-01-03-Trai-nghiem-met-moi-khi-backup-restore-monero-blockchain/seo.png
comments: true
---

Ngày 1/1/2026, tôi làm backup cho Monero blockchain, tôi nghĩ ngay đến sử dụng hai command sau:

- `monero-blockchain-export`
- `monero-blockchain-import`

Hai command này đi cùng với `monerod`. Bằng một cách rất quái quỷ, quá trình export mất hơn 24 giờ,
mãi mà vẫn không xong. Quá vô lý cho 1 file 270GB

```sh
# /mnt/disk_2/CryptoCurrency/Monero/lmdb

$ du -h *
252G	data.mdb
8.0K	lock.mdb
```

Ngày 2/1/2026, thực sự rất khó chịu với tốc độ này, tôi quyết định dừng lại, không sử dụng `monero-blockchain-export` nữa, thay vào đó
tôi sẽ sử dụng `tar` để tạo lưu trữ trực tiếp. Anh em biết gì không, **nó vẫn chậm. cực kỳ chậm**!

Sau khi tôi được tư vấn với ChatGPT thì là vì vấn đề phân mảnh (**fragment**) trên ổ đĩa có filesystem btrfs. Nói thêm một chút,

- Cơ chế **copy/modify** file của **btrfs** là `copy-on-write`.
- Cơ chế **update** database của `LMDB` có tính ngẫu nhiên.

Ví dụ, có `10 logical block`, khi update lmdb, có thể xảy ra ở ngẫu nhiên các block. Khi các block có update, cơ chế `copy-on-write` sẽ sử dụng physical block mới.
Việc này làm cho data trên ổ đĩa không liền mạch, phân mảnh.

Sau **1000 lần update như vậy**, bạn có thể tưởng tượng sự rời rạc của dữ liệu ban đầu. Thay vì đầu đọc của ổ HDD có thể đọc tuần tự, giờ đây, nó sẽ phải nhảy
liên tục.

## 1. Vậy tôi nên làm gì?
- Giải phân mảnh file `/mnt/disk_2/CryptoCurrency/Monero/lmdb` - `filefrag`

```sh
filefrag -v data.mdb
Filesystem type is: 9123683e
File size of data.mdb is 270078246912 (65937072 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       0:  251471156.. 251471156:      1:             shared
   1:        1..       1:  251504005.. 251504005:      1:  251471157: shared
   2:        2..       2:     352485..    352485:      1:  251504006: shared
   3:        3..       3:     379586..    379586:      1:     352486: shared
```

- Thay đổi cách write của thư mục chứa blockchain Monero, không cho phép `copy-on-write` nữa. Command `chattr` & `lsattr`

```
$ chattr +C /mnt/disk_2/CryptoCurrency/Monero/lmdb
```

Trường hợp của tôi là quá tệ rồi, việc giải phân mảnh gần như là không ăn thua. Việc nên làm là:
- Tạo thư mục mới `lmdb_no_cow`
- Sử dụng command `chattr +C` cho thư mục này
- Sử dụng command `lsattr` để kiểm tra xem có thực sự bỏ `copy-on-write`
- Copy file từ `lmdb` (cũ) sang `lmdb_no_cow`(mới). Dùng `rsync` để hiển thị tiến trình copy.
- Sau khi copy xong, xóa directory `lmdb`, đổi tên `lmdb_no_cow` thành `lmdb`

```sh
$ cd /mnt/disk_2/CryptoCurrency/Monero
$ mkdir lmdb_no_cow
$ chattr +C lmdb_no_cow
$ rsync -a --info=progress2 lmdb/ lmdb_no_cow/
  694,190,080   0%    1.86MB/s   39:17:29
```

Bạn không tin được đâu, việc copy - paste của tôi mất hơn 4 ngày đó.

Bây giờ tôi sẽ tạo lưu trữ với `tar` và `monero-blockchain-export để so sánh`.

## 2. Tạo lưu trữ với `tar`
Command tạo lưu trữ:
```sh
$ tar -cvf lmdb.tar lmdb
```
Tuy nhiên, tôi muốn khai thác thêm thời gian chạy, tôi sẽ gài thêm `date`, trước và sau khi chạy `tar`.
```sh
$ date +'%d/%m/%Y %H:%M:%S'; tar -cvf lmdb.tar lmdb;date +'%d/%m/%Y %H:%M:%S'

09/01/2026 17:27:56
lmdb/
lmdb/data.mdb
lmdb/lock.mdb
09/01/2026 19:45:32
```

Khoảng 2 giờ 18 phút.
## 3. So sánh với thời gian tạo lưu trữ với `monero-blockchain-export`
Command `monero-blockchain-export` sử dụng như sau:

```sh
./monero-blockchain-export --data-dir=/mnt/disk_2/CryptoCurrency/Monero --output-file /mnt/disk_2/CryptoCurrency/Monero/monero-blockchain.dump
```

Bọc thêm thời gian:
```sh
$ date +'%d/%m/%Y %H:%M:%S'; \
  ./monero-blockchain-export --data-dir=/mnt/disk_2/CryptoCurrency/Monero --output-file /mnt/disk_2/CryptoCurrency/Monero/monero-blockchain.dump
  date +'%d/%m/%Y %H:%M:%S'

09/01/2026 21:01:26
... ... ... ... ...

11/1/2025 23:56:26 Hơn 2 ngày rồi vẫn chưa xong. Tôi sẽ hủy bỏ việc sử dụng monero-blockchain-export, cái này hoàn toàn không đáp ứng nhu cầu của tôi.
```
