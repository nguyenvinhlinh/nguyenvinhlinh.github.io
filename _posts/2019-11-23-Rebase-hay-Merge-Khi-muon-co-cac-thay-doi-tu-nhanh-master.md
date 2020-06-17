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


{% include image.html url="/image/posts/2019-11-23-Rebase-hay-Merge-Khi-muon-co-cac-thay-doi-tu-nhanh-master.md/1.png" description="[1] Nhánh feature-1 và feature-2" %}


Nhánh `feature-1`  hoàn thành sớm và nhanh chóng merge vào master.  Lúc này nhánh `master` đang có mã nguồn mới nhất từ nhánh `feature-1`. Vấn đề bây giờ đó là ở nhánh `feature-2`, nhánh `feature-2` hiện tại chưa phát triển xong, tuy nhiên nhánh `feature-2` muốn có các tính năng mới nhất mà hiện tại đang có ở nhánh `master`.


{% include image.html url="/image/posts/2019-11-23-Rebase-hay-Merge-Khi-muon-co-cac-thay-doi-tu-nhanh-master.md/2.png" description="[2] Nhánh feature-1 merge vào nhánh master, và tạo ra node màu xanh dương." %}


Sẽ có 2 cách làm trong kịch bản này:

- **Merge** từ nhánh `master` qua nhánh `feature-2`
- **Rebase** nhánh `feature-2` đến nhánh `master`

**Rebase** dịch sang tiếng việt có nghĩa là chuyển nền, còn có thể hiểu cách khác là chuyển `commit` nguồn của một nhánh sang một `commit` khác.

Lưu ý là nhánh master đang nói ở đây cụ thể là điểm commit mới nhất, cuối cùng trên nhánh `master`.

**Một lần nữa, vấn đề hiện tại đó là làm sao để nhánh `feature-2` có các tính năng mới nhất từ nhánh `master`
và rồi lập trình viên có thể phát triển tiếp trên nhánh `feature-2`.**


# II. Giải pháp
## 1. Merge từ nhánh `master` qua nhánh `feature-2`
{% include image.html url="/image/posts/2019-11-23-Rebase-hay-Merge-Khi-muon-co-cac-thay-doi-tu-nhanh-master.md/3.png" description="[3] Merge từ nhánh master qua nhánh feature-2" %}

## 2. Rebase nhánh `feature-2` qua nhánh `master`
{% include image.html url="/image/posts/2019-11-23-Rebase-hay-Merge-Khi-muon-co-cac-thay-doi-tu-nhanh-master.md/4.png" description="[4] Rebase nhánh feature-2 đến commit mới nhất của nhánh master" %}


Có thể nhận ra điểm khác biệt ngay lập tức đó là nhánh `feature-2` được phát triển dựa vào **commit màu xanh dương** thay vì là **màu xanh lá**.


# III. Ưu & Nhược Điểm.
## 1.  Merge từ nhánh `master` qua nhánh `feature-2`

**Ưu điểm**: Nhìn rõ các commit lịch sử của nhánh `feature-2`, từng commit lúc này hoàn toàn ko có dính dáng gì đến `commit`  mới nhất thuộc nhánh `master`2. Khi áp dụng giải pháp này, giả sử muốn quay lại các commit cũ thuộc nhánh `feature-2`, hoàn toàn là điểu dễ dàng, mã nguồn hoàn toàn không dính dáng gì đến nhánh `feature-1` hết.

**Nhược điểm**: Git log nhìn sẽ rất xấu.

{% include image.html url="/image/posts/2019-11-23-Rebase-hay-Merge-Khi-muon-co-cac-thay-doi-tu-nhanh-master.md/5.png" description="[5] git log khi áp dụng phương pháp merge" %}


## 2. Rebase nhánh `feature-2` sang commit mới nhất thuộc nhánh `master`

**Ưu điểm:** Git log nhìn sẽ cực kì, cực kì đẹp.

{% include image.html url="/image/posts/2019-11-23-Rebase-hay-Merge-Khi-muon-co-cac-thay-doi-tu-nhanh-master.md/6.png" description="[6] git log khi áp dụng phương pháp rebase" %}


**Nhược điểm:** Các commit cũ của nhánh `feature-2` lúc nhánh này dựa trên commit cũ thuộc nhánh master sẽ bị biến mất trên git log. Thay vào đó, các commit thuộc nhánh `feature-2` sẽ hoàn toàn dựa trên commit mới nhất thuộc nhánh `master`.  Giả sử như muốn quay lại các commit cũ, mã nguồn không dính dáng gì đến mã nguồn của `feature-1`, để làm được việc này khó khăn hơn rất nhiều so với phương pháp `merge`.

{% highlight text %}
Trên hình số [5] và [6], hãy chú ý đến các commits thuộc nhánh feature-2.
- [feature-2] change 1
- [feature-2] change 2
- [feature-3] change 3

Sau khi áp dụng phương pháp rebase, commit hash của các commits thuộc nhánh `feature-2` đã thay
đổi hoàn toàn. Ví dụ như commit có tên là: `[feature-2] change 3`

Commit hash đã thay đổi từ `2eea38a` sang `5c59d21`.

Hãy thử tưởng tượng xem nếu cần debug trong nhánh `feature-2` và áp dụng phương pháp `rebase`,
lập trình viên sẽ gặp khó khăn trong việc quay lại commit cũ của mình trước khi `rebase`.
Thêm vào đó, lúc tranh luận **LỖI CỦA ANH - LỖI CỦA TÔI**, cũng sẽ thêm ít nhiều vấn đề.

Để áp dụng phương pháp `rebase`, lập trình viên thật sự cần biết là anh ta đang làm gì và
chịu trách nhiệm cho nó.
{% endhighlight %}


## 3. Tóm tắt
{% highlight text %}
|------------+---------------------------------------+----------------------------------------|
|            | Merge                                 | Rebase                                 |
|------------+---------------------------------------+----------------------------------------|
| Ưu Điểm    | Nhìn rõ các commit lịch sử của nhánh  | Trên git log nhìn cực kì đẹp.          |
|            | feature-2, từng commit lúc này hoàn   | Các branch không bị lộn xộn,           |
|            | toàn ko có dính dáng gì đến commit    | chồng chéo nhau                        |
|            | mới nhất thuộc nhánh master           |                                        |
|------------+---------------------------------------+----------------------------------------|
| Nhược Điểm | Trên git log nhìn rất xấu. Các branch | Các commit cũ của nhánh `feature-2`    |
|            | bị chồng chéo.                        | lúc nhánh này dựa trên commit cũ       |
|            |                                       | thuộc nhánh master sẽ bị biến mất.     |
|            |                                       | Thay vào đó, các commit thuộc nhánh    |
|            |                                       | feature-2 sẽ hoàn toàn dựa trên commit |
|            |                                       | mới nhất thuộc nhánh master            |
|------------+---------------------------------------+----------------------------------------|
{% endhighlight %}
