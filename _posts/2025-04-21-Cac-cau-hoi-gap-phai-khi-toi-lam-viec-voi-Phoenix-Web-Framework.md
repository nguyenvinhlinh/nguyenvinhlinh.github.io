---
layout: post
title: "Các câu hỏi tôi gặp phải khi làm việc với Phoenix Web Framework"
date: 2025-04-21 22:44:10
update:
location: Saigon
tags:
categories: Elixir
seo_description:
seo_image:
comments: true
---

Bài post này tổng hợp các câu hỏi tôi gặp phải khi làm việc với Phoenix Web Framework,
có những câu hỏi tôi không có câu trả lời, nhưng tôi sẽ vẫn ghi lại, khi nào rảnh tôi
sẽ quay lại nghiên cứu.

Trên con đường tập trung vào tính năng thay vì sự hoàn hảo, luôn luôn có những lúc tôi
hoàn toàn bỏ qua vẫn đề kỹ thuật mà tập trung vào nghiệp vụ nhằm khai thác tối đa
feedback loop. Bài post này sẽ giúp tôi quay lại, xử lý những vấn đề ngu ngốc mà tôi
chủ động tạo ra trong quá trình phát triển phần mềm.

## 001. Tại sao ở phiên bản Phoenix Web Framework cũ, phần layout chỉ cần quan tâm đến `root.html.heex`, nhưng bây giờ nó lại có thêm cả `app.html.heex` Phiên bản 1.7. Tuy nhiên ở phiên bản 1.8, nó lại bỏ đi, nhồi vào file `layout.ex`.
Ở thời điểm hiện tại, 21/4/2025, tôi đang có nhu cầu migrate phoenix từ `1.7` sang `1.8` [Official changelog](https://www.phoenixframework.org/blog/phoenix-1-8-released). Rồi lại còn đổi từ dashboard template [Flowbite Dashboard](https://flowbite.com/) qua [Nexus Dashboard](https://nexus.daisyui.com/) của DaisyUI. Cái này mất não thật sự.
Vấn đề lớn nhất của FlowBite là giá tiền **299 USD**, tiếp theo là `class name`. Tôi không phải là fan của việc `nhìn 1 cái div có hơn 10 cái class`, tôi mua `Nexus Dashboard` với giá **69 USD** với hi vọng giải quyết vấn đề này.


- `root.html.heex`, cái này mục đích là để render những cái html tĩnh mà thôi.
- `app.html.heex`, cái này sử dụng kèm và đi xuyên suốt vòng đời của LiveView.

Đây là file `_web.ex` , phiên bản phoenix `1.7`, phần `live_view`.

{% highlight elixir %}
  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {MiningRigMonitorWeb.Layouts, :app}

      unquote(html_helpers())
    end
  end

{% endhighlight %}

Khi sử dụng `live_view` ở ver 1.7, layout `:app` đã được gài cứng, điều này gây khó khăn khi webapp có nhiều liveview layout. Ví dụ nhé:

- bạn dev phoenix web app, hoàn toàn chơi `live_view`, người dùng đã đăng nhập sẽ có liveview layout khác với người dùng chưa đăng nhập.
- sau khi đăng nhập, user `role-admin` sẽ có giao diện khác với `role-thường dân`.


Trong file `routes.ex`, nếu mà `login` thì tôi sẽ dùng là `root-no-nav.html.heex`, ngược lại, nếu đăng nhập thành công, tôi sẽ dùng `root.html.heex`.

Đừng ngủ nhé, đây là file `_web.ex`, phiên bản phoenix  `1.8`, phần `live_view`.

{% highlight elixir %}
  def live_view do
    quote do
      use Phoenix.LiveView

      unquote(html_helpers())
    end
  end
{% endhighlight %}

Bạn nhìn phần layout nhé, macro không hề chỉ định `:app` là layout mặc định của `live_view`. Điều này nghĩa là ở trong các `live_view`, cụ thể là `render`, phải tường
minh ghi rõ là `live_view` đang muốn dùng layout nào, ví dụ như:

- app_admin
- app_login

## 002. Khi làm việc với phoenix, tôi thấy có từ khóa `@inner_content` và `@inner_block`, chúng được sử dụng như thế nào.

- `@inner_content` tìm thấy trong `root.html.‌heex`
- `@inner_block` tìm thấy trong `layout.ex`, function `app/1`

... Vẫn còn tiếp

## 003. Khi khai thác `conn.assigns` hay `socket.assigns`, kỹ thuật nào có thể giúp sử dụng `@tên_var` thay cho `Map.get(@conn.assigns, :tên_var)`
Tôi chưa có câu trả lời cho câu hỏi này, tuy nhiên khi nào có thời gian tôi sẽ xem các bài sau:
- [Phoenix.Component.html](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html)
- [Assigns and HEEx templates](https://hexdocs.pm/phoenix_live_view/assigns-eex.html)
- [The assigns variable](https://hexdocs.pm/phoenix_live_view/assigns-eex.html#the-assigns-variable)
