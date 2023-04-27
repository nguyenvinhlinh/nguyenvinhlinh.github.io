---
layout: post
title: "Support dropdown with multiple value in Redash, plus ALL value"
date: 2021-09-09 10:49:56
tags: Redash
categories: Redash
---

In Redash, there is a big demand for dropdown with `ALL` value. However, it's tricky to write `where` statement for `ALL` value. This post is all about work-around this issue.
Thank for my colleague - Trieu. All Credit to him.

{% include image.html url="/image/posts/2021-09-09-Support-dropdown-with-multiple-value-in-Redash,-plus-ALL-value/1.png" description="[1] Dropdown Field" %}

The dropdown configuration is in the following image.

{% include image.html url="/image/posts/2021-09-09-Support-dropdown-with-multiple-value-in-Redash,-plus-ALL-value/2.png" description="[2] Dropdown Configuration" %}

In the `where` section, condition statement should look like this one

{% highlight sql %}
(column_name in (SELECT unnest(CONCAT('{', '{{ _redash_var_name_ }}', '}')::varchar[])) OR '{{ _redash_var_name_ }}' LIKE '%ALL%')
{% endhighlight %}

In the script above, it cast to `varchar[]`, if column typed `uuid`, change the casted type to `::uuid[]`

And It's all done, you are ready to go!
