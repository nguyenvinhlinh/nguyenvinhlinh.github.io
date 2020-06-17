---
layout: post
title: LVM, Gia tăng logical volume!
date: 2020-05-10 12:00:00 +0700
categories: Linux
tag: Linux, LVM
comments: true
---
# I. Giới thiệu
![[1] Các lớp trừa tượng - LVM](/image/posts/2020-05-10-Gia-Tang-Logical-Volume/1.png)


Đây là câu chuyện tôi đã trải qua khi phải bắt buộc gia tăng `logical volume` hệ thống. Trong quá trình phát triển, không gian dữ liệu hệ điều hành chiếm dụng bắt đầu nhiều hơn và nhiều hơn. Đã có những lúc tôi nghịch ngợm với VM, Docker, Backup file quá nhiều, kết cục là ổ cứng 500 GB của tôi dần dần cạn kiệt.

Công ty tôi còn một vài cái ổ cứng 500 GB khác. Tôi quyết định mở rộng `logical volume` lên thêm nữa sử dụng lợi thế của `Logical Volume Manager`. Với cách tiếp cận này, việc gia tăng `logical volume` trở nên đơn giản hơn, với khả năng mở rộng lớn, thực sự là chỉ bị hạn chế bởi số cổng SATA hỗ trợ trên bo mạch chủ.

Vì lý do công nghệ này sử dụng nhiều lớp trừu tượng trung gian. Để giúp các bạn hiểu tôi đang nói về lớp nào tôi sẽ thêm các chú thích về tầng trừu tượng **[LEVEL X].** Hình số [1] có chú thích chi tiết từng tầng một.


# II. Cách làm

Đây là danh sách những việc phải làm khi muốn mở rộng `logical volume` **[LEVEL 5].** Trường hợp của tôi khá là kẹt khi mà `Physical Volume Group` hoàn toàn ko còn dung lượng dư. Chính vì như vậy, tôi phải gắn thêm một ổ đĩa cứng mới **[LEVEL 1].**

- Gắn ổ cứng mới **[LEVEL 1]**
- Tạo **phân vùng** (partition) với định dạng Linux LVM **[LEVEL 2]**
- Tạo **physical volume** từ **phân vùng** vừa tạo **[LEVEL 3]**
- Thêm **physical volume** vừa tạo vào **volume group [LEVEL 4]**
- Thêm dung lượng cho **logical volume** từ dung lượng trống từ **volume group** **[LEVEL 5]**
- Cập nhập filesystem


## 1. Gắn ổ cứng mới

Nghe dễ thật, nhưng tôi lại gặp một vấn đề khác.
{% highlight text %}
- Cắm ổ cứng mới vào bo mạch chủ
- Bật máy tính
---> Hệ điều hành không boot lên được
{% endhighlight %}

{% highlight text %}
- Không cắm ổ cứng mới vào bo mạch chủ vội
- Bật máy tính, vào hệ điều hành
- Bây giờ mới cắm ổ cứng vào bo mạch chủ
---> Hệ điều hành không nhận được ổ đĩa mới  (kiểm tra với lệnh `lsblk`, hoặc phần mềm `gnome-disk`)
{% endhighlight %}


Để hệ điều hành nhận ổ cứng mới, tôi đã phải làm theo các bước sau.
{% highlight text %}
- Format toàn bộ dữ liệu của ổ cứng mới (Nó đã được sử dụng và có hệ điều hành cũ trên đó)
- Cắm ổ cứng mới vào bo mạch chủ
- Bật hệ điều hành.
---> Hệ điều hành khởi động thành công, sau khi đăng nhập nó đã nhận được ổ đĩa mới.
Như trên hình, `sdb` là ổ đĩa mới.
{% endhighlight %}
![](/image/posts/2020-05-10-Gia-Tang-Logical-Volume/2.png)

## 2. Tạo phân vùng loại `Linux LVM` từ ổ đĩa [LEVEL 2]

Cách làm mà tôi sử dụng là phần mềm `fdisk`. Đây là các chỉ mục quan trọng

- Tạo GPG partition table
- Tạo phân vùng mới với loại `Linux LVM`

**a. Tạo GPG partition table**
Sử dụng lệnh sau với quyền root.

    fdisk /dev/sdb

`sdb` là tên của ổ đĩa. Lưu ý là `sdb` chứ không phải là `sdb1`, hoàn toàn không có hậu tố đằng sau. Số `1` ở đây ám chỉ phân vùng chứ không phải là ổ đĩa. Nếu bạn đang gắn ổ cứng thứ 3, ổ cứng của bạn khả năng rất cao sẽ tên là `sdc`.

**Fdisk**  là phần mềm có nhiều tính năng chết người, Thao tác của phần mềm khá đơn giản, chọn chỉ mục bằng phím, kết thúc bằng enter. Ví dụ để xem hướng dẫn của phần mềm, ấn phím `m` và kết thúc bằng `enter`.

Để tạo **GPG partition table**, hãy chọn chỉ mục có tên là `create a new empty GPT partition table`.

![[2] Tạo GPT Partition table](/image/posts/2020-05-10-Gia-Tang-Logical-Volume/3.png)


**b. Tạo phân vùng** `Linux LVM`

Chọn chỉ mục có tên là `add a new partition`

![[3] Tạo phân vùng mới](/image/posts/2020-05-10-Gia-Tang-Logical-Volume/4.png)


