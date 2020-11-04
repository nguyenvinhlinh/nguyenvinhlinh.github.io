---
layout: post
title: "Postgresql - Thiết lập hot-standby"
date: 2020-11-04 16:33:36
tags: linux, postgresql, fedora
categories: Postgresql
---

# I. Khái niệm

Trước khi đọc sâu hơn về cách thiết lập `replication` này, tôi sẽ giải thích về mô hình `hot-standby`. Ở mô hình này, máy `standby` sẽ có khả năng bị `read` (đọc), khi máy `primary` xảy ra vấn đề, máy `standby` sẽ được tăng cấp thành `primary` mới, cho phép nó có khả năng `read/write` (đọc/ ghi).

Khi áp dụng kỹ thuật này, có thể sử dụng thêm database proxy để giảm áp lực `read` cho máy `primary`.

Nói về dữ liệu, 99.999999999% là dữ liệu trên máy `standby` sẽ giống với máy `primary`. Lý do mà nó không đạt được đến mức 100% là do khi máy `primary` chết, máy `primary` không gửi `write-ahead-log` cho máy `standby` được, việc này dẫn đến hệ quả là máy `standby` không có dữ liệu.

Ở bài viết này, sẽ tập trung nói đến việc làm sao để thiết lập `hot-standby replication` cũng như cách kích hoạt thủ công `hot-standby server` để nó trở thành `primary server` mới. Vấn đề phục hồi `primary cũ` sẽ được nói ở bài viết tiếp theo.

{% include image.html url="/image/posts/2020-11-04-Postgresql---Thiet-lap-hot-standby/1.png" description="[1] Mô hình hot-standby replication" %}

# II. Thiết lập
## 1. Cài đặt Postgresql (2020-11-04 tested)

Ở bài hướng dẫn này, tôi sử dụng server là Fedora. Hướng dẫn trên mạng rất nhiều để tiện theo dõi trên bài viết tôi sẽ viết lại ở đây.

