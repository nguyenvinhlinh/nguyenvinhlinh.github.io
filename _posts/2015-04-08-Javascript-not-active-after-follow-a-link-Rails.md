---
layout: post
title: "Ruby On Rails: Javascript did not active after follow a link"
date: 2014-03-02 21:55:37 +0700
categories:
- Ruby on Rails 4
tag: Turbolink, Rails4, Javascript, Jquery
---
Description: After writing javascript code, There is an error, when users click
on the hyperlink, javascript does not run. However, if users refresh the
web page, javascript run automatically.My project using Jquery.

Instead of writing code like:

{% highlight javascript%}
$(document).ready ->
  alert("page is load")
{% endhighlight %}

You should write:
{% highlight javascript%}
$(document).on "page:change", ->
  alert "page has loaded!"

{% endhighlight %}
