---
layout: post
title: Mã hóa và giải mã file trên linux sử dụng GPG
date: 2020-05-09 19:10:40 +0700
categories: Linux
tag: Linux
comments: true
---

Bài viết này đưa ra cách nhanh nhất để mã hóa cũng như giải mã file trên linux. Việc mã hóa và giải mã sẽ sử dụng mật mã **(symmetric-key - key đổi xứng)**

# I. Mã hóa file
{% highlight text %}
gpg --symmetric tesla.org
{% endhighlight %}


Lệnh này sẽ mã hỏi bạn mật mã, hay ghi nhớ **mật mã** này. Sau khi quá trình mã hóa kết thúc, một file có tên là `tesla.org.gpg` sẽ xuất hiện. Đây chính là file đã được mã hóa.

# II. Giải mã file
{% highlight text %}
gpg tesla.org.gpg
{% endhighlight %}

Phần mềm sẽ yêu cầu **mật mã.** Sau khi quá trình giải mã kết thúc, một file có tên là `tesla.org` sẽ xuất hiện.


# III. Lưu ý.
Nếu mà bạn mã hóa, rồi giải mã ngay lập tức. Khả năng rất cao là khi giải mã phần mềm sẽ không yêu cầu nhập mã.
