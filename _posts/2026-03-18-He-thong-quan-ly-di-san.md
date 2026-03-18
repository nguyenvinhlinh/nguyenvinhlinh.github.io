---
layout: post
title: "Hệ thống quản lý di sản"
date: 2026-03-18 18:37:55
update:
location: Saigon
tags:
- Elixir
- Phoenix
categories: Projects
seo_description: Tản mạn sau khi hoàn thành dự án quản lý di sản, khu trưng bày
seo_image: /image/posts/2026-03-18-He-thong-quan-ly-di-san/seo.jpg
comments: true
---

Hôm nay là 18/3/2026, tôi vừa update toàn bộ dependencies lên version mới nhất. Dự án chính thức chuyển sang trạng thái bảo trì.

Với các dự án tôi làm, tôi luôn cố gắng update library định kỳ (khoảng mỗi tháng một lần). Tin tôi đi, không ai muốn bảo trì một codebase cũ kỹ, lâu không update.

Ví dụ đơn giản: năm 2026 mà phải maintain `Phoenix 1.0.0` trong khi hiện tại là `1.8.x` — cảm giác không dễ chịu chút nào đâu.

---

Quay lại dự án này, nó sinh ra nhằm giải quyết các câu hỏi sau:

- Làm sau để biết món hàng X đang ở đâu trong 30,000m2, 20 khu trưng bày?
- Lịch sử giá bán, số lượng ra sao, ai là người thay đổi?
- Mỗi khách hàng lại cho giá khác nhau, làm sao để điều chỉnh giá cho từng người?
- Từ khi hàng trong kho cho đến tay khách hàng, trải qua những bước gì, ai giảm sát?
- Khách hàng không hài lòng, muốn trả hàng, quy ra sao, ai giảm sát? Trong số hàng hóa trả lại,
có bao nhiêu cái có thể đưa lên kệ và bán tiếp?
- Hàng hóa bao nhiêu lâu rồi chưa có người đến kiểm tra, đối soát?

---

Dự án này tôi làm một mình từ giai đoạn phân tích nghiệp vụ, viết phần mềm, triển khai.

Tôi đặc biệt không thích lạm dụng cloud, hay thêm nhiều technical stacks. Mỗi technical stack lại làm
cho người bảo trì đến sau mệt mỏi hơn một chút. Bên cạnh đó, phần cứng hiện tại đã quá rẻ, lượng data
cũng không lớn đến mức mà cần phải tối ưu hóa database, khách hàng cũng không cần hệ thống hoạt động
24/7 uptime 99%.

Càng đơn giản thì càng tốt. Tôi muốn như vậy.

Từ commit đầu tiên ngày **4/7/2025**, đến hôm nay là **18/3/2026**:
- Khoảng 9 tháng phát triển phần mềm
- Chính xác `777` commits - số đẹp 😇

Nhìn chung, tôi rất hài lòng với kết quả của dự án này, nó thực sự mang lại giá trị cho người dùng.

Hey, quên mất một cái rất quan trọng là tôi không chỉ viết phần mềm, tôi còn đến tận nơi, thu thập và nhập
dữ liệu vào hệ thống. Bằng cách thực làm và quan sát, tôi hiểu nỗi đau và tối ưu hóa nghiệp vụ tốt hơn ai
hết.

---

Có ba thứ mà tôi cực kỳ tâm đắc khi làm dự án này.

### 1. Luôn luôn cho phép con người sửa lỗi cho dù họ có làm điều ngu ngốc như thế nào chăng nữa

Việc lưu lại lịch sử thay đổi, có giá trị `cũ` và
`mới` giúp người dùng sửa sai nếu có nhầm lẫn. Tuyên ngôn là sai thì sửa, chửa thì đẻ.

Tuyên ngôn ở đây là: `Ngoại trừ việc sinh tử, tất cả thứ khác là chuyện nhỏ.`

### 2. Không phải lúc nào cũng cần message queue.

Nếu dữ liệu chỉ được update bởi một hành động tại một thời điểm, không cần thêm queue.

Thay vào đó, mình dùng một cơ chế đơn giản gọi là “Totem”:

- Muốn update đơn hàng -> phải có Totem
- Không có -> không được update
- Update xong -> trả lại Totem
- Nếu lỗi -> hệ thống tự thu hồi sau 15s

Nó giống như tín hiệu đường sắt: chỉ một người được đi qua tại một thời điểm.

Với hệ thống nhỏ, cách này đủ dùng, đơn giản.

**Tôi đã từng debug system sử dụng Kafka rồi, cảm ơn quá đủ rồi.**

### 3‌. Không nên lạm dụng AI trong quá trình nhập dữ liệu.

Dữ liệu đúng ngay từ đầu tốt hơn là phải xử lý hậu kỳ. Khi dữ liệu đến tay mình đã đúng, hệ thống phía sau nhẹ đi rất nhiều.

Tôi sẽ nói sơ qua một chút về khó khăn

Mỗi sản phẩm đều cần:
- dán tem (QR code + mã định danh)
- chụp ảnh
- nhập dữ liệu

Yêu cầu QR phải máy đọc được làm tăng đáng kể thời gian nhập liệu.

---

Giải pháp sau nhiều lần tối ưu đó là:
- Phát triển app android khác có tên là Batch Shot, nhằm mục tiêu chụp ảnh sản phẩm và chia ảnh vào folder riêng.
- Trong quá trình chụp ảnh, quét luôn mã QR Code, bỏ vào file `data.json` trong từng folder. Khai thác tối đa dữ liệu
lúc chụp ảnh, không đợi phải xử lý hậu kỳ
- Sau một ngày chụp ảnh sản phẩm, zip toàn bộ thư mục ảnh, gửi lên server.
- Server sau đó giải nén, có giao diện để nhập dữ liệu
- Các field có tính lặp lại đều có cache, không cần chọn lại khi nhập dữ liệu mới.

Kết quả là tôi giảm cực kỳ nhiều số thao tác khi nhập dữ liệu, tốc độ tăng nhanh đáng kể.

Viết đến đây cũng đã rất dài rồi, tôi sẽ share một vài hình ảnh không quá riêng tư. 😇

{% include image.html url="/image/posts/2026-03-18-He-thong-quan-ly-di-san/1.jpg" description="[1] Phòng trưng bày tư nhân" %}

{% include image.html url="/image/posts/2026-03-18-He-thong-quan-ly-di-san/2.jpg" description="[2] Danh sách di sản" %}

{% include image.html url="/image/posts/2026-03-18-He-thong-quan-ly-di-san/3.jpg" description="[3] Chi tiết di sản" %}

{% include image.html url="/image/posts/2026-03-18-He-thong-quan-ly-di-san/4.jpg" description="[4] Lịch sử thay đổi" %}
