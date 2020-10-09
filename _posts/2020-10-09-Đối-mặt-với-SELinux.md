---
layout: post
title: "Đối mặt với SELinux"
date: 2020-10-09 18:44:23
tags: Linux, SeLinux
categories: Linux
---

SELinux một thứ rất đang để học hỏi, nhưng lại khó để thực hành. Đặc biệt là các vấn đề liên quan đến SELinux lại là thứ không phải là thứ xảy ra hàng ngày, hàng giờ.
Chỉ là thi thoảng, khi triển khai máy chủ mới gặp vấn đề, lúc gặp tôi thường là có hai phương án tùy vào tình huống mà:
- Tắt luôn SELinux
- Đọc, hiểu lý do, viết policy và cài đặt policy cho SELinux.

Cứ mỗi lần triển khải server mới, dính vào nginx, reverse proxy là tôi lại phải nhờ anh google. Lần này tôi quyết định viết lại blog, cũng như là một cách để nhắc nhở mình
cần phải làm gì khi gặp chuyện với SELinux.

## I. Xác định xem có phải vấn đề thuộc về SELinux hay không
Cách dễ nhất để biết được nguyên nhân gặp phải thuộc về SELinux đó là chuyển chế độ của SELinux từ `Enforce` thành `Permission`. Đây là các lệnh liên quan
- `getenforce`: xem trạng thái của SELinux. `Enforce` có nghĩa là chặn sạch, block sạch nếu ứng dụng không thỏa mãn luật lệ. `Permissive` có nghĩa là thông qua, tuy nhiên vẫn sẽ bị log ghi lại.
- `setenforce`: cài đặt trạng thái của SELiux. `setenforce 1`, chuyển sang chế độ `Enforce`. `setenforce 0` là chuyển sang chế độ `Permissive`.


Nếu mà chuyển sang chế độ `Permissive` mà phần mêm chạy ổn áp đúng như mong muốn thì biết lý do là SELinux rồi đấy. Bên cạnh đó, hay chú ý đến cả file log của phần mềm, cuộc đời biết đâu bất ngờ.
## II. Xem và hiểu file audit.log
File `/var/log/audit/audit.log` này cực kì quan trọng chứa thông tin liên quan đến lý do tại sao SELinux lại ngăn chặn phần mềm làm điều này, điều kia. Tuy nhiên khi đọc bằng mắt thường sẽ rất khó hiểu.
Để đọc và hiểu lý do dễ dàng, nên sử dụng lệnh `audit2why`.

Ví dụ như sau, tôi `cat` file log, tôi `grep` các dòng có từ khóa "denied", tôi tiếp tục sử dụng `audit2why` để đọc dễ hiểu hơn.
{% highlight sh %}
cat  /var/log/audit/audit.log | grep denied | audit2why
{% endhighlight %}
Chắc chắn là khi chạy xong, thông tin sẽ tường mình hơn rất nhiều.

## III. Tạo và cài đặt luật lệ để SELinux thông qua
SELinux rất hay ở chỗ nó block phần mêm những nó cũng chỉ rõ ra rằng chúng ta phải làm gì để khắc phục. Đây là một cái rất rất thú vị. Sau
khi đã đọc và hiểu tại sao SELinux block, giờ là lúc bổ sung luật lệ cho SELinux. `audit2allow` là câu lệnh chúng ta cần.

{% highlight sh %}
cat  /var/log/audit/audit.log | grep denied | audit2allow -a -M my_module
{% endhighlight %}

Câu lệnh trên sẽ tạo ra file `my_module.pp`. Sử dụng lệnh sau để cài đặt module này và SELinux.
{% highlight sh %}
semodule -i my_module.pp
{% endhighlight %}

Happy!