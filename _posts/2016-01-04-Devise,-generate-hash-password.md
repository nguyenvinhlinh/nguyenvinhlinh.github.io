---
layout: post
title: Devise, generate hash password
date: 2016-01-04 13:00:31
categories:
- Ruby on Rails 4
tag: rails
--- 

The question is that you are using devise and you want to get hash password from
raw password. Here is your solution:

{% highlight ruby %}
password = 'the secret password'
new_hashed_password = User.new(:password => password).encrypted_password
{% endhighlight %}
