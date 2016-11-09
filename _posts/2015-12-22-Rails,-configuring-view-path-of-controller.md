---
layout: post
title: Rails, configuring view path of controller
date: 2015-12-22 18:00:14
categories: Rails
tag: etc
--- 

This is a solution to configure the view path of any controller in Rails web
framework. The only method you have to concern is `self.controller_path`  

{% highlight ruby %}
class User::HomeController < ApplicationController
  def self.controller_path
    "users/home"
  end
end
{% endhighlight %}

With this configuration, all view of `User::HomeController` will be located in `app/users/home/`
