---
layout: post
title: "Các vấn đề và cách khắc phục trên máy in 3D Creality K1 Max?"
date: 2025-04-09 21:32:57
update:
location: Saigon
tags:
- k1max
categories:
- 3D Print
seo_description: Xin chào, tôi đã sở hữu chiếc máy in 3D nhãn hiệu  K1 Max được gần một năm. Đây là một chiếc máy in tuyệt vời, tuy nhiên tin tôi đi, nếu bạn không may mắn, chiếc máy này sẽ hành bạn ra trò đấy. Tôi bị nó hành!
seo_image: /image/posts/2025-04-09-Cac-van-de-va-cach-khac-phuc-Creality-K1-Max/seo.jpg
comments: true
---
Xin chào, tôi đã sở hữu chiếc máy in 3D nhãn hiệu  **K1 Max** được gần một năm. Đây là một chiếc máy in tuyệt vời, tuy nhiên tin tôi đi, nếu
bạn không may mắn, chiếc máy này sẽ hành bạn ra trò đấy. **Tôi bị nó hành!**

## Vấn đề 1. Bàn cong vênh và nghiêng (bed mesh)
Nếu bạn chỉ in mỗi cái thuyền - 3DBenchy đi kèm theo máy thì sẽ chả sao đâu. Các vấn đề tôi gặp là khi in với bề mặt sàn lớn.

Nói một cách đơn giản hơn, việc có một lớp nhựa đầu tiên mới diện tích `25cm x 25cm` là điều không khả thi. Thực sự tệ hại! Đây chính là vấn đề đầu tiên!

Tôi thực sự ghét điều này! Tôi đã kỳ vọng rất nhiều ở K1 Max!

{% include image.html url="/image/posts/2025-04-09-Cac-van-de-va-cach-khac-phuc-Creality-K1-Max/1.jpg" description="[1] Nhìn mà xem, chán đời!" %}

Để giải quyết vấn đề này, chúng ta cần hiểu cơ cấu một chút. Có 2 bộ phần:

- Bàn gia nhiệt, nó đơn giản là tấm kim loại có dây mai xo bên dưới, tấm này có gắn lớp nam châm để gắn với bàn in. Tấm này bị cong vênh khi gia nhiệt,
thậm chí, độ cong vênh còn thay đổi theo thời gian.
- Giá đỡ tấm kim loại mà tôi đề cập bên trên. Cái giá đỡ này khi lắp ráp vào ty ren trục Z, nó được lắp không đều khiến khi bàn bị nghiêng.

{% include image.html url="/image/posts/2025-04-09-Cac-van-de-va-cach-khac-phuc-Creality-K1-Max/4.jpg" description="[4] Cơ cấu bàn gia nhiệt - heat bed" %}

Cách giải quyết như sau:
- Sử dụng bàn kính `Glass Bed` 310x320x4mm . Thứ này sẽ giúp khắc phục sự cong vênh của bàn gia nhiệt.
- Đệm cân bàn silicon giảm chấn - cao bằng nhau 16mm
- Bộ lò xo + ốc cân bàn M4. Thứ này kết hợp với đệm silicon giảm chấn giúp khắc phục độ chênh ở ty ren trục Z.

{% include image.html url="/image/posts/2025-04-09-Cac-van-de-va-cach-khac-phuc-Creality-K1-Max/5.jpg" description="[5] Bàn kính - 310x320x4mm" %}

{% include image.html url="/image/posts/2025-04-09-Cac-van-de-va-cach-khac-phuc-Creality-K1-Max/6.jpg" description="[6] Đệm cân bàn Silicone giảm chấn cho máy In 3D - cao 16mm " %}

{% include image.html url="/image/posts/2025-04-09-Cac-van-de-va-cach-khac-phuc-Creality-K1-Max/7.jpg" description="[7] Bộ lò xo ốc cân bàn M4 núm hoa" %}

