---
layout: post
title: "Cải thiện performance của MSI RTX 3080 TRIO X GAMING"
date: 2021-02-09 14:27:03
tags: overlock, msi3080, trio_x_gaming, mining
categories: Mining Rig
---

Hiện tại tôi đã và đang sử dụng card màn hình này để đào ETH. Chiếc card đồ họa này có vấn đề nghiêm trọng với việc tản nhiệt.
Về vấn để tản nhiệt này, người dùng không thể xem thông tin ở trên `MSI Afterburner`, phần mềm hiển thị nhiệt độ là trên con chip GPU
chứ không phải là trên các con chip chứa bộ nhớ.

Dưới đây là vài hình ảnh liên quan đến `MSI RTX 3080 TRIO X GAMING` sau khi bị tháo ra.
{% include image.html url="/image/posts/2021-02-09-Cai-thien-performance-cua-MSI-RTX-3080-TRIO-X-GAMING/1.jpg" description="[1] Bo mạch" %}
{% include image.html url="/image/posts/2021-02-09-Cai-thien-performance-cua-MSI-RTX-3080-TRIO-X-GAMING/2.jpg" description="[2] Lốc tản nhiệt" %}

TRIO sau khi mua về, cắm vào máy đào, chưa có chỉnh qua phần mềm `MSI Afterburner` có hashrate loanh quanh 87 88 MH/s. Tôi đã dành nhiều giờ
để tinh chỉnh `MSI Afterburner` thì TRIO có thể lên đc đến 93 MH/s. Tuy nhiên chỉ số này không kéo dài đc lâu, sau khi theo dõi sau 24 giờ,
giữ nguyên tinh chỉnh trên MSI, hasrate của TRIO xuống 81 MH/s. Điều này có nghĩa là tinh chỉnh, vọc vạch MSI Afterburner không giải quyết
dc nhu câu. có cái gì đó ở giữa có vấn đề.

{% include image.html url="/image/posts/2021-02-09-Cai-thien-performance-cua-MSI-RTX-3080-TRIO-X-GAMING/3.jpg" description="[3] MSI RTX 3080 TRIO X GAMING - Default Hashrate" %}

Tôi có tham khảo các bài viết trên reddit thì có khá nhiều người cũng gặp tình trạng này. Giải pháp được đưa ra sau cùng đó là:
- Sử dụng BIOS của `MSI RTX 3080 SUPRIM`, lý do là gia tăng điện cấp cho TRIO. **Gia tăng điện lên 116%**
- Thay pad tản nhiệt cho các chip bộ nhớ. **TRIO bị lock hashrate sau cùng là do các chip nhớ không tỏa nhiệt hiệu quả.**


Sau nhiều lần thử nghiệm với **thermal pad gelid (16W 1mm và 1.5mm)** và **gel tản nhiệt NOCTUA H2**. **Tôi nhận ra rằng độ cao 1mm là ổn áp nhất**.
Lưu ý răng bạn chỉ cần thay thermal pad nhiệt ở các con chip nhớ. Dưới đây là hình ảnh khu vực bạn cần thay pad nhiệt.

{% include image.html url="/image/posts/2021-02-09-Cai-thien-performance-cua-MSI-RTX-3080-TRIO-X-GAMING/4.jpg" description="[4] Khu vực thay pad nhiệt - Xanh lá và xanh lam" %}

Sau khi đã thay pad nhiệt thành công, bước tiếp theo sẽ là flash lại bios của TRIO. Cái này khá nguy hiểm.

- Bước 1: Vào [https://www.techpowerup.com/download/nvidia-nvflash/](https://www.techpowerup.com/download/nvidia-nvflash/), download bản mới nhất. Sau khi download xong, giải nén bạn sẽ có file `nvflash.exe`, ghi nhớ thư mục chứa cái file này, ví dụ là mình sẽ lưu ở `/User/Admin/Desktop/MSI_TRIO`
- Bước 2: Vào [https://www.techpowerup.com/vgabios/](https://www.techpowerup.com/vgabios/?architecture=NVIDIA&manufacturer=MSI&model=RTX+3080&interface=&memType=&memSize=&since=), tìm phiên bản mới nhất của dòng 3080 Suprim. Sau khi download xong, bạn sẽ được file có tên là `MSI.RTX3080.10240.201123.rom` (ví dụ) , copy file này ngang hàng với với `nvflash.exe`.
- Bước 3: Chạy `cmd` với quyền administrator, `change directory (cd)` vào `/User/Admin/Desktop/MSI_TRIO`. Lưu file room hiện tại của TRIO đang chạy với lệnh `nvflash.exe --save original.rom` . Trong trường hợp bạn fuck up, hay đơn giản là muốn xài bios gốc, hãy dùng file này `orignal.room`.
- Bước 4: Chạy lệnh `nvflash --protectoff` , gỡ bảo vệ bios.
- Bước 5: Chạy lệnh `nvflash MSI.RTX3080.10240.201123.rom --overridesub=true`.

Kể từ đây, TRIO đã có nhiều điện hơn vì xài BIOS của suprim, thêm vào đó nhiệt năng cũng hiệu quả hơn vì có thermal pad mới. Đừng quên là bạn còn chưa tinh trỉnh TRIO với `MSI Afterturner` Ở bài viết khác, mình sẽ nêu chi tiết thông tin tinh chỉnh của TRIO với Afterburner. Đây là terminal kết quả của mình sau khi tinh chỉnh. Chú ý GPU số 2, số 1 là `MSI RTX 3080 VENTUS 10G OC`.

{% include image.html url="/image/posts/2021-02-09-Cai-thien-performance-cua-MSI-RTX-3080-TRIO-X-GAMING/5.jpg" description="[5] Kết quả sau khi tinh chỉnh với MSI Afterburner" %}

{% include image.html url="/image/posts/2021-02-09-Cai-thien-performance-cua-MSI-RTX-3080-TRIO-X-GAMING/6.jpg" description="[6] Tổng quan dàn máy" %}

Đây là các link tôi đã tham khảo:
- MSI RTX 3080 Gaming X Trio is unstable when I mine and I can't get a good hashrate. What's going on here?, [https://www.reddit.com/r/EtherMining/comments/jowjaj/msi_rtx_3080_gaming_x_trio_is_unstable_when_i/](https://www.reddit.com/r/EtherMining/comments/jowjaj/msi_rtx_3080_gaming_x_trio_is_unstable_when_i/)
- MSI RTX 3080 Gaming X Trio Ethereum Mining FIX, [https://www.youtube.com/watch?v=MvaWnEf7c78&feature=youtu.be](https://www.youtube.com/watch?v=MvaWnEf7c78&feature=youtu.be)
