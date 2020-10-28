---
layout: post
title: "Quản lý version của ngôn ngữ theo dự án với ASDF"
date: 2020-10-28 17:55:24
tags: Linux, language, version-manager
categories: Linux
---

Trong quá trình phát triển phần mềm, khả năng rất cao là mỗi dự án chúng ta sẽ cần đến một ngôn ngữ lập trình khác nhau, thêm vào mặc dù là chung ngôn ngữ nhưng phiên bản của ngôn ngữ lập trình thay đổi theo dự án. Việc quản trị ngôn ngữ lập trình và phiên bản của nó là cực kì quan trọng.

Phần mềm mà tôi thích sử dụng đó là asdf [https://asdf-vm.com/](https://asdf-vm.com/) . Cách cài đặt thì có thể tìm thấy trực tiếp trên trang chủ của asdf. Bài viết này sẽ nói về những tính năng hay ho mà asdf tôi sử dụng hàng ngày.

Cơ chế hoạt động của asdf là tạo ra một lớp bọc phía bên ngoài cho các `executable file` , ứng với mỗi phiên bản, asdf sẽ chọn lựa và chạy file tương ứng. Việc quản lý version được làm tự động, lập trình viên chỉ việc config.


## 1. Cài đặt ngôn ngữ lập trình

ASDF cài đặt nhiều ngôn ngữ lập trình cũng như phiên bản của ngôn ngữ đó giúp bạn, cú pháp đơn giản, không cần config nhiều. Cần lưu ý là bạn phải cài plugin trước, Danh sách plugin có thể tìm ở đây [https://asdf-vm.com/#/plugins-all](https://asdf-vm.com/#/plugins-all).

Ví dụ như muốn cài `elixir`, thì bạn sẽ cần `elixir-plugin`.


- Để cài đặt plugin, bạn sử dụng lệnh sau, trong đó elixir là tên plugin.
{% highlight sh %}
asdf plugin-add elixir
{% endhighlight %}

- Để cài đặt ngôn ngữ, chạy lệnh sau, trong đó 1.9.1 là version.
{% highlight sh %}
asdf install elixir 1.9.1
{% endhighlight %}

{% include image.html url="/image/posts/2020-10-28-Quan-ly-version-cua-ngon-ngu-theo-du-an/1.png" description="[1] elixir 1.9.1" %}


## 2. Sử dụng bộ ngôn ngữ lập trình

Một dự án sẽ sử dụng rất nhiều ngôn ngữ lập trình, ví dụ như `elixir` cho backend, `nodejs` cho frontend, thêm vào đó trong trường hợp tôi dùng `elixir` tôi cần quan tâm đến cả `erlang` nữa.
asdf sẽ giúp lập trình viên nhanh chóng chuyển phiên bản của ngôn ngữ lập trình theo dự án.

Ví dụ dưới đây là `project_1` và `project_2`, hai dự án này nằm ở hai thư mục khác nhau. cả hai có điểm chung là đều sử dụng `elixir` tuy nhiên nhu cầu về phiên bản lại khác nhau, một cái là `1.9.1` , cái còn lại là `1.9.2`

{% include image.html url="/image/posts/2020-10-28-Quan-ly-version-cua-ngon-ngu-theo-du-an/2.png" description="[2] project_1, elixir 1.9.1" %}

{% include image.html url="/image/posts/2020-10-28-Quan-ly-version-cua-ngon-ngu-theo-du-an/3.png" description="[3] project_2, elixir 1.9.2" %}

Tính năng này được để cập rất chi tiết tại đây [https://asdf-vm.com/#/core-configuration](https://asdf-vm.com/#/core-configuration).

Để làm được điều này, nói ngắn gọn bạn sẽ cần tạo file `.tool-versions` ở mỗi project. Trong file này sẽ liệt kê chi tiết version của language. Như trên hình, khi kiểm tra phiên bản của elixir, phiên bản đã hiển thị khác nhau.

File: `project_1/.tool_versions`
{% highlight text %}
elixir 1.9.1
erlang 22.1
nodejs 10.16.3
{% endhighlight %}


File: `project_2/.tool_versions`
{% highlight text %}
nodejs 13.0.1
erlang 22.1
elixir 1.9.2
{% endhighlight %}
