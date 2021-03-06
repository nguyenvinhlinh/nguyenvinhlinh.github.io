---
layout: post
title: Tổng hợp các loại merge
date: 2019-11-23 00:13:34 +0700
categories: Git
tag: git
comments: true

---

# 1. Giới thiệu

Khi `merge` hai branch với nhau, có những kiểu merge như sau

- **no fast forward**: không chuyển tiếp nhanh
- **fast forward**: chuyển tiếp nhanh
- **squash**: nén 🏋️

# 2. Chi tiết từng loại merge
## a. No Fast Forward (--no-ff)

Khi merge ở chế độ `no fast forward`, một **commit  merge** sẽ được tạo ra trên `git log` cho dù khi `merge` có xảy ra `conflict` hay không. Đây là sở đồ khối khi áp dụng cách merge `no fast forward`

{% include image.html url="/image/posts/2019-11-23-Tong-hop-cac-loai-merge.md/1.png" description="[1] No Fast Forward Merge" %}

Lưu ý là sự khác nhau giữa các loại merge là ở commit merge cuối cùng (màu hồng)
Như ở trên sơ đồ khối, sự thay đổi của của nhánh(`branch`) tồn tại ở trên (`B1`, `B2`, `B3`), điểm cuối cùng (màu hồng) thực chất không có chứa thay đổi gì cả, ngoài trừ việc lưu ý rằng đây là `commit` merge từ nhánh có tên là `branch` vào nhánh `master`.


## b. Fast Forward (--ff-only)

Khi merge ở chế độ `fast forward`, các commit từ nhánh mới sẽ chuyển tiếp qua nhánh đích và không có **merge commit** được tạo ra. Đây là sơ đồ khối các branch trước khi merge, không có commit màu hồng như đồ thị dành cho `--no-fast-forward`

{% include image.html url="/image/posts/2019-11-23-Tong-hop-cac-loai-merge.md/2.png" description="[2] Before Fast Forward Merge" %}

Và đây là sơ đồ khối sau khi merge từ nhánh `branch` qua `master`

{% include image.html url="/image/posts/2019-11-23-Tong-hop-cac-loai-merge.md/3.png" description="[3] After Fast Forward Merge" %}

Như trong hình vẽ, nếu áp dụng `fast forward`, hoàn toàn không có **merge commit** như là `no fast forward`


## c. Squash (--squash)

`Squash` có nghĩa là đè nén. Khi merge theo kiểu `squash` tất cả các commit thuộc nhánh sẽ bị nén với nhau lại sau đó merge vào nhánh đích. Đây là sơ đồ khối trước khi áp dụng merge `squash` (nó giống như là hình **trước** khi merge theo kiểu `fast forward merge`.

{% include image.html url="/image/posts/2019-11-23-Tong-hop-cac-loai-merge.md/4.png" description="[4] Before Squash Merge" %}

Còn đây là sơ đồ khối sau khi merge theo kiểu `squash`.

{% include image.html url="/image/posts/2019-11-23-Tong-hop-cac-loai-merge.md/5.png" description="[5] After Squash Merge" %}

Như trong sơ đồ khối trên, sau khi merge theo kiểu `squash`, tất cả thay đổi trong các `commit` (`B1`, `B2`, `B3`) đều được nén lại thành một commit duy nhất (màu hồng). Khi mở `git log` của master, người xem sẽ chỉ thấy có commit đã nén mà ko thấy các commit (`B1`, `B2`, `B3`).


# 3. Ưu điểm và nhược điểm
## a. Fast Forward

**Ưu Điểm:**
Khi nhìn vào `git log` ở nhánh bị `merge` vào, người xem sẽ thấy toàn bộ các commit ở trên nhánh gốc. Thêm vào đó, ở trên `git log` chúng ta sẽ thấy một đường thẳng.  Việc sử dụng `fast forward` cực kì có ích khi ở trên **branch bị merge,** không có tồn tại thêm các commit mới, lúc này áp dụng `fast forward`  dòng `git log` là một đường thẳng.
**Nhược Điểm:**
Khi áp dụng cách này, khi muốn biết là cái commit được tạo ra trên branch nào, khi này sẽ gặp khó khăn khi nhìn trên `git log`. Đây là hình ảnh lấy ra từ `git log` `--``graph` khi áp dụng `git merge --fast-forward`

{% include image.html url="/image/posts/2019-11-23-Tong-hop-cac-loai-merge.md/6.png" description="[6] git merge fast forward" %}

## b. No Fast Forward

**Ưu Điểm:**
Cũng giống như là `fast forward`, người xem sẽ thấy toàn bộ commit của branch nhánh khi học xem `git log`. Thêm vào đó, người dùng còn biết được chính xác là commit được phát triển trên nhánh nào. Ưu điểm cuối cùng là khi nhìn `git log` `--``graph`  đẹp. Đây là hình ảnh ví dụ khi áp dụng `git merge` `--``no-ff`.

{% include image.html url="/image/posts/2019-11-23-Tong-hop-cac-loai-merge.md/7.png" description="[7] git merge no fast forward" %}


**Nhược Điểm:**
Giả sử với một người phát triển phần mềm và commit liên tục, một chuỗi các commit nhỏ nhỏ xuất hiện trên `git log` kết quả là nhìn rất rất là không đẹp, những commit nhỏ nhỏ đó nên được nhóm lại thành một commit.

## c. Squash

**Ưu Điểm:**
Khi nhìn vào `git log`, sẽ thấy git log cực kì sạch sẽ. Khi phát triển phần mềm, luôn luôn tồn tại những commit có message ít ý nghĩa, khi nhìn vào `git log` và đọc `git message`, thấy rất có vấn đề. Đặc biệt là những lập trình viên code và commit liên tục.

**Nhược điểm:**
Cực kì sạch sẽ quá cũng là vấn đề. Giả sử đó là một chuỗi commit, khi tìm cách debug theo brach ví dụ sử dụng `git bisect` , nhìn một cái commit đơn độc cũng khá là mệt.
