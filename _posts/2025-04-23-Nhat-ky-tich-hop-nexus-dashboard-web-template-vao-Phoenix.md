---
layout: post
title: "Nhật ký tích hợp Nexus Dashboard (Web Template) vào Phoenix 1.8"
date: 2025-04-23 11:45:13
update:
location: Saigon
tags:
- daisyui
- nexus
- phoenix
categories:
- Elixir
seo_description: Nhật ký cá nhân của tôi ghi lại quá trình tích hợp Nexus Dashboard vào Phoenix Web Framework 1.8
seo_image:
comments: true
---

## 23/4/2025
Trước tiên, khi nhìn vào `mix.exs`, phần `alias/0`:
{% highlight elixir %}
defp aliases do
  [
    ...
    "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
    "assets.build": ["tailwind mining_rig_monitor", "esbuild mining_rig_monitor"],
    "assets.deploy": [
      "tailwind mining_rig_monitor --minify",
      "esbuild mining_rig_monitor --minify",
      "phx.digest"
    ]
  ]
end
{% endhighlight %}


Và `config.exs`:

{% highlight elixir %}
 # Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  mining_rig_monitor: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

 # Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  mining_rig_monitor: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]
{% endhighlight %}

Chúng ta có thể hiểu như sau:
- Những cái liên quan đến `css, app.css`, `tailwind` sẽ nhận trách nhiệm.
- Những cái liên quan đến `js, app.js`, `esbuild` sẽ nhận trách nhiệm.

Tiếp theo là về việc làm sao kéo css của **Nexus Dashboard** vào **Phoenix**. Có 2 cách:
- Cách dễ nhất: Lấy file `app.css` trong thư mục `html` của **Nexus Dashboard** và copy vào **Phoenix**
- Cách tốn công nhất: tái hiện lại build-step, tôn trọng tailwind, lợi thế là sẽ optimized dung lượng file bao gồm css, icon.

Tôi chọn cách đầu tiên để thử nghiệm. Page login đã hiện ra, khá đẹp.

{% include image.html url="/image/posts/2025-04-23-Nhat-ky-tich-hop-nexus-dashboard-web-template-vao-Phoenix/1.png" description="[1] static login page" %}

## 24/4/2025
Hôm qua, tôi đã làm xong cái static page login. Bây giờ, tôi cần nó chạy được:

- chuyển trang khi login thành công
- báo lỗi khi đăng nhập thất bại.

