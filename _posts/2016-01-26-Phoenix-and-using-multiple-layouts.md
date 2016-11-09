---
layout: post
title: Phoenix and using multiple layouts
date: 2016-01-26 15:30:00
categories: Phoenix
tag: tweak, layouts, phoenix
--- 

## 1. How to specify the layout when render() in controllers
There is an option in `render/3` method, [source](http://hexdocs.pm/phoenix/Phoenix.Controller.html#render/3)  
In the below example, I did specify the layout, the layout will be located at `@conn.assigns[:layout]`, so as `:id`
{% highlight elixir %}
defmodule ImageQuickShare.ImageController do
  use ImageQuickShare.Web, :controller
  def show(conn, %{"id" => id}) do
    render(conn, "show.html", id: id,
           layout: {ImageQuickShare.ImageView, "empty_layout.html"})
  end
end
{% endhighlight %}

The directory which locate layout look like:
{% highlight text %}
templates
├── image
│   ├── empty_layout.html.eex
│   └── show.html.eex
├── layout
│   └── app.html.eex
└── page
    └── index.html.eex
{% endhighlight %}

## 2. Setup a default layout for all method within a controller
We have to use `plug :put_layout`. 
{% highlight elixir %}
defmodule ImageQuickShare.ImageController do
  use ImageQuickShare.Web, :controller
  plug :put_layout, {ImageQuickShare.ImageView, "empty_layout.html"}  #<--- HERE
  
  def show(conn, %{"id" => id}) do
    render(conn, "show.html", id: id)
  end
end
{% endhighlight %}

## 3. Get advanced from PLUG.
Because of using plug, we can also specify the defaul layout in router. In `route.ex` we can define an extra pipeline.

{% highlight elixir %}
pipeline :empty_layout do
  plug :put_layout, {ImageQuickShare.ImageView, "empty_layout.html"}
end
{% endhighlight %}

And then, within scope, add the `pipeline` via `pipe_through`. Here is an example.
{% highlight elixir %}
scope "/", ImageQuickShare do
  pipe_through [:browser, :empty_layout] # Use the default browser stack
  get "/", PageController, :index
  get "/image", ImageController, :show
end
{% endhighlight %}

#### REFERENCE
- [How to set different layouts in Phoenix](http://www.cultivatehq.com/posts/how-to-set-different-layouts-in-phoenix/)


