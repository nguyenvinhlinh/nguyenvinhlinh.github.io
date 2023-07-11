---
layout: post
title: "Tại sao mắc thêm tải mà cường độ dòng điện lại tăng lên?"
date: 2022-04-13 00:21:23 +0700
location: Saigon
tags: physics, electronic
categories:
- Math & Physic
seo_description:
seo_image: /image/posts/2022-04-13-Tai-sao-mac-them-tai-ma-cuong-do-dong-dien-lai-tang-len/1.png
comments: true
---
Bài viết này miêu tả vấn đề về cường độ dòng điện (`A`) mà tôi gặp trong thực tế vì chính sự thiếu sót của tôi trong lúc lúc tính toán.

Bấy giờ, tôi đang làm việc với hai dàn đào là **Chu Tước** và **Huyền Vũ** , hai cỗ máy này là hai cỗ máy đào tiền ảo với linh kiện mạnh
nhất nhì thời điểm đó. Khoe khoang một chút thì **Chu Tước** sở hửu cho mình là **4 card 3080**, và **Huyền Vũ** là **170HX**.
Thời điểm viết bài này là **12/4/2022**, Hiện tại ở Việt Nam, gần như không có bài viết hình ảnh nào nói về card `170HX` và cũng như chủ sở
hữu, dân sưu tập đang khai thác. So sánh một chút với những người đào tiền mã hóa khác bên Châu Âu cũng như Mỹ, dàn **Huyền Vũ** có thể thua
dàn khác là vì số lượng card `170HX` chứ không phải là vì chất lượng linh kiện bên trong nó, `170HX` thuộc nhóm linh kiện mạnh nhất thời
điểm hiện tại, có lẽ chỉ thua `220HX`  một con quái vật có cực kì ít người sử dụng cũng như sưu tập. Và giờ thì hãy quay lại vấn đề chính.

Trong khi quan trắc hệ thống dàn đào, tôi nhận ra một điểm kì lạ.

Tại sao mỗi khi tôi tắt một trong hai dàn thì cường độ dòng điện lại giảm xuống. Theo như công thức `U = I x R`  , giả sử khi tôi tắt
một trong hai dàn,  hẳn là điện trở (`R`) sẽ giảm xuống, kéo theo đó, Cường độ dòng điện  tổng (`I`) sẽ phải tăng lên.

Tuy nhiên thực nghiệm thì lại khác. Mỗi khi tôi tắt một trong hai dàn đào, cường độ dòng điện tổng (`I`) lập tức giảm xuống, điều này làm
tôi phải cân nhắc suy nghĩ, tôi chắc chắn đã sai ở đâu rồi.

Sau khi ngồi vẽ vời và lục lại công thức cùng em trai tôi **(Hoàng Sơn),** tôi đã nhận ra sai lầm của mình. Việc tắt một dàn đào không
đồng nghĩa với việc giảm điện trở tổng (`R`) . **Tại sao? Tại vì tôi đang mắc mạch song song.**

{% include image.html url="/image/posts/2022-04-13-Tai-sao-mac-them-tai-ma-cuong-do-dong-dien-lai-tang-len/1.png" description="[1] Công thức tính điện trở tổng khi mắc song song" %}

**Khi tôi mắc song song, việc tôi mắc càng nhiều điện trở song song, tôi càng làm giảm điện trở tổng đi.** Theo như công thức `U=I x R` , khi tổng điện trở giảm xuống thì cường độ dòng điện sẽ phải tăng lên, `I↑ = U / R↓`  .

Điều này hoàn toàn lý giải câu hỏi của tôi bên trên đó là:

- Tại sao khi tôi tắt dàn đào, cường độ dòng điện lại giảm xuống,
- Tại sao khi tôi mở thêm dàn đào, cường độ dòng điện lại tăng lên.

**Lý giải đơn giản nhất đó là vì tôi đã mắc song song, càng mắc nhiều điện trở song song, tổng điện trở sẽ càng giảm. Và khi tổng điện trở giảm, cường độ dòng điện tổng chắc chắn sẽ phải tăng lên.**
