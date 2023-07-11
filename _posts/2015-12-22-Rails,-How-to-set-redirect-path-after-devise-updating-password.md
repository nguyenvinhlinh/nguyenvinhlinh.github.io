---
layout: post
title: Rails, How to set redirect path after devise updating password
date: 2015-12-22 18:06:38 +0700
categories: Rails
tag: etc
---

This post is all about how to change redirect url after devise update password
(or any?). By default, devise after change password successfully, it will
redirect to the root url. There are step you have to do to change the redirect
path.

1. Make devise controllers Or generate using command `rails g
devise:controllers user`

2. After generating, because I want to change the redirect url after changing
password. The only file I concern is `passwords_controller.rb`, the method you
have to override is `after_resetting_password_path_for`, within this method, you
have to declare your favorite redirect url.

for example:

{% highlight ruby %}
class User::PasswordsController < Devise::PasswordsController
  protected
  def after_resetting_password_path_for(resource)
    change_password_success_path
    #OR "http://google.com"
  end
end
{% endhighlight %}
