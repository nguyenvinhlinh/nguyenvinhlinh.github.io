---
layout: post
title: Add new methods to exist resource routes as collection in Rails
date: 2015-09-10 23:05:32 +0700
categories:
- Ruby on Rails 4
tag: ruby, rails
---

Rails does support built-in CRUD with RESTful. It provides default url for
developers. However, there could be a time that developer want to add more
method/action to work with exist routes. Hence, this is solution.

This is a default setting for resources of `pictures`
{% highlight ruby %}
resources :pictures
{% endhighlight %}

This is modification with new upload method which use **GET** protocol.
{% highlight ruby %}
resources :pictures do
  collection do
    get 'upload', to: 'pictures#upload'
  end
end
{% endhighlight %}
