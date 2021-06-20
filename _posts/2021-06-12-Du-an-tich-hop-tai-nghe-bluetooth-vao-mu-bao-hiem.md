---
layout: post
title: "Tích hợp tai nghe bluetooth vào mũ bảo hiểm"
date: 2021-06-12 23:35:14
tags:
- bluetooth
- helmet
categories: Projects
comments: true
---

# I. Lý Do
Tôi hiện tại đang sở hữu một chiếc mũ bảo hiểm fullface. Về độ an toàn, mũ fullface được đánh giá là cao nhất về độ an toàn cho người sử dụng. Tuy nhiên ở vấn đề sử dụng hàng ngày, tôi không hoàn toàn hài lòng 100% khi sử dụng loại mũ này. Trong dự án tích hợp mũ bluetooth vào mũ fullface, tôi tập trung giải quyết vấn đề nghe của chiếc mũ này. Cá nhân tôi, tôi nhận thấy rằng việc nghe gọi điện thoại sử dụng mũ fullface khá là cồng kềnh vào nhiều thao tác. Tôi đã thử một vài giải pháp. Các bạn có thể tham khảo dưới đây.

- Sử dụng tai nghe nhét tai `in-ear`, kết nối qua jack 3.5mm. Điểm lợi của phương án này là nghe gọi tốt, tín hiệu siêu ổn định, giá thành siêu rẻ. Điểm bất lợi là môi trường âm thanh của người lá xe bị cô lập, gây nguy hiểm, đây là điểm yêu chí tử của phương án này. Khả năng cô lập âm thanh tất nhiên phụ thuộc vào từng loại tai nghe `in-ear`, tuy nhiên ở góc nhìn của tôi, tôi không hài lòng cho lắm. Bên cạnh đó, vấn đề dây nhợ hơi khó chịu, trong trường hợp của tôi, tai nghe **không có tính năng tăng/giảm âm lượng**, **chuyển nhạc tới/lui** cũng là một cái khó chịu nữa.
- Sử dụng tai nghe nhét tai `in-ear` bluetooth. Ngoài vấn đề cô lập môi trường âm thành chưa được giải quyết, vẫn tồn tại. Hạn chế tiếp theo của loại tai nghe này đó là việc **tăng/giảm âm lượng**, **chuyển bài hát tới/lui**. Thêm vào đó, việc **nhận/từ chối cuộc gọi** cũng phải thao tác trên máy điện thoại. Những vấn đề này làm ảnh hưởng đến trải nghiệm người dùng của tôi một cách tiêu cực.

Sau những lần thử như trên, tôi quyết định sử dụng phương án khác đó là lắp hẳn loa vào mũ bảo hiểm, cố tình gia tăng khoảng cách giữa tai người sử dụng và màng loa. Về mặt điều khiển, Việc **tăng/giảm âm lượng**, **chuyển bài hát tới/lui** , **nghe / từ chối cuộc gọi** sẽ được điểu khiển trực tiếp trên mũ bảo hiểm và không cần đến máy điện thoại. Về khía cạnh âm trường, tôi rất hài lòng về việc người lái xe không bị cô lập với môi trường xung quanh như tai nghe nhét tai, tăng tính an toàn khi lái xe. Về mặt điều khiển, phương án này hoàn toàn giải quyết vấn đề **tăng / giảm âm lượng**, **chuyển bài hát tới/lui**, **nghe /từ chối cuộc gọi**. Về vấn đề dây nhợ, hoàn toàn không phát sinh dây nhợ giữa mũ bảo hiểm và thiết bị phát âm thanh.


# II. Kỳ Vọng

Trong quá trình thử nghiệm, tôi đã cân nhắc về việc giấu mạch và đặt pin trong mũ. Tuy nhiên sau khi xem xong video pin phát nổ, tôi hoàn toàn không muốn tiếp cận theo hướng này. Quá nguy hiểm cho người sử dụng. Sự đánh đối là không xứng đáng.

Bên cạnh đó, tôi kì vọng rằng trong tương lại tôi sẽ có thể tích hợp mạch phát của thiết bị `SONY WH-1000XM4`. Mạch của chiếc tai nghe này thỏa mãn kha khá các nhu câu của tôi.

Tính năng nghe mà tôi đánh giá cực kì cao đó là khả năng **trộn âm thanh** của thiết bị, ở khía cạnh tích hợp vào mũ bảo hiểm, điều này sẽ giúp người nghe không bị tiếng động của người bên kia đầu dây át tiếng môi trường xung quanh, hay đơn giản hơn là tiếng nhạc. Bên cạnh đó, đó là khả năng **tái tạo vị trí của nguồn phát ra âm thanh**, nói một cách đơn giản, khi người lái xe, nghe được tiếng động cơ, thiết bị phải có khả năng giúp bộ não định hướng được nguồn phát từ đâu.

Tính năng thứ hai mà tôi quan tâm đó là khả năng chống ồn chủ động có chọn lọc, thiết bị cần lọc bớt âm thanh ồn ào không có lợi, điều chỉnh độ to của âm thanh không có lợi xuống mức vừa đủ.

Bên cạnh đó, tôi muốn phát triển thêm bộ điều khiển độc lập trên tay lái. Người lái xe sẽ không cần phải đưa tay lên mũ để làm các thao tác ví dụ như **nghe / từ chối cuộc gọi**.


# III. Thử Nghiệm & Hình Ảnh

{% include image.html url="/image/posts/2021-06-12-Du-an-tich-hop-tai-nghe-bluetooth-vao-mu-bao-hiem/1.jpg" description="[1] Chụp từ bên trái" %}
{% include image.html url="/image/posts/2021-06-12-Du-an-tich-hop-tai-nghe-bluetooth-vao-mu-bao-hiem/2.jpg" description="[2] Chụp từ bên phải" %}



Đây là phiên bản mẫu đã chạy thử nghiệm được hơn một tháng. Mẫu thử hoạt động hoàn toàn bình thường với các tính năng sau.

- Tăng / giảm âm lượng
- Nhận / từ chối cuộc gọi
- Chuyển tới / lui bài hát

Khi tiến hành chạy thử nghiệm, điều tôi lo ngại nhất đó là việc chạy xe bị cô lập âm thanh. Cách tiếp cận theo hướng `over-ear` đã giải quyết được phần nào vấn đề này. Âm thanh người lái xe tiếp nhận hoàn toàn không bị cô lập. Trong suốt khoảng thời gian thử nghiệm sản phẩm này, tôi đã không gặp bất cứ tai nạn nào liên quan đến vấn đề bị cô lập âm trường.

Khi chạy xe qua các khu vực dân cư đông đúc, tôi phát hiện ra rằng tình trạng nhiễu sóng xảy ra khá nhiều. Loanh quanh 4-8 lần tín hiệu bị ngắt, điều này ảnh hưởng không nhỏ đến trải nghiệm nghe. Tuy nhiên, tôi tin rằng, bằng cách sử dụng **mạch thu/phát bluetooth** xịn xò hơn vấn đề nãy sẽ được cải thiện.

Bên cạnh đó, khi lái xe, việc phải đưa tay lên mũ ấn nút cũng hoàn toàn có thể cải thiện. Ở các phiên bản tiếp theo, tôi hi vọng mình còn tham lam để phát triển thêm bộ điểu khiển trên tay lái.
