---
layout: post
title: "Cách chọn first-child trong mối quan hệ one-many trong database postgresql"
date: 2026-10-07 22:14:44
update:
location: Saigon
tags:
  - postgesql
  - onetomany
categories: SQL
seo_description: Cách chọn first-child trong mối quan hệ một nhiều, database postgresql
seo_image: /image/posts/2026-10-07-Cach-chon-first-child-trong-moi-quan-he-one-many-trong-database-postgresql/seo.avif
comments: true
---

Như mọi khi, trước khi đi sâu hơn vào mặt kỹ thuật, tôi cần phải miêu tả vấn đề tôi đang gặp phải. Đây là database diagram.

{% include image.html url="/image/posts/2026-10-07-Cach-chon-first-child-trong-moi-quan-he-one-many-trong-database-postgresql/1.avif" description="[1] Database diagram" %}

Tôi có hai table `products` và `product_variants`. Một `product` sẽ có nhiều `product_variants`. Các `product_variants` được sắp xếp theo thứ tự `display_order`.

Tôi muốn khai thác một số field của `product` và một số field của `product_variants` đầu tiên (`first-child`).

Table `products` (Đã tối giản)

| id | name                                     |
|----|------------------------------------------|
| 1  | Vàng miếng SJC                           |
| 2  | Vàng nhẫn DOJI Quý-Hưng-Thịnh-Vượng-Vinh |


Table `product_variants`(Đã tối giản)

| id | product_id | name               | price            | display_order |
|----|------------|--------------------|------------------|---------------|
| 1  | 1          | miếng 10 chỉ       | 150,000,000  VND | 1             |
| 2  | 1          | miếng 5 chỉ        | 75,000,000 VND   | 2             |
| 3  | 1          | miếng 2 chỉ        | 30,000,000 VND   | 3             |
| 4  | 1          | miếng 1 chỉ        | 15,000,000 VND   | 4             |
|    |            |                    |                  |               |
| 5  | 2          | nhẫn Vinh - 10 chỉ | 140,000,000      | 1             |
| 6  | 2          | nhẫn Vượng - 5 chỉ | 70,000,000       | 2             |
| 7  | 2          | nhẫn Thịnh - 2 chỉ | 28,000,000 VND   | 3             |
| 8  | 2          | nhẫn Hưng - 1 chỉ  | 14,000,000 VND   | 4             |
| 9  | 2          | nhẫn Quý - 0.5 chỉ | 7,000,000 VND    | 5             |


Và tôi muốn sau khi query sẽ có kết quả như sau, bạn nhìn kỹ nhé, tôi chỉ lấy `product_variant` có display_order nhỏ nhất:

| product_id | product_name                             | product_variant_id | product_variant_name | product_variant_price |
|------------|------------------------------------------|--------------------|----------------------|-----------------------|
| 1          | Vàng miếng SJC                           | 1                  | miếng 10 chỉ         | 150,000,000           |
| 2          | Vàng nhẫn DOJI Quý-Hưng-Thịnh-Vượng-Vinh | 5                  | nhẫn Vinh - 10 chỉ   | 140,000,000           |

---

Câu hỏi đã là rõ ràng, bây giờ là câu query, lưu ý là bạn sẽ cần phải sử dụng `distinct on` và `order`.

- `order` nhằm giúp sắp xếp dữ liệu theo `display order`
- `distinct on` là để loại trừ dữ liệu trùng lặp `product_id`
- Các bươc sẽ như sau:
    - [1] Chắc chắn là phải có `left join`
    - [2] Sắp xếp theo thứ tự `product_id asc` & `display_order asc`
    - [3] Dùng `distinct on (product_id)` để chỉ giữ lại row đầu tiên của mỗi `product_id`


```sql
select distinct on (p.id)
    p.id as product_id, p.name as product_name,
    pv.id as product_variant_id, pv.name as product_variant_name, pv.price as product_variant_price
from products p
left join product_variants pv on p.id = pv.product_id
order by p.id asc, pv.display_order asc;
```

Lưu ý, đây không phải là cách query nhanh nhất. Tôi thấy có `sequence scan` trong `Explain Execution Plan`. Hiện tại thì data của tôi vẫn chưa
đủ lớn để tối ưu hóa. Nó nên dành cho bài post khác chứ không phải là ngay bây giờ.

{% include image.html url="/image/posts/2026-10-07-Cach-chon-first-child-trong-moi-quan-he-one-many-trong-database-postgresql/2.avif" description="[2] Explain Execution Plan" %}

Đây không phải là cách nhanh nhất. Tuy nhiên, đây chắc chắn là câu query dễ chịu nhất để viết và đọc.
