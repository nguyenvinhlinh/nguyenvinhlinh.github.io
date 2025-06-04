---
layout: post
title: "How to install phx_new manually from source code?"
date: 2025-06-04 19:39:13
update:
location: Saigon
tags:
- Elixir
- Phoenix
categories: Elixir
seo_description: Building phx_new package yourself is simple!
seo_image: /image/posts/2025-06-04-How-to-install-phx-new-manually-from-source-code/seo.jpg
comments: true
---

Before going further, you must prepare your dev environment. I choose [asdf - version manager](https://asdf-vm.com/). This is my `.tool-versions`
``` sh
erlang 28.0
elixir 1.18.4
```
## 1. Clone the source code
In this post, I choose the latest version `v1.8.0-rc.3`
``` sh
$ git clone --depth 1 --branch v1.8.0-rc.3 git@github.com:phoenixframework/phoenix.git
```
## 2. Go to directory `phoenix/installer` and build
```sh
$ cd phoenix/installer;
$ MIX_ENV=prod mix archive.build;
# Output
Compiling 11 files (.ex)
Generated phx_new app
Generated archive "phx_new-1.8.0-rc.3.ez" with MIX_ENV=prod
```
## 3. Install archive
```sh
$ mix archive.install phx_new-1.8.0-rc.3.ez
# Output
Are you sure you want to install "phx_new-1.8.0-rc.3.ez"? [Yn] Y
* creating /home/nguyenvinhlinh/.asdf/installs/elixir/1.18.4/.mix/archives/phx_new-1.8.0-rc.3


$ mix phx.new --version
# Output
Phoenix installer v1.8.0-rc.3
```

## 4. How to remove `phx_new`
```
$ mix archive.uninstall phx_new
```