Để làm cái này, tôi quyết định không dùng `.form‌/1`, `.input/2` trong `core_component.ex`. Khi dùng những cái này, khả năng tùy biến rất khó.
Chơi thuần túy luôn, học cho được nhiều. [form(assigns)](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#form/1)

{% highlight html %}
<.form for={@form} action={~p"/users/log_in"} phx-update="ignore">
 <fieldset class="fieldset">
   <legend class="fieldset-legend">Email Address</legend>
   <label class="input w-full focus:outline-0">
     <span class="iconify lucide--mail text-base-content/80 size-5"></span>
     <input class="grow focus:outline-0" placeholder="Email Address" type="email" name={@form[:email].name}  id={@form[:email].id} value={@form[:email].value} />
   </label>
 </fieldset>

 <fieldset class="fieldset">
   <legend class="fieldset-legend">Password</legend>
   <label class="input w-full focus:outline-0">
     <span class="iconify lucide--key-round text-base-content/80 size-5"></span>
     <input class="grow focus:outline-0" placeholder="Password" type="password" name={@form[:password].name} id={@form[:password].id} />
     <label class="swap btn btn-xs btn-ghost btn-circle text-base-content/60">
       <input type="checkbox" aria-label="Show password" data-password="password" />
       <span class="iconify lucide--eye swap-off size-4"></span>
       <span class="iconify lucide--eye-off swap-on size-4"></span>
     </label>
   </label>
 </fieldset>

 <div class="mt-4 flex items-center gap-3 md:mt-6">
   <input class="checkbox checkbox-sm checkbox-primary" aria-label="Checkbox example" type="checkbox" name={@form[:remember_me].name} id={@form[:remember_me].id} />
     <label for="agreement" class="text-sm">
       Remember me
     </label>
   </div>

 <button type="submit" class="btn btn-primary btn-wide mt-4 max-w-full gap-3 md:mt-6">
   <span class="iconify lucide--log-in size-4"></span>
   Login
 </button>
</.form>
{% endhighlight %}

---

Tiếp theo, tôi cần báo lỗi khi đăng nhập thất bại.

Nếu mà lượng icon dùng y hệt **Nexus Dashboard** thì sẽ chả có gì để nói. Tuy nhiên, nếu mà dùng `icon, class css` mà trong `app.css` không có thì ngập hành. Đừng quên nhé, tôi copy nguyên cái `app.css` của **Nexus** vào **Phoenix**.

Cái thời mà tôi dùng fontawesome, sau đó cứ điềm nhiên gán font trong span đã hết rồi sao. Phiền quá trời.

Nhân tiện, **Nexus Dashboard** dùng icon chủ yếu là từ [https://lucide.dev/](https://lucide.dev/).

Để khắc phục, một giải pháp khác, đó là sử dụng thuần `<svg>` tag:

{% highlight html %}
<!-- https://lucide.dev/icons/a-arrow-down -->
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
     stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
     class="lucide lucide-aarrow-down-icon lucide-a-arrow-down">
    <path d="M3.5 13h6"/>
    <path d="m2 16 4.5-9 4.5 9"/>
    <path d="M18 7v9"/>
    <path d="m14 12 4 4 4-4"/>
</svg>
{% endhighlight %}

Còn không, cách bài bản hơn đó là:

- load javascript của lucide về
- tạo script nhận diện `class-name` , nếu `class-name` bắt đầu bằng lucide thì sẽ trả về `svg` tương ứng.
- thiết lập để script này tương thích với **tailwind**. Tailwind khi chạy, sẽ tạo ra các class tương ứng.

---

Tôi sẽ thử nghiệm với phương án copy trực tiếp `<svg>`.

Tôi sẽ so sánh css class mà lấy từ **Nexus dashboard** và svg lấy từ **Lucide**

**Nexus Dashboard**
``` html
<span class="iconify lucide--info size-5"></span>
```

```css
.lucide--info {
  --svg: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' width='24'
             height='24'%3E%3Cg fill='none' stroke='black' stroke-linecap='round' stroke-linejoin='round'
              stroke-width='2'%3E%3Ccircle cx='12' cy='12' r='10'/%3E%3Cpath d='M12 16v-4m0-4h.01'/%3E%3C/g%3E%3C/svg%3E");
}

.size-5 {
    width: calc(var(--spacing)* 5);
    height: calc(var(--spacing)* 5);
}

.iconify {
    width: 1em;
    height: 1em;
    -webkit-mask-image: var(--svg);
    mask-image: var(--svg);
    background-color: currentColor;
    display: inline-block;
    -webkit-mask-size: 100% 100%;
    mask-size: 100% 100%;
    -webkit-mask-repeat: no-repeat;
    mask-repeat: no-repeat;
}
```

**SVG thay thế**
Tôi dùng trực tiếp luôn, không cần bọc với `<span>`. Kết quả vẫn tốt.
```html
<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
     stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-info-icon lucide-info">
  <circle cx="12" cy="12" r="10"/>
  <path d="M12 16v-4"/>
  <path d="M12 8h.01"/>
</svg>
```

{% include image.html url="/image/posts/2025-04-23-Nhat-ky-tich-hop-nexus-dashboard-web-template-vao-Phoenix/2.png" description="[2] Lucide svg config." %}

## 25/4/2025
Tôi đi tập lái xe tải...
## 26/4/2025
- Giải quyết vấn đề footer bị sai vị trí khi div ở trên nó quá ngắn.
