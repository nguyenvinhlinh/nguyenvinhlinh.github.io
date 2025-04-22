---
layout: post
title: "Nhật ký migrate Phoenix Web Framework 1.7.14 lên 1.8"
date: 2025-04-22 10:24:24
update:
location:
tags:
- elixir
- phoenix
categories:
- Elixir
seo_description:
seo_image:
comments: true
---

Bài viết này liệt kê lại quá trình tôi migrate phoenix 1.7 lên 1.8.

## [22/4/2025]

Thay đổi `mix.exs` phần dependencíe `deps/0`
- `{:phoenix, "~> 1.7.14"}` -> `{:phoenix, "1.8.0-rc.1", override: true}`
- `{:phoenix_live_view, "~> 1.0.0", override: true}` -> `{:phoenix_live_view, "~> 1.0.9"}`

Thay đổi `mining_rig_monitor_web.ex` , phần `live_view/0`
- `use Phoenix.LiveView, layout: {MiningRigMonitorWeb.Layouts, :app}` -> `use Phoenix.LiveView`
Sau cùng, nó sẽ trông như thế này.

{% highlight elixir %}
  # Phiên bản cũ
  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {MiningRigMonitorWeb.Layouts, :app}

      unquote(html_helpers())
    end
  end
  # Phiên bản mới
  def live_view do
    quote do
      use Phoenix.LiveView

      unquote(html_helpers())
    end
  end
{% endhighlight %}

Tôi đã nghĩ rằng sẽ phải có lỗi xảy ra ở lần chạy `iex -S mix phx.server` đầu tiên, tôi sẽ cần phải thay đổi các `live_view` liên quan, nhưng mà không, khả năng tương thích ngược là khá tốt.

---

Tôi trích dẫn một cái quan trọng liên quan đến `root.html.heex` và `app.html.heex` (version 1.7) , `app/1` (version 1.8).

{% highlight elixir %}
defmodule DevAppWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is rendered as component
  in regular views and live views.
  """
end
{% endhighlight %}


cái `app/1` này phải được gọi thì nó mới render, không có chuyện chạy mặc định. Có thể ở 1.7 có file `app.html.heex`, tuy nhiên, nó ko liên quan đến func `app/1`

Tôi cần kiểm tra chéo 1 chút, thực sự là `app.html.heex` có được chạy mặc định hay không, sau khi tôi đã bỏ option `layout: {MiningRigMonitorWeb.Layouts, :app}`

Để test, tôi đã thêm 1 cái tag `<h1>` cho file `app.html.heex` để đánh dấu.

{% highlight html %}
 <!-- app.html.heex -->
<main class="bg-gray-50 dark:bg-gray-900">
  <.flash_group flash={@flash} />
  <%= @inner_content %>
  <h1> APP.HTML.HEEX</h1>
</main>
{% endhighlight %}

Đệt, nó ko chạy qua `app.html.heex` sau khi bỏ option `layout: {MiningRigMonitorWeb.Layouts, :app}` trong `_web.ex`, `live_view/0` nhé.

Điều này nghĩa là tôi sẽ phải:

- Kéo nội dung của `app.html.heex` vào module `Layouts`, function `app`
- Thêm `alias MiningRigMonitorWeb.Layouts` trong `mining_rig_monitor_web.ex`, function `html_heler/0`
- Các liveview module, ví dụ module `MiningRigMonitorWeb.AsicMinerLive.Index`, sau khi tôi tách function `render/1` thành file `index.html.heex`. nếu tôi mà muốn sử dụng liveview layout có tên là `app`,
tôi sẽ cần phải bọc nó lại với tag `<Layout.app> <‌/Layout.app>`



<.flash_group flash={@flash} />
