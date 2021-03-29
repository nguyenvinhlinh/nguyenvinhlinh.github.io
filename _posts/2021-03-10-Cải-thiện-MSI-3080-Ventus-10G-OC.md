---
layout: post
title: "Cải thiện MSI 3080 Ventus 10G OC"
date: 2021-03-10 21:27:40
tags:
- MSI3080
- VENTUS 10G OC
categories:
- Minging Rig
---
# I. Lời nói đầu

Sau một thời gian dài chịu đựng sự ồn ào của bé trâu. Tôi đã quyết định cho bé lên trại. Sau một khoảng thời gian theo dõi vấn đề nhiệt độ của 3080 lại phát sinh.
Lần này không phải là của `MSI 3080 TRIO` mà là của `MSI 3080 VENTUS 10G OC`. Nguyên nhân chắc chắn là đến từ nhiều phía.

- Từ nhiệt độ môi trường xung quanh
- Từ cách thiết kế case 4U chưa hợp phù hợp cho những card màn hình sử dụng loại ram `GDDR6X`.
- Từ nguồn nhiệt tỏa ra từ những card màn hình xung quanh trong case 4U.
- Từ chính hệ thống tản nhiệt của card màn hình,
- Từ tôi, sự tham lam Hashrate của chính mình.

Ở bài viết này tôi sẽ miêu tả tình trạng của `MSI 3080 VENTUS 10G OC` trước và sau khi cải thiện, cũng như là cách thiết lập của mình trên `MSI Afterburner`

# II. Phương pháp

Tôi có tham khảo nhiều phương cách của những người chơi card màn hình 3090 trước. Họ gắn thêm ốp lưng nhôm cho card màn hình, tiếp theo là gắn quạt luôn. Cách tiếp cận này rất hiệu quả, tuy nhiên độ mỹ thuật và tinh tế có lẽ không tỷ lệ thuận với sự hiệu quả mà nó mang lại.

{% include image.html url="/image/posts/2021-03-10-Cai-thien-MSI-3080-Ventus-10G-OC/01.png" description="[1] Ốp nhôm + quạt cho lưng 3090. Ảnh tìm trên mạng" %}


Dưới đây là phương pháp tôi sử dụng. Tôi đã đốt một ngày nghỉ + một đống pad tản nhiệt gelid 15W và Gel tản nhiệt cho lần thử nghiệm này.

- Thay pad tản nhiệt của vram gốc thành gelid 15W - 2 mm
- Thay gel tản nhiệt Noctua H2
- Độn phần pad tản nhiệt của vram gốc thêm gelid 15W - 0.5 mm
- Cắt tấm mica thay thế ốp nhôm của case4U, đục lỗ để lắp quạt. Hút khí thổi ra từ card màn hình. Lý do sử dụng mica thay thì nhôm là vì ánh sáng LED nhấp nháy sẽ giúp bạn không lạc lối trên con đường đào coin khó khăn mệt mỏi.
- Lắp thêm 3 quạt nữa để hút khí nóng thổi ra từ card.


{% include image.html url="/image/posts/2021-03-10-Cai-thien-MSI-3080-Ventus-10G-OC/02.jpeg" description="[1] Gel Noctua H2 & Gelid 15W 1.0mm" %}

{% include image.html url="/image/posts/2021-03-10-Cai-thien-MSI-3080-Ventus-10G-OC/03.jpeg" description="[2] Tấm mica + đã đục lỗ lắp thêm quạt" %}

{% include image.html url="/image/posts/2021-03-10-Cai-thien-MSI-3080-Ventus-10G-OC/04.jpeg" description="[3] Quạt lắp thêm trên tấm mica." %}

{% include image.html url="/image/posts/2021-03-10-Cai-thien-MSI-3080-Ventus-10G-OC/05.jpeg" description="[5] 9/3/2021 21:57. Kết quả sau cùng" %}



# III. So sánh trước và sau (100MH/s)
## a. Trước

Để đạt được con số 100.433MH/s, mức thiết lập của tôi là:

- Power Limit: 80%
- Temperature Limit: 65C
- Core Clock: -502MHz
- Memory Clock: 1300Mhz

Với mức thiết lập này, nhiệt độ sẽ cho ra như sau:

- GPU Temperature: 62C
- GPU Memory Junction Temperature: 110C


{% include image.html url="/image/posts/2021-03-10-Cai-thien-MSI-3080-Ventus-10G-OC/06.png" description="[6] Card số #1, MSI VENTUS 10G OC - 100.433MH/s" %}

{% include image.html url="/image/posts/2021-03-10-Cai-thien-MSI-3080-Ventus-10G-OC/07.png" description="[7] Thiết lập MSI Afterburner." %}

## b. Sau

{% include image.html url="/image/posts/2021-03-10-Cai-thien-MSI-3080-Ventus-10G-OC/08.png" description="[8] MSI 3080 VENTUS 10G OC - 100.493MH/s" %}

Để đạt được con số 100.433MH/s, mức thiết lập của tôi cũng như lúc trước:

- Power Limit: 80%
- Temperature Limit: 65C
- Core Clock: -502MHz
- Memory Clock: 1300Mhz

Với mức thiết lập này, nhiệt độ sẽ cho ra như sau:

- GPU Temperature: 62C
- GPU Memory Junction Temperature: 96C

Kết luận đơn giản nhất mà tôi có thể đưa ra ngay lúc này đó là VRAM đã giảm đc 14 độ C. Từ 110 độ C xuống còn 96 độ C. Với những ai đang sở hữu
card màn hình có sử dụng vram loại `GDDR6X` đều muốn xuống dưới mức 100 độ C. 96 độ C cho vram chạy 100.433MH/s là rất tuyệt vời.


# IV. Mức thiết lập ổn định chạy 24/7 (95MH/s)

{% include image.html url="/image/posts/2021-03-10-Cai-thien-MSI-3080-Ventus-10G-OC/09.png" description="[9] 10/3/2021 11:45. Card số #3 MSI 3080 VENTUS 10G OC" %}

{% include image.html url="/image/posts/2021-03-10-Cai-thien-MSI-3080-Ventus-10G-OC/10.png" description="[10] 10/3/2021 21:21. Card số #3 MSI 3080 VENTUS 10G OC" %}

Để đạt được con số 95.539MH/s, mức thiết lập của tôi cũng như sau:

- Power Limit: 77%
- Temperature Limit: 65C
- Core Clock: -502MHz
- Memory Clock: 800Mhz

Với mức thiết lập này,  sau khi quan trắc nhiệt độ sẽ cho ra như sau:

- 11:45 trưa
    - GPU Temperature: 65C
    - GPU Memory Junction Temperature: 96C
- 21:21 tối
    - GPU Temperature: 63C
    - GPU Memory Junction Temperature: 94C

# V. Vấn đề

Tôi chắc chắn là đã khắc phục thành công vấn đề nhiệt của VRAM bằng cách thay pad và lắp thêm quạt. Tuy nhiên vì lý do thi công lắp đặt, tôi đã tạo ra vấn đề mới với GPU core.
Nhiệt độ của VRAM ở trên ảnh là ở mức dưới 100C, tuy nhiên nhiệt độ GPU thì bị tăng 1-2C lên 65-66C. Tôi sẽ tìm cách khắc phục vấn đề này sau.
Thời điểm tôi quan trắc cũng là vấn đề lớn, thông tin quan trắc bị ảnh hưởng nhiều bởi nhiệt độ xung quanh.
