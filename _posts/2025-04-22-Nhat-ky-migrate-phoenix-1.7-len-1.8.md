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

Bài viết này liệt kê lại quá trình cũng như dòng suy nghĩ của tôi khi migrate phoenix `1.7` lên `1.8`.

Thay đổi `mix.exs` phần dependencíe `deps/0`:

- `{:phoenix, "~> 1.7.14"}` -> `{:phoenix, "1.8.0-rc.1", override: true}`
- `{:phoenix_live_view, "~> 1.0.0", override: true}` -> `{:phoenix_live_view, "~> 1.0.9"}`

Thay đổi `mining_rig_monitor_web.ex` , phần `live_view/0`:

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

Ví dụ file `mining_rig_monitor/lib/mining_rig_monitor_web/live/asic_miner_live/index.html.heex`

{% highlight html %}
<Layouts.app flash={@flash} >
  <._index_top />

  <._index_overall_figures aggregated_coin_hashrate_map={@aggregated_coin_hashrate_map}
    aggregated_total_power={@aggregated_total_power}
    aggregated_total_power_uom={@aggregated_total_power_uom}
    aggregated_asic_miner_alive={@aggregated_asic_miner_alive} />

  <._index_activated_asic_miner_table streams={@streams} />

  <._index_not_activated_asic_miner_table streams={@streams} />

</Layouts.app>
{% endhighlight %}

---

Tiếp theo là về cái vụ [Scope](https://hexdocs.pm/phoenix/1.8.0-rc.0/scopes.html). Tôi tính toán là sẽ `mix phx.gen.auth` ở một dự án test khác, sau đó sẽ copy quá.
Tuy nhiên, bị vướng `field :authenticated_at, :utc_datetime` trong `Accounts.UserToken`, ở phiên bản `1.7`,  không có field `authenticated_at`.

Tôi có xem kỹ hơn cái field này, có vẻ là nó liên quan đến **sudo mode**. Thế tính năng **sudo mode** là gì?

Tính năng cực kỳ thích hợp cho những tác vụ nhạy cảm. Nó sẽ yêu cầu người dùng phải đăng nhập lại trước khi đưa ra hành động nào đó.

Tôi không có nhu cầu dùng `sudo mode`. Cụ thể là trong dự án [Mining Rig Monitor](https://github.com/nguyenvinhlinh/Mining-Rig-Monitor).
Thực tế, app này chỉ có 1 user role là `admin`. Chả có nhu cầu đụng đến **Scope** luôn, thôi dẹp cho khỏe.

Hahaha
