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


## 004. Khi viết controller test, tôi hay thấy test không được viết trực tiếp mà được gói lại trong `describe`, lợi thế của nó là gì?
Lợi thế của nó là khi nhóm test này cùng cần cách `setup` giống nhau. Ví dụ rõ nhất là khi `test update entity` nào đó. Từ `entity` này tôi lấy từ `Java Spring`.

Dịch qua tiếng việt là thực thể, nhưng bạn cứ hiểu là record trong database. Khi ta muốn làm test liên quan đến update record trong database, chúng ta cần có record đó
được tạo từ trước.

Lúc này có 2 test chúng ta quan tâm:

- test update với các tham số hợp lệ
- test update với tham số không hợp lệ

Cả 2 test này sẽ cùng cần được tạo trước record `CpuGpuMinerLog`. Dưới dây là ví dụ test cho `Controller` của `CpuGpuLog`

{% highlight elixir linenos %}
defmodule MiningRigMonitorWeb.CpuGpuMinerLogControllerTest do
  use MiningRigMonitorWeb.ConnCase
  import MiningRigMonitor.CpuGpuMinerLogsFixtures
  alias MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog

  @update_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "update cpu_gpu_miner_log" do
    setup [:create_cpu_gpu_miner_log]

    test "renders cpu_gpu_miner_log when data is valid", %{conn: conn, cpu_gpu_miner_log: %CpuGpuMinerLog{id: id} = cpu_gpu_miner_log} do
      conn = put(conn, ~p"/api/cpu_gpu_miner_logs/#{cpu_gpu_miner_log}", cpu_gpu_miner_log: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/cpu_gpu_miner_logs/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, cpu_gpu_miner_log: cpu_gpu_miner_log} do
      conn = put(conn, ~p"/api/cpu_gpu_miner_logs/#{cpu_gpu_miner_log}", cpu_gpu_miner_log: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_cpu_gpu_miner_log(_) do
    cpu_gpu_miner_log = cpu_gpu_miner_log_fixture()
    %{cpu_gpu_miner_log: cpu_gpu_miner_log}
  end
end
{% endhighlight %}

Sau khi `create_cpu_gpu_miner_log/1` được kích hoạt, nó trả 1 lại cái map `%{}`. Cái map này sẽ được nhồi tiếp vào `test "xxx", %{map} do end`.
Hãy chú ý dòng số `14`, `16` và `27`.

## 005. Ở trong form, tôi hay thấy `:let={f}`, cái này là gì thế, kỹ thuật alias từ `@form` thành `f` với `let` là như thế nào?
## 006. Luồng chạy khi tạo ``form` với `core_component.ex` generate mặc định là như thế nào?
## 007. `@from[field]` hoạt động như thế nào?
## 008. `phx-update="ignore"` dùng để làm gì, thấy nó sử dụng ở login form.
## 009. Khi chạy function trong `html.heex` thì cần dấu `.` trước tên funciton, tuy nhiên tại sao điều này lại không cần khi chạy function với module.
Cụ thể ở đây là `Layout.app/1`
{% highlight elixir linenos %}
<Layouts.app flash={@flash}>
  <div class="grid grid-cols-1 px-4 pt-6 xl:grid-cols-2 xl:gap-4 dark:bg-gray-900">
    <div class="mb-4 col-span-full xl:mb-2">
      <._breadcrumb />
    </div>
    <!-- Right Content -->
    <div class="col-span-1">
      <._email_information email_form={ @email_form } email_form_current_password={@email_form_current_password} />
    </div>

    <div class="col-span-1">
      <._password_information password_form={ @password_form} trigger_submit={ @trigger_submit }
        current_email={@current_email} current_password={@current_password}/>
    </div>
  </div>
</Layouts.app>

{% endhighlight %}

## 010. Tại sao `UserLoginLive.mount/3` (mix phx.gen.auth) , function này return {} tuple 3 phần tử. Có cả `temporary_assigns`.
{% highlight elixir  %}
defmodule MiningRigMonitorWeb.UserLoginLive do
  use MiningRigMonitorWeb, :live_view

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
{% endhighlight %}


## 011. Để tiện trong việc migrate lên version Phoenix mới, tôi không muốn dụng vào `core_component.ex`, tôi tạo ra file mới `nexus_component.ex`. Trong `_web.ex`, sẽ xuất hiện tình trạng `import` 2 module , và cả 2 module đó có function tên giống nhau. Bên cạnh việc tôi có thể đổi tên function, ngoài ra, tôi có thể gài quyền ưu tiên như thế nào.

chú ý dòng `6` và `7`.
{% highlight elixir linenos %}
  defp html_helpers do
    quote do
      # HTML escaping functionality
      import Phoenix.HTML
      # Core UI components and translation
      import MiningRigMonitorWeb.CoreComponents
      import MiningRigMonitorWeb.NexusComponents
      import MiningRigMonitorWeb.Gettext

      # Shortcut for generating JS commands
      alias Phoenix.LiveView.JS
      alias MiningRigMonitorWeb.Layouts

      # Routes generation with the ~p sigil
      unquote(verified_routes())
    end
  end
{% endhighlight %}

## 012. Nguyên lý thay đổi theme light/dark là gì
## 013. Tôi không hiểu cơ cấu làm việc của `JS.navigate/3`, `JS.patch/3`
- [JS.navigate/3](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.JS.html#navigate/3)
- [JS.patch/3](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.JS.html#patch/3)