## Vấn đề 2. Tắc nhựa trong bộ phận kéo nhựa (extruder)
Vấn đề thứ hai là tắc nhựa, Trong quá trình sử dụng bộ phận phun nhựa(`extruder`) có hiện tượng bị tắc nhựa, nhựa không thể đùn xuống vòi phun được. Anh em trên reddit hay gọi là `heat creep`, `jams`, `clogs`.
Nhiệt năng từ động cơ, truyền vào bánh răng đang kéo nhựa bên trong, hệ quả là chỗ nhựa tiếp xúc với bánh răng kéo nhựa bị mềm ra, sau cùng không đùn nhựa xuống được.

{% include image.html url="/image/posts/2025-04-09-Cac-van-de-va-cach-khac-phuc-Creality-K1-Max/2.jpg" description="[2] Động cơ kéo nhựa không được làm mát tốt." %}

{% include image.html url="/image/posts/2025-04-09-Cac-van-de-va-cach-khac-phuc-Creality-K1-Max/3.jpg" description="[3] Bên trong bộ đùn nhựa." %}

Cách giải quyết:
- Mở nắp máy in 3D khi in chất liệu PLA
- Giảm dòng điện cấp cho động cơ kéo nhựa, từ 0.55 amp xuống 0.45 amp. file `printer.cfg`
- Lắp lá tản nhiệt để làm mát động cơ

{% include image.html url="/image/posts/2025-04-09-Cac-van-de-va-cach-khac-phuc-Creality-K1-Max/9.jpg" description="[9] Giảm dòng điện của động cơ." %}

{% include image.html url="/image/posts/2025-04-09-Cac-van-de-va-cach-khac-phuc-Creality-K1-Max/8.jpg" description="[8] Tản nhiệt cho động cơ" %}


## Vấn đề 3. Tắc nhựa trong mũi (nozzle)
Ở thời điểm tôi mua máy, vòi phun của tôi là `unicorn nozzle`, loại mới nhất của Creality.

Vấn đề này sau khi vấn đề số tắc nhựa trong bộ phần kéo nhựa xảy ra. Có khả năng là nhựa trong đầu phun khi làm nóng quá lâu, biến chất, làm thô bề mặt trong đầu phun nhựa.

Để khắc phục vấn đề này, tôi hiện tại đang dùng đầu phun 0.6mm thay cho mũi bán kèm theo máy là 0.4mm

{% include image.html url="/image/posts/2025-04-09-Cac-van-de-va-cach-khac-phuc-Creality-K1-Max/10.jpg" description="[10] Vòi phun 0.6mm" %}

## Vấn đề 4. Ánh sáng yếu
Vấn đề thứ ba là ánh sáng, hệ thống ánh sáng của K1 Max phục vụ cho cái camera của nó chứ không phục vụ cho người xem trực tiếp. Ánh sáng khá là tối so với nhu cầu của tôi.

Giải pháp cho vấn đề này xem ở đây: [A new lightning system for K1 Max]({% post_url 2025-03-25-A-new-lightning-system-for-K1-Max %})

{% include image.html url="/image/posts/2025-04-09-Cac-van-de-va-cach-khac-phuc-Creality-K1-Max/11.jpg" description="[11] Thêm đèn LED 12V" %}