Bạn vào website: [https://www.postgresql.org/download/linux/redhat/](https://www.postgresql.org/download/linux/redhat/), trong phần chỉ mục `PostgreSQL Yum Repository`, hãy điền hết cái form, sau khi điền xong một đoạn script cài đặt sẽ hiện ra, bạn chỉ việc copy-paste vào terminal là chạy. Việc cài đặt này là tiêu chuẩn và áp dụng trên cả máy `primary` và `standby`.

Ví dụ như tôi đang sử dụng **fedora 32 x64**, muốn xài **postgresql-11**, sau khi điền xong form, tôi sẽ nhận được đoan script sau:

``` sh
# Install the repository RPM:
sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/F-32-x86_64/pgdg-fedora-repo-latest.noarch.rpm

# Install PostgreSQL:
sudo dnf install -y postgresql12-server

# Optionally initialize the database and enable automatic start:
sudo /usr/pgsql-12/bin/postgresql-12-setup initdb
sudo systemctl enable postgresql-12
sudo systemctl start postgresql-12
```

## 2. Thiết lập máy `primary`

### a. Tạo user

Bạn sẽ cần phải tạo 2 users


| user/password   | role        |
| --------------- | ----------- |
| repuser/repuser | replication |
| admin/admin     | superuser   |


Để thiết lập relication, thực sự chỉ cần đến user với role là `replication` mà thôi. Tôi chủ động tạo thêm một superuser mới có tên là `admin`.

Vào terminal, và chạy lệnh sau:
``` sh
# Chuyển qua user postgresql trên hệ điều hành
sudo su postgres;
# Tao user repuser/repuser
createuser --no-login --pwprompt --replication repuser;
# Tạo user admin/admin
createuser --pwprompt --superuser admin;
```

### b. Thay đổi `pg_hba.conf` để cấp quyền truy cập


``` text
host    all             admin           0.0.0.0/0                         md5
host    replication     repuser         {standy_server_ip}/{mask}         md5
```

{% include image.html url="/image/posts/2020-11-04-Postgresql---Thiet-lap-hot-standby/2.png" description="[2] pg_hba.conf" %}


Ở trên hình thì `IP/MASK` của máy standby là `192.168.2.43/24`.


### c. Thay đổi** `postgresql.conf`

``` text
listen_addresses = '*'
wal_level = replica
archive_command = 'test ! -f /var/lib/pgsql/11/data/archivedir/%f && cp %p /var/lib/pgsql/11/data/archivedir/%f'
max_wal_senders = 3
wal_log_hints = on
```
Lưu ý archive_command, `/var/lib/pgsql/11/data/archivedir/` là thư mục cần phải tạo thêm, nếu chưa có hãy tạo nó sử dụng lệnh sau:
``` sh
mkdir -p /var/lib/pgsql/11/data/archivedir/
```


| Thiết Lập        | Ý Nghĩa                                                                                                                                                                                                                   |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| listen_addresses | Liệt kê IP được phép truy cập vào database server bằng postgresql client                                                                                                                                                  |
| wal_level        | Mức độ chi tiết của wal, để dữ liệu trong file wal đủ chi tiết để phục hồi, giá trị cần là `replica`                                                                                                                      |
| archive_command  | command sử dụng để lưu trữ write-ahead-log vào thư mục archive. Ở thiết lập phía trên, nó đầu tiên kiểm tra xem trong thư mục archive có tồn tại file chưa, nếu chưa nó sẽ copy file write-ahead-log vào thư mục archive. |
| max_wal_senders  | Số lượng tối đa wal_senders chạy đồng thời với nhau. Nói một cách khác nó chỉ thị số lượng tối đa các kết nối từ `standby server` đến primary                                                                             |
| wal_log_hints    | Config này quan trong trong việc đồng bộ hóa server `primary cũ` với `primary mới`.                                                                                                                                       |


Kể từ bước này trở đi, máy `primary` đã có thể khởi động postgresql server.
``` sh
systemctl start postgresql-11;
```


## 3. Thiết lập máy `standby`

Trước khi chạy các bước tiếp theo, bắt buộc phải tắt postgresql. Đây là bắt buộc
``` sh
systemctl stop posgresql-11;
```

### a. Kéo thư mục `data` từ máy `primary` sang `standby`

- Di chuyển thư mục `data` cũ đến nơi khác.
``` sh
mv /var/lib/pgsql/11/data /var/lib/pgsql/11/data_bak;
```
- Sử dụng `pg_basebackup` để kéo thư mục data từ máy `primary` đến máy `standby`
``` sh
pg_basebackup --pgdata /var/lib/pgsql/11/data -h 192.168.2.68 -p 5432 -U repuser \
                --password --verbose --progress --write-recovery-conf \
                --wal-method stream
```

Sau khi chạy xong, bạn sẽ thấy màn hình tương tự như sau.

{% include image.html url="/image/posts/2020-11-04-Postgresql---Thiet-lap-hot-standby/3.png" description="[3] pg_basebackup" %}

Thêm vào đó, trong thư mục `data` sẽ có thêm 2 file

- postgresql.auto.conf
- recovery.conf

### b. Thiết lập file `recovery.conf`


File `recovery.conf` được tạo ra từ lệnh `pg_basebackup` với flag `--write-recovery-conf`. Nội dung của nó đề cập đến chế độ hiện tại của `standby server` và vị trị của `primary server`.

``` text
    # Nội dung file recovery.conf
    standby_mode = 'on'
    primary_conninfo = 'user=repuser password=repuser host=192.168.2.68 port=5432 sslmode=prefer sslcompression=0 krbsrvname=postgres target_session_attrs=any'
```
Trong file `recovery.conf`, có thể thấy rõ ràng thông tin truy cập vào `primary server`

### c. Thiết lập `posgresql.conf`

``` text
hot_standby = on
```

Kể từ bước này trở đi, khởi chạy postgresql server trên `standby server`.
``` sh
systemctl start postgresql-11;
```


## 4. Kích hoạt `Standby server` thành `Primary server`
`Không chạy lệnh sau bây giờ, chỉ chạy nó khi bạn biết rằng primary server đã chết.`

Để chuyển chế độ của `standby server` từ `standby` thành `primary`, bạn phải chạy lệnh sau trên `standby server`.

``` sh
/usr/pgsql-11/bin/pg_ctl promote --pgdata /var/lib/pgsql/11/data;
```

# III. Kiểm tra
## 1. Kiểm tra xem có những standby server nào đang kết nối.

Vào `primary server` và chạy sql sau:
``` sql
select * from pg_stat_replication;
```
Đây là kết quả nên nhận được, bạn sẽ thấy rõ ràng IP của `standby server`

``` text
    Name            |Value              |
    ----------------|-------------------|
    pid             |1670               |
    usesysid        |16384              |
    usename         |repuser            |
    application_name|walreceiver        |
    client_addr     |192.168.2.43       |
    client_hostname |                   |
    client_port     |51962              |
    backend_start   |2020-11-04 15:57:03|
    backend_xmin    |                   |
    state           |streaming          |
    sent_lsn        |0/F02F468          |
    write_lsn       |0/F02F468          |
    flush_lsn       |0/F02F468          |
    replay_lsn      |0/F02F468          |
    write_lag       |                   |
    flush_lag       |                   |
    replay_lag      |                   |
    sync_priority   |0                  |
    sync_state      |async              |
```

## 2. Tạo/Xóa Bảng

Tôi sẽ sử dụng `dbeaver` để tạo bảng, thêm record, xóa record trên `primary server`. Tôi kì vọng là sau khi làm những thao tác trên, dữ liệu trên `standby server` phải giống với dữ liệu trên `primary server`.

Tôi chạy sql tạo bảng `people` trên máy `primary`.
``` sql
    CREATE TABLE public.people (
            id serial NOT NULL,
            "name" varchar NULL,
            CONSTRAINT people_pk PRIMARY KEY (id)
    );
```
{% include image.html url="/image/posts/2020-11-04-Postgresql---Thiet-lap-hot-standby/4.png" description="[4] primary server, tạo bảng people" %}
{% include image.html url="/image/posts/2020-11-04-Postgresql---Thiet-lap-hot-standby/5.png" description="[5] standby server, xuất hiện bảng people" %}


## 3. Thêm/xóa record

Để thêm record cho bảng `people`, tôi chạy câu sql sau:

``` sql
    insert into people (name) values ('Linh'), ('Son'), ('Long'), ('TTEK');
```
Để xóa record cho bảng `people`, tôi chạy câu sql sau:
``` sql
    delete from people where name = 'TTEK';
```
Khi kiểm tra dữ liệu trên máy `primary` và máy `standby` dữ liệu là giống hệt nhau.


# IV. Câu kết

Vậy là việc thiết lập `hot standby` server đã hoàn tất. Ở bài viết tiếp theo, tôi sẽ nói về tình huống server `primary` chết, server `standby` chiếm quyền và đóng vai trò là server `primary` mới. Vấn đề xảy ra khi chúng ta muốn khởi động lại server `primary cũ`, và muốn lấy toàn bộ dữ liệu mới đc thay đổi trên máy `primary mới` và thiết lập máy `primary cũ` trở thành máy `standby mới`.
