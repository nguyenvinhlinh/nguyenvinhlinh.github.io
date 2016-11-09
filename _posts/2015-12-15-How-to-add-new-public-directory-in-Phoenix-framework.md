---
layout: post
title: How to add new public directory in Phoenix framework
date: 2015-12-15 22:39:59
categories: Phoenix
tag: etc
--- 

In Phoenix web framework, there is a share directory `/priv`. By default, it
will only public `css,js,images,fonts` directory. However, If you want to share
a new directory to save upload image for example, you have to end_point file at

/lib/app_name/end_point.ex . Look at `plug Plug.Static`, the `only:` macro
declares which directory, files could be public. Simply, you have to append your
directory name at `only:`line.

This is my configuration to add a directory named avatar public. This directory
is under `/priv/static`.
{% highlight elixir %}
plug Plug.Static,
    at: "/", from: :blog_phoenix, gzip: false,
    only: ~w(avatars css fonts images js favicon.ico robots.txt)
    ### Other no need configuration
end
{% endhighlight %}

Your tree should look like below
{% highlight text %}
priv
├── repo
│   ├── migrations
│   └── seeds.exs
└── static
    ├── avatars
    │   ├── abc.text
    │   ├── Screenshot\ from\ 2015-12-04\ 22-31-39.png
    │   ├── Screenshot\ from\ 2015-12-11\ 01-49-29.png
    │   └── Screenshot\ from\ 2015-12-14\ 22-21-56.png
    ├── css
    │   ├── app.css
    │   └── app.css.map
    ├── favicon.ico
    ├── images
    │   └── phoenix.png
    ├── js
    │   ├── app.js
    │   └── app.js.map
    └── robots.txt
{% endhighlight %}