## Trích Dẫn và Nguồn gốc
- Direct Drive Extruder with motor for Creality K1, K1 Max 3D printers, [https://botland.store/extruders-creality/23435-direct-drive-extruder-with-motor-for-creality-k1-k1-max-3d-printers.html](https://botland.store/extruders-creality/23435-direct-drive-extruder-with-motor-for-creality-k1-k1-max-3d-printers.html)
- Underextrusion, Reddit, [https://www.reddit.com/r/k1max/comments/1g8dpd5/underextrusion/](https://www.reddit.com/r/k1max/comments/1g8dpd5/underextrusion/)
- Bộ lò xo ốc cân bàn M4 núm hoa cho Máy In 3D, shopee, [https://shopee.vn/B%E1%BB%99-l%C3%B2-xo-%E1%BB%91c-c%C3%A2n-ba%CC%80n-M4-n%C3%BAm-hoa-cho-Ma%CC%81y-In-3D-Creality-Ender-Anet-ET-Anycubic...-i.20067164.8155871743](https://shopee.vn/B%E1%BB%99-l%C3%B2-xo-%E1%BB%91c-c%C3%A2n-ba%CC%80n-M4-n%C3%BAm-hoa-cho-Ma%CC%81y-In-3D-Creality-Ender-Anet-ET-Anycubic...-i.20067164.8155871743)
- Tấm kính nền tinh thể Carbon Silicon Crystal Platform Glass Plate 310*310*4mm, [https://shopee.vn/T%E1%BA%A5m-k%C3%ADnh-n%E1%BB%81n-tinh-th%E1%BB%83-Carbon-Silicon-Crystal-Platform-Glass-Plate-310*310*4mm-i.205015530.9112399120?sp_atk=58852f76-865c-4341-910a-02face97e7ea&xptdk=58852f76-865c-4341-910a-02face97e7ea](https://shopee.vn/T%E1%BA%A5m-k%C3%ADnh-n%E1%BB%81n-tinh-th%E1%BB%83-Carbon-Silicon-Crystal-Platform-Glass-Plate-310*310*4mm-i.205015530.9112399120?sp_atk=58852f76-865c-4341-910a-02face97e7ea&xptdk=58852f76-865c-4341-910a-02face97e7ea)
- Đệm cân bàn Silicone giảm chấn cho máy In 3D, [https://shopee.vn/%C4%90%E1%BB%87m-c%C3%A2n-b%C3%A0n-Silicone-gi%E1%BA%A3m-ch%E1%BA%A5n-cho-m%C3%A1y-In-3D-i.20067164.17278012440](https://shopee.vn/%C4%90%E1%BB%87m-c%C3%A2n-b%C3%A0n-Silicone-gi%E1%BA%A3m-ch%E1%BA%A5n-cho-m%C3%A1y-In-3D-i.20067164.17278012440)
- Động cơ làm mát tản nhiệt Phụ tùng động cơ cho K1 K1Max K1C, Shopee, [https://shopee.vn/%C4%90%E1%BB%99ng-c%C6%A1-l%C3%A0m-m%C3%A1t-t%E1%BA%A3n-nhi%E1%BB%87t-Ph%E1%BB%A5-t%C3%B9ng-%C4%91%E1%BB%99ng-c%C6%A1-cho-K1-K1Max-K1C-i.1329098190.26112182650](https://shopee.vn/%C4%90%E1%BB%99ng-c%C6%A1-l%C3%A0m-m%C3%A1t-t%E1%BA%A3n-nhi%E1%BB%87t-Ph%E1%BB%A5-t%C3%B9ng-%C4%91%E1%BB%99ng-c%C6%A1-cho-K1-K1Max-K1C-i.1329098190.26112182650)
- Bộ vòi phun hoán đổi nhanh "Unicorn" Quick-Swap Nozzle cho máy in 3d Creality K1C, K1 Max, Ender-3 V3，Ender-3 V3 Plus, Shopee, [https://shopee.vn/B%E1%BB%99-v%C3%B2i-phun-ho%C3%A1n-%C4%91%E1%BB%95i-nhanh-Unicorn-Quick-Swap-Nozzle-cho-m%C3%A1y-in-3d-Creality-K1C-K1-Max-Ender-3-V3%EF%BC%8CEnder-3-V3-Plus-i.205015530.29500939838?sp_atk=20fcba8e-9768-454a-9240-c4282f7d8a9a&xptdk=20fcba8e-9768-454a-9240-c4282f7d8a9a](https://shopee.vn/B%E1%BB%99-v%C3%B2i-phun-ho%C3%A1n-%C4%91%E1%BB%95i-nhanh-Unicorn-Quick-Swap-Nozzle-cho-m%C3%A1y-in-3d-Creality-K1C-K1-Max-Ender-3-V3%EF%BC%8CEnder-3-V3-Plus-i.205015530.29500939838?sp_atk=20fcba8e-9768-454a-9240-c4282f7d8a9a&xptdk=20fcba8e-9768-454a-9240-c4282f7d8a9a)