Tiếp theo, tôi sẽ bị yêu cầu nhập
- **partition number**: mặc định
- **first sector**: mặc định
- **last sector**: mặc định


{% highlight text %}
    Command (m for help): n
    Partition number (1-128, default 1): 1
    First sector (2048-4194270, default 2048): 2048
    Last sector, +sectors or +size{K,M,G,T,P} (2048-4194270, default 4194270): 4194270

    Created a new partition 1 of type 'Linux filesystem' and of size 2 GiB.
{% endhighlight %}


Tôi đã tạo xong phân vùng mới, tuy nhiên định dạng của nó là `Linux filesystem`, Cái tôi muốn là `Linux LVM`. Chọn chỉ mục có tên là `change a partion type`

![[4] Đổi loại phân vùng](/image/posts/2020-05-10-Gia-Tang-Logical-Volume/5.png)


Phần mềm sẽ chọn phân vùng duy nhất trong trường hợp này là `1`. Trong phần chọn loại phân vùng, `Linux LVM` có mã số là `31`.

![[4a] Đổi loại phân vùng](/image/posts/2020-05-10-Gia-Tang-Logical-Volume/6.png)


Kiểm tra lại với chỉ mục có tên `print the partition table`. Nó nên có phân vùng mới kèm theo là loại phân vùng có tên `Linux LVM`.

Kết thúc giai đoạn này với chỉ mục mang tên `write table to disk and exit`


![[5] Lưu lại thiết lập](/image/posts/2020-05-10-Gia-Tang-Logical-Volume/7.png)

## 3. Tạo phsyical volume [LEVEL 3]

Tạo physical volume với lệnh sau:

    pvcreate /dev/sdb1;

Kiểm tra xem physical volume đã tạo thành công từ `/dev/sdb1` với lệnh sau:

    pvs;



## 4. Gán physical volume vào volume group [LEVEL 4]

Tôi cần phải biết xem `logical volume` mà tôi cần gia tăng thuộc `volume group` nào. Sử dụng lệnh sau để xem danh sách `logical volume` hiện đang có cũng như là `volume group` mà nó thuộc về.
{% highlight text %}
lvs;
{% endhighlight %}

Trong trường hợp của tôi. `logical volume` mà tôi muốn gia tăng dung lượng là `home` và `root`. Cả hai logical volume này thuộc volume group có tên là `fedora`

Đây là lệnh để tìm xem thông tin của toàn bộ volume group. Hãy chú ý cột `VFree`, sau khi thêm `physical volume` vào `volume group`. giá trị của cột `VFree` phải tăng lên, tạo tiền đề để gia tăng các `logical volume` ở bước tiếp theo.

    vgs;

Đây là lệnh để gán physical volume `/dev/sdb1` vào volume group có tên là `fedora`.

    vgextend fedora /dev/sdc1;


## 5. Gia tăng dung lượng cho logical volume [LEVEL 5]

Đây là cả chỉ mục cần quan tâm:
- Sử dụng lệnh `lvextend` để gia tăng logical volume
- Sử dụng lệnh `resize2fs` để cập nhật file system

Tôi cần gia tăng logical volume có tên là `root` và `home`. Cụ thể là tôi muốn tăng 400 GB cho `home` và 100% phần còn dư cho `root`. Đây là cách làm.

    lvextend fedora/home --size +400GB;
    lvextend fedora/root --extents +100%FREE;

Để kiểm tra, hãy sử dụng lệnh sau: `lvs`. Tuy nhiên filesystem thì hoàn toàn chưa được cập nhật, hãy sử dụng lệnh sau để thấy sự khác biệt `df -h`, chú ý cột `Filesystem`, `Size` và cột `Mount on`


    df -h;

    Filesystem               Size  Used Avail Use% Mounted on
    devtmpfs                 7.8G     0  7.8G   0% /dev
    tmpfs                    7.8G  245M  7.6G   4% /dev/shm
    tmpfs                    7.8G   50M  7.8G   1% /run
    tmpfs                    7.8G     0  7.8G   0% /sys/fs/cgroup
    /dev/mapper/fedora-root  116G  111G    0G 100% /
    tmpfs                    7.8G   52K  7.8G   1% /tmp
    /dev/sda1                976M  255M  655M  28% /boot
    /dev/mapper/fedora-home  258G  258G    0G 100% /home

Trong trường hợp của tôi, hai filesystem mà tôi cần quan tâm là:

    /dev/mapper/fedora-root
    /dev/mapper/fedora-home

Để cập nhập filesystem sử dụng lệnh `resize2fs`

    resize2fs /dev/mapper/fedora-root;
    resize2fs /dev/mapper/fedora-home;

Bước cuối cùng, kiểm tra lại thông tin filesystem với `df -h`:

    df -h;

    Filesystem               Size  Used Avail Use% Mounted on
    devtmpfs                 7.8G     0  7.8G   0% /dev
    tmpfs                    7.8G  245M  7.6G   4% /dev/shm
    tmpfs                    7.8G   50M  7.8G   1% /run
    tmpfs                    7.8G     0  7.8G   0% /sys/fs/cgroup
    /dev/mapper/fedora-root  211G  111G  100G  52% /
    tmpfs                    7.8G   52K  7.8G   1% /tmp
    /dev/sda1                976M  255M  655M  28% /boot
    /dev/mapper/fedora-home  658G  258G  400G  39% /home

Phù phù phù, đã xong rồi đó.
