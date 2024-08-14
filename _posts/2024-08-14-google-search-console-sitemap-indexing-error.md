---
layout: post
title: "Google Search Console - Sitemap Indexing Error"
date: 2024-08-14 22:35:19
update:
location: Saigon
tags: etc
categories: etc
seo_description: Google Sitemap Indexing engine failed to analyze sitemap.xml
seo_image: /image/posts/2024-08-14-google-search-console-sitemap-indexing-error/seo.png
comments: true
---

Today, I have seen a very weird error while using **Google Search Console** to index my sitemap. After I submit my sitemap [https://hexalink.xyz/sitemap.xml](https://hexalink.xyz/sitemap.xml).
it always shows error: `Couldn't fetch`. I think you can try it yourself with my **sitemap**.

This error is super tricky and it took me a whole night to debug. At first, let look at our usecase.

There are two identical file named: `sitemap.xml` and `sitemap1.xml`.

## Check 1: Sitemap file are all the same with extract contents.

{% include image.html url="/image/posts/2024-08-14-google-search-console-sitemap-indexing-error/1.png" description="[1][nginx directory]: file ownership & md5sum" %}

- Same ownership (`jenkins:jenkins`)
- Same content (md5sum: `859ffa73b9eaf8dcaef920ffafbc1a45`)

## Check 2: wget & md5sum
{% include image.html url="/image/posts/2024-08-14-google-search-console-sitemap-indexing-error/2.png" description="[2]wget & md5sum" %}
- Same content (md5sum: `859ffa73b9eaf8dcaef920ffafbc1a45`)


## Check 3: Testing with **Google Search Console** to read my sitemap
It's getting interesting here! <br>
When google try to fetch my `sitemap.xml` , it shows an error `Couldn't fetch`. However, it works for `sitemap1.xml`.<br>
I believe it's because of caching issue. Old data exists somewhere on the google data center. I would wait hours for this but to debug a sitemap generator, it's crazy. I better create a new file `sitemap-n.xml` to debug.


Right now, there is no solution for me but a work-around using `sitemap1.xml`, or any `sitemap-n.xml`.

{% include image.html url="/image/posts/2024-08-14-google-search-console-sitemap-indexing-error/3.png" description="[3]Google Search Console | Indexing Sitemap | 2024-08-14 22:26:39 GMT+7" %}

By the way, this is my jekyll `sitemap.xml`. You can found it [https://github.com/nguyenvinhlinh/nguyenvinhlinh.github.io/blob/master/sitemap.xml](https://github.com/nguyenvinhlinh/nguyenvinhlinh.github.io/blob/master/sitemap.xml).

{% highlight liquid %}
{% raw %}
---
layout: null
---
<?xml version="1.0" encoding="UTF-8"?>
<urlset
    xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
{% for post in site.posts %}
{%   if post.update == nil or post.update == ""  %}
{%     assign mod_date = post.date %}
{%   else %}
{%     assign mod_date = post.update %}
{%   endif %}
<url>
  <loc>{{ site.url }}{{ post.url }}</loc>
  <lastmod>{{ mod_date | date_to_xmlschema }}</lastmod>
</url>
{% endfor %}
</urlset>
{% endraw %}
{% endhighlight %}
