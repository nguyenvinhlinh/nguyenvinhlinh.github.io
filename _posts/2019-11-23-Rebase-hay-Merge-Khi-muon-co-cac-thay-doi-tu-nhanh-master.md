---
layout: post
title: Rebase hay Merge Khi muốn có thay đổi từ nhánh Master
date: 2019-11-23 00:15:35 +0700
categories: Git
tag: git
comments: true

---

# I. Giới Thiệu

Khi phát triển phần mềm việc chia nhánh để phát triển độc lập, song song luôn xảy ra. Có nhánh xong trước, có nhánh sẽ hoàn thành sau. Làm sau để các nhánh chưa hoàn thành có thể có những tính năng từ nhánh chính (nhánh master)  là vấn đề của bài viết này.

Kịch bản cụ thể như sau. Có 2 tính năng phát triển độc lập với nhau, theo lẽ đương nhiên, lập trình viên sẽ tạo ra 2 nhánh riêng biệt từ nhánh `master`. Hai nhánh này sẽ có tên lần lượt là

- feature-1
- feature-2
![[1] Nhánh feature-1 và feature-2](https://paper-attachments.dropbox.com/s_9A5922A5E1B2FE32362A01401C8777056248ABCA0BD0B2C251102B65A6C8F176_1574493875961_1.png)


Nhánh `feature-1`  hoàn thành sớm và nhanh chóng merge vào master.  Lúc này nhánh `master` đang có mã nguồn mới nhất từ nhánh `feature-1`. Vấn đề bây giờ đó là ở nhánh `feature-2`, nhánh `feature-2` hiện tại chưa phát triển xong, tuy nhiên nhánh `feature-2` muốn có các tính năng mới nhất mà hiện tại đang có ở nhánh `master`.



![[2] Nhánh feature-1 merge vào nhánh master, và tạo ra node màu xanh dương.](https://paper-attachments.dropbox.com/s_9A5922A5E1B2FE32362A01401C8777056248ABCA0BD0B2C251102B65A6C8F176_1574493965302_2.png)


Sẽ có 2 cách làm trong kịch bản này:

- **Merge** từ nhánh `master` qua nhánh `feature-2`
- **Rebase** nhánh `feature-2` đến nhánh `master`

**Rebase** dịch sang tiếng việt có nghĩa là chuyển nền, còn có thể hiểu cách khác là chuyển `commit` nguồn của một nhánh sang một `commit` khác.

Lưu ý là nhánh master đang nói ở đây cụ thể là điểm commit mới nhất, cuối cùng trên nhánh `master`.

**Một lần nữa, vấn đề hiện tại đó là làm sao để nhánh** `**feature-2**` **các các tính năng mới nhất từ nhánh** `**master**` **và rồi phát triển tiếp trên nhánh** `**feature-2**`**.**


# II. Giải pháp
## 1. Merge từ nhánh `master` qua nhánh `feature-2`
![[3] Merge từ nhánh master qua nhánh feature-2](https://paper-attachments.dropbox.com/s_9A5922A5E1B2FE32362A01401C8777056248ABCA0BD0B2C251102B65A6C8F176_1574494447506_3.png)

## 2. Rebase nhánh `feature-2` qua nhánh `master`
![[4] Rebase nhánh feature-2 đến commit mới nhất của nhánh master](https://paper-attachments.dropbox.com/s_9A5922A5E1B2FE32362A01401C8777056248ABCA0BD0B2C251102B65A6C8F176_1574494782199_4.png)


Có thể nhận ra điểm khác biệt ngay lập tức đó là nhánh `feature-2` được phát triển dựa vào **commit màu xanh dương** thay vì là **màu xanh lá**.


# III. Ưu & Nhược Điểm.
## 1.  Merge từ nhánh `master` qua nhánh `feature-2`

**Ưu điểm**: Nhìn rõ các commit lịch sử của nhánh `feature-2`, từng commit lúc này hoàn toàn ko có dính dáng gì đến `commit`  mới nhất thuộc nhánh `master`2. Khi áp dụng giải pháp này, giả sử muốn quay lại các commit cũ thuộc nhánh `feature-2`, hoàn toàn là điểu dễ dàng, mã nguồn hoàn toàn không dính dáng gì đến nhánh `feature-1` hết.

**Nhược điểm**: Git log nhìn sẽ rất xấu.

![[5] git log khi áp dụng phương pháp merge](https://paper-attachments.dropbox.com/s_9A5922A5E1B2FE32362A01401C8777056248ABCA0BD0B2C251102B65A6C8F176_1574497220779_Screenshot+from+2019-11-23+14-56-01.png)



## 2. Rebase nhánh `feature-2` sang commit mới nhất thuộc nhánh `master`

**Ưu điểm:** Git log nhìn sẽ cực kì, cực kì đẹp.

![[6] git log khi áp dụng phương pháp rebase](https://paper-attachments.dropbox.com/s_9A5922A5E1B2FE32362A01401C8777056248ABCA0BD0B2C251102B65A6C8F176_1574497211247_Screenshot+from+2019-11-23+15-18-13.png)


**Nhược điểm:** Các commit cũ của nhánh `feature-2` lúc nhánh này dựa trên commit cũ thuộc nhánh master sẽ bị biến mất trên git log. Thay vào đó, các commit thuộc nhánh `feature-2` sẽ hoàn toàn dựa trên commit mới nhất thuộc nhánh `master`.  Giả sử như muốn quay lại các commit cũ, mã nguồn không dính dáng gì đến mã nguồn của `feature-1`, để làm được việc này khó khăn hơn rất nhiều so với phương pháp `merge`.


| Trên hình số [5] và [6], hãy chú ý đến các commits thuộc nhánh feature-2. <br><br>- [feature-2] change 1<br>- [feature-2] change 2<br>- [feature-3] change 3<br><br>Sau khi áp dụng phương pháp rebase, commit hash của các commits thuộc nhánh `feature-2`  đã thay đổi hoàn toàn. Ví dụ như commit có tên là: `[feature-2] change 3`<br> Commit hash đã thay đổi từ `2eea38a` sang `5c59d21`. <br> <br> Hãy thử tưởng tượng xem nếu cần debug trong nhánh `feature-2` và áp dụng phương pháp `rebase`, lập trình viên sẽ gặp khó khăn trong việc quay lại commit cũ của mình trước khi `rebase`. Thêm vào đó, lúc tranh luận **LỖI CỦA ANH - LỖI CỦA TÔI**, cũng sẽ thêm ít nhiều vấn đề. <br> <br> Để áp dụng phương pháp `rebase`, lập trình viên thật sự cần biết là anh ta đang làm gì và chịu trách nhiệm cho nó. |



## 3. Tóm tắt
|                | **Merge**                                                                                                                                      | **Rebase**                                                                                                                                                                                                            |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Ưu Điểm**    | Nhìn rõ các commit lịch sử của nhánh `feature-2`, từng commit lúc này hoàn toàn ko có dính dáng gì đến `commit`  mới nhất thuộc nhánh `master` | Trên git log nhìn cực kì đẹp. Các branch không bị lộn xộn, chồng chéo nhau                                                                                                                                            |
| **Nhược Điểm** | Trên git log nhìn rất xấu. Các branch bị chồng chéo.                                                                                           | Các commit cũ của nhánh `feature-2` lúc nhánh này dựa trên commit cũ thuộc nhánh master sẽ bị biến mất.<br>Thay vào đó, các commit thuộc nhánh `feature-2` sẽ hoàn toàn dựa trên commit mới nhất thuộc nhánh `master` |
