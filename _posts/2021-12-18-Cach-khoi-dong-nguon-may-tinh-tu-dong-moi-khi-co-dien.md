---
layout: post
title: "Cách khởi động nguồn máy tính tự động mỗi khi có điện?"
date: 2021-12-18 00:19:50
tags:
- Mining Rig
- PSU
categories:
- Mining Rig
seo_description: >
    Bài viết này tập trung giải quyết vấn đề khởi động máy tính tự động khi có điện dành cho bo mạch chủ không có cổng nhận
    jack 24-pin cấp điện từ nguồn (PSU), điện được lấy từ các jack 6 pin. Những bo mạch chủ này không hiếm gặp trên các dàn
    đào tiền mã hóa. Trên những bo mạch chủ này, không thể cài đặt thành công từ BIOS chế độ tự khởi động được  mà bạn sẽ
    cần chơi chiêu trên jack 24-pin.
seo_image: /image/posts/2021-12-18-Cach-khoi-dong-nguon-may-tinh-tu-dong-moi-khi-co-dien/1.png
comments: true
---
Bài viết này tập trung giải quyết vấn đề khởi động máy tính tự động khi có điện dành cho bo mạch chủ không có cổng nhận
jack 24-pin cấp điện từ nguồn (PSU), điện được lấy từ các jack 6 pin. Những bo mạch chủ này không hiếm gặp trên các dàn
đào tiền mã hóa. Trên những bo mạch chủ này, không thể cài đặt thành công từ BIOS chế độ tự khởi động được  mà bạn sẽ
cần chơi chiêu trên jack 24-pin.

Không dài dòng nữa, tất cả những gì bạn cần làm là chú ý đến dây 24-pin xuất ra từ bộ nguồn máy tính (PSU).

{% include image.html url="/image/posts/2021-12-18-Cach-khoi-dong-nguon-may-tinh-tu-dong-moi-khi-co-dien/1.png" description="[1] Sơ đồ jack 24-pin từ PSU." %}

Hai cổng duy nhất cần chú ý đó là cổng số `16` và `17`, bạn sẽ cần phải làm chúng nối tiếp nhau. Lưu ý nhìn cái ngàm ngang nó
nắm ở đâu nhé, cắm nhầm là căng thẳng đó. Trên hình bạn sẽ thấy cái ngạnh ngang nằm ở vị trí cổng số `18` và `19`.  Một lần nữa,
chú ý đừng có nhầm, bạn mà cắn nhầm sang cổng số `4` và `5` là toang đó nhé,  5 volt chạy thẳng vào ground. Cực mạnh.

Anh em thầy thợ có rất nhiều cách thú vị. Đôi khi là đấu dây trực tiếp 2 cổng này, hoặc xịn xò hơn thì sẽ dùng một cái chấu
chữ U để kết nối.

Dưới đây là hình ảnh ví dụ.

{% include image.html url="/image/posts/2021-12-18-Cach-khoi-dong-nguon-may-tinh-tu-dong-moi-khi-co-dien/2.png" description="[2] Hình ảnh thực tế." %}

Trích Dẫn:

- ATX 24-pin 12V Power Supply Pinout, Tim Fisher, July 29, 2020, [https://www.lifewire.com/atx-24-pin-12v-power-supply-pinout-2624578](https://www.lifewire.com/atx-24-pin-12v-power-supply-pinout-2624578)
