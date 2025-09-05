---
layout: post
title: "Elixir expert (LSP), tản mạn xung quanh cách build"
date: 2025-09-05 12:33:18
update:
location: Saigon
tags:
- elixir
- expert
- lsp
categories: Elixir
seo_description: Bằng cách tự build expert (LSP), tôi khám phá ra kha khá thứ mới, thú vị hơn.
seo_image: /image/posts/2025-09-05-Elixir-expert-tan-man-xung-quanh/seo.png
comments: true
---

Hôm này ngày đẹp trời, tôi tò mò rất nhiều về [expert - language server](https://github.com/elixir-lang/expert) mới của
elixir. Xem một hồi về cách build, tôi học thêm được nhiều cái mới.

- Just [link](https://github.com/casey/just)
- Zig [link](https://ziglang.org/)
- Burrito [link](https://github.com/burrito-elixir/burrito)

## 1. Just
`Just` có mục đích tối thượng là giúp giảm thời gian dev gõ command. Để làm việc đó, nó sẽ cho phép bọc nhiều `shell command`
lại, và tạo command tương đương, là tôi thì tôi sẽ gọi là `alias command`. Trong repo, những thiết lập này nằm trong `justfile`.

Cùng xem thử [một đoạn](https://github.com/elixir-lang/expert/blob/main/justfile#L5C1-L10C17) nhé:

{% highlight justfile %}
[doc('Run mix deps.get for the given project')]
deps project:
    #!/usr/bin/env bash
    cd apps/{{ project }}
    mix deps.get
{% endhighlight %}

`just command` được tạo ra sẽ có tên là `deps`, nó bọc lại một danh sách các `shell command` sau:

- `cd apps/{{ project }}`
- `mix deps.get`

Điều này có nghĩa là nếu bạn siêng, bạn sẽ gõ 2 lệnh, còn nếu bạn dùng `just`, bạn sẽ chỉ cần chạy `just deps project`.

Cá nhân tôi, lần đầu biết đến `just`, `mix project` của tôi thường nằm ngay `repo root /` thành ra chưa có nhu cầu. Tuy nhiên,
đáng để ghi nhớ.

Trường hợp ở trên, `mix project` nằm ở trong `/apps‌/{{ project }}`, thành ra khá bất tiện.

## 2. Zig
`Zig` thì là một ngôn ngữ lập trình luôn! Tôi không hiểu tại sao cái repo 99% là viết bằng `elixir`, nhưng lại cần đến zig.
Đoạn này tôi mù mịt rồi rồi nên phải nhờ chatGPT.

- `Zig` chỉ đóng vai trò hỗ trợ khi đóng gói/bundling, cụ thể là với `burrito`(tôi sẽ nói ở ngay sau)
- Nếu mà chỉ cần tạo ra release với `mix release` đơn thuần (cái loại mà tạo ra nhiều thư mục, file, kèm theo runtime), `Zig`
là hoàn toàn không cần thiết.

## 3. Burrito
`Burrito` có mục đích lớn nhất là tạo ra **một file executable duy nhất** cho `mix project`. Bạn nhớ cái `mix release` truyền thống chứ,
nó bao gồm (erlang runtime, nhiều file, thư mục đi kèm), `Burrito` thì ngược lại, nó sẽ build ra chỉ **một file executable duy nhất**.

Bạn còn nhớ thằng `Zig` ở trên chứ, nó giúp Burrito tạo ra executable file phù hợp cho đa nền tảng (linux, mac, window). Zig nó kết nối(link),
đóng gói những `header .h` và file liên quan vào.

Kết quả là với cùng một source code [expert - language server](https://github.com/elixir-lang/expert), chúng ta có phiên bản cho

- `expert_windows_amd64.exe` (window)
- `expert_linux_arm64` (linux + chip kiến trúc arm64)
- `expert_linux_amd64` (linux + chip kiến trúc amd64)
- `expert_darwin_arm64` (macos + chip kiến trúc arm64)
- `expert_darwin_amd64` (macos + chip kiến trúc amd64)

Xem danh sách mới nhất ở đây: [Expert Releases](https://github.com/elixir-lang/expert/releases)
