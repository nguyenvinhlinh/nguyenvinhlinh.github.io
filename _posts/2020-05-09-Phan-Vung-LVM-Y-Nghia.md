---
layout: post
title: Phân Vùng LVM - Ý Nghĩa và Phát Triển
date: 2020-05-09 19:49:00 +0700
categories: Linux
tag: Linux
comments: true
---

# I. Logical Volume Manager (LVM)

LVM - Phần mềm quản lý nhiều ổ cứng Logical Volume, tác dụng của LVM đó là cho phép ghép nhiều ổ đĩa cứng với nhau, sau đó tạo ra một lớp trừu tượng trước hệ điều hành. Với lợi thế này, việc gia tăng dung lượng cho hệ điều hành dễ dàng hơn bao giờ hết. Hệ điều hành có thể đang chạy trên hai ổ cứng vẫn đảm bảo được sự trơn tru, đơn giản khi vận hành như đang làm việc với một ổ cứng mà thôi.

Hệ thống từ vựng được sử dụng khi nói đến `LVM` hơi nhầm lẫn khi dịch qua tiếng Việt

- volume: Là một từ trừu tượng, có thể hiểu khi là một cục nào đó chứa dữ liệu
- partition: Phân vùng, khi nói đến phân vùng, chúng ta nói đến việc chia ổ cứng thành nhiều phần vùng
- physical volume: Khi nói đến LVM, thì `physical volume` là thứ được tạo ra từ `partition`
- physical volume group: Là nhóm được tạo ra từ nhiều partition
- logical volume: Khi nói đến LVM, thì `logical volume` là volume được tạo ra từ `physical volume group`

Hiểu nôm na thì ta sẽ có sơ đồ từ vựng thứ tự của các định nghĩa như sau:
{% highlight text %}
Ổ Đĩa → Partition → Physical Volume → Physical Volume Group → Logical Volume
{% endhighlight %}



![](https://paper-attachments.dropbox.com/s_57426A14049B102F3EA6C3C52AF87106C341D5168299602654C5DD96EE34B365_1589805675958_1.png)

# II. Các quy trình thường gặp khi làm việc với LVM
## a. Tạo `logical volume`
- Tạo phân vùng (`partition`) có định dạng là `Linux LVM` từ ổ cứng vật lý.  **[LEVEL 2]**
    - Sử dụng lệnh `fdisk`
- Tạo `physical volume` từ phân vùng (`partition`) vừa tạo **[LEVEL 3]**
    - Sử dụng lệnh `pvcreate`
- Tạo `physical volume group` với `physical volume` vừa tạo **[LEVEL 4]**
    - Sử dụng lệnh `vgcreate`
- Tạo `logical volume` từ `physical volume group` **[LEVEL 5]**
    - Sử dụng lệnh `lvcreate`


## b. Gia tăng dung lượng cho `logical volume`
- Xác định xem `physical volume group`  cái tạo ra `logical volume`  cần tăng dung lượng xem là nó có còn dung lượng trống hay không. **[LEVEL 4]**
    - Sử dụng lệnh `vgs`, `vgdisplay`
- Nếu còn dung lương trống thì thêm dung lượng vào `logical volume` **[LEVEL 5]**
    - Sử dụng lệnh `lvextend`, `resize2fs`
- Nếu không còn thì phải thêm `physical volume` vào `physical volume group` **[LEVEL 3]**
    - Sử dụng lệnh `vgextend`
- Sau đó thì gõ lệnh thêm dung lượng vào `logical volume`  **[LEVEL 5]**
    - Sử dụng lệnh `lvextend`, `resize2fs`

## c. Giảm dung lượng của `logical volume`
Cực kì nguy hiểm!

Hãy backup trước khi làm việc này. Là người viết, tôi chưa bao giờ thử cái tính năng này. Viết cho nó có chữ thôi chứ, dùng cái tính năng của khỉ này, tôi không dám.

<br><br>![Smiling Face with Horns on Facebook 4.0](https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/facebook/230/smiling-face-with-horns_1f608.png)

- Xác định xem logical volume, bao nhiêu dung lượng đã được sử dụng, dung lượng còn lại có thể giảm được hay không. **[LEVEL 5]**
    - Sử dụng lệnh `df -h`, nó sẽ hiển thị dung lượng sử dụng.
- Gõ lệnh để giảm dung lượng của `logical volume`, dung lượng được giảm sẽ về `logical volume group`  **[LEVEL 5]**
    - Sử dụng lệnh `lvreduce`, `resize2fs`



# III. Các câu lệnh liên quan
```
| Command        | Level              | Ý nghĩa                                                                                                           |
| -------------- | ------------------ | ----------------------------------------------------------------------------------------------------------------- |
| lsblk          | Level 1, Level 2   | Liệt kê danh sách các ổ cứng - hay còn gọi là `block devices`. Ví dụ như sda, sdb, sdc                            |
| fdisk          | Level 1, Level 2   | Thao tác với ổ cứng ví dụ như tạo phân vùng (`partition`) trên ổ cứng                                             |
| pvcreate       | Level 3            | Tạo `physical volume` từ phân vùng(`partition`) trên ổ cứng                                                       |
| pvremove       | Level 3            | Xóa `physical volume`                                                                                             |
| vgcreate       | Level 4            | Tạo `physical volume group` từ một hay nhiều `physical volume`                                                    |
| vgextend       | Level 3, Level 4   | Thêm `physical volume` vào `physical volume group`                                                                |
| vgreduce       | Level 3, Level 4   | Loại bỏ `physical volume` khỏi `physical volume group`                                                            |
| vgremove       | Level 4            | Xóa `logical volume group`                                                                                        |
| vgs, vgdisplay | Level 4            | Liệt kê các `physical volume group` đang có                                                                       |
| lvcreate       | Level 5            | Tạo `logical volume` từ `physical volume group`                                                                   |
| lvs, lvdisplay | Level 5            | Liệt kê các `logical volume` đang có                                                                              |
| lvextend       | Level 5            | Gia tăng dung lượng cho `logical volume`                                                                          |
| lvreduce       | Level 5            | Giảm dung lượng cho `logical volume`                                                                              |
| lvremove       | Level 5            | Xóa `logical volume`                                                                                              |
| resize2fs      | Level 5            | Khi thao tác gia tăng `logical volume`, lệnh `resize2fs` được sử dụng để cập nhât filesystem cho `logical volume` |
| mkfs           |                    | Định dạng cho `logical volume` ví  dụ như là ext2, ext3, ext4 , ntfs. <br>**Make File System**                    |


```

# IV. Hứa hẹn

Tôi đã gặp tình huống như sau. Tôi có một Đĩa Vật Lý 500GB. Trên ổ đĩa này cài Hệ Điều Hành. Vấn đề đặt ra là làm sao để tôi có thể lắp thêm ổ cứng vật lý mới,  tiếp tục sử dụng hệ điều hành bình thường và quan trọng nhất là phải sử dụng lợi thế của `Logical Volume Manager`.

Trong bài viết tiếp theo, tôi sẽ kể chuyện tôi đã làm như thế nào. Thực tế thì tôi đã cóng tay đến mức phải chạy nháp trên máy ảo trước khi làm thật. Có những chuyện lúc dùng VM không xảy ra, mà đến khi chạy thật mới gặp phải.

Tuy nhiên, sau tất cả thì đến bây giờ mọi thứ vẫn ổn. Tôi khá là tự tin vào cách làm này.
