---
layout: post
title: "Thông số dây AWG"
date: 2025-05-27 19:18:58
update:
location: Saigon
tags:
- electric
categories: etc
seo_description: Cường độ dòng điện tối đa cho dây điện theo tham chiếu AWG
seo_image: /image/posts/2025-05-27-Thong-so-day-AWG/seo.jpg
comments: true
---

| AWG Code | Max(A) |
|----------|--------|
| 10       | 55     |
| 11       | 47     |
| 12       | 41     |
| 13       | 35     |
| 14       | 32     |
| 15       | 28     |
|          |        |
| 16       | 22     |
| 17       | 19     |
| 18       | 16     |
| 19       | 14     |
| 20       | 11     |
|          |        |
| 21       | 9      |
| 22       | 7      |
| 23       | 4.7    |
| 24       | 3.5    |
| 25       | 2.7    |
|          |        |
| 26       | 2.2    |
| 27       | 1.7    |
| 28       | 1.4    |
| 29       | 1.2    |
| 30       | 0.86   |

# Câu hỏi và trả lời
## 1. Thông số Max(A) này là cột nào trong [https://www.powerstream.com/Wire_Size.htm](https://www.powerstream.com/Wire_Size.htm)?
Tôi sử dụng cột `Maximum amps for chassis wiring`
## 2. Chassis Wiring là gì?
`Chassis Wiring` – Dây trong thiết bị/bo mạch (nội bộ).

Ứng dụng: Bên trong tủ điện, thiết bị điện tử, bảng mạch, bo mạch nguồn.


## 3. Power Transmission Wiring là gì?
`Power Transmission` – Truyền tải điện (ngoài trời hoặc công nghiệp)

Ứng dụng: Dây điện trong nhà, ngoài trời, hệ thống cấp điện công nghiệp, trạm biến áp.

## 4. Tại sao có sự khác biệt lớn đến như vậy giữa `"Maximum amps for chassis wiring"` và `"Maximum amps for power transmission"`?
Tóm tắt lại sau cùng là vì vấn đề sinh nhiệt.

### Chassis Wiring – Dây trong thiết bị/bo mạch (nội bộ)
Mức dòng (amps) cao hơn

- Chiều dài dây thường rất ngắn, nên điện trở tổng thể thấp → tổn thất điện năng và sinh nhiệt ít.
- Lắp đặt trong môi trường có thể kiểm soát, chẳng hạn như bên trong hộp kim loại, thiết bị điện tử, nơi đã được tính toán kỹ về tản nhiệt.
- Tăng tính linh hoạt về thiết kế, vì các nhà sản xuất có thể cho phép dây chịu dòng cao hơn trong thời gian ngắn mà không gây cháy nổ.

### Power Transmission – Truyền tải điện (ngoài trời hoặc công nghiệp)
Mức dòng (amps) thấp hơn do:

- Chiều dài dây rất dài, tăng điện trở → tăng nhiệt → nguy cơ cháy hoặc hỏng cách điện.
- Dây thường được bó lại hoặc đi qua ống, làm giảm khả năng tản nhiệt.
- Yêu cầu độ an toàn và ổn định cao, vì đây là hệ thống truyền tải điện liên tục.
- Có thể đi qua môi trường khắc nghiệt, nên cần giới hạn dòng để đảm bảo độ bền dây lâu dài.

# References
- Wire Gauge and Current Limits Including Skin Depth and Tensile Strength, [https://www.powerstream.com/Wire_Size.htm](https://www.powerstream.com/Wire_Size.htm)
- ChatGPT, [https://chatgpt.com/](https://chatgpt.com/)
