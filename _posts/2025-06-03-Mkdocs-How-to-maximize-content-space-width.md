---
layout: post
title: "Mkdocs, How to maximize content space width?"
date: 2025-06-03 11:37:30
update:
location: Saigon
tags:
- mkdocs
categories: etc
seo_description: Maximize content space for Mkdocs.
seo_image: /image/posts/2025-06-03-Mkdocs-How-to-maximize-content-space-width/seo.jpg
comments: true
---

This post is all about maximize content space for Mkdocs sites. The main solution is to override css and set `max-width: 100%;`

## 1. Create `docs/style.css`
{% highlight css %}
.md-grid {
    margin-left: auto;
    margin-right: auto;
    max-width: 100%;
}
{% endhighlight %}

## 2. Modify `mkdocs.yml` to use `docs/style.css`


{% highlight yaml %}
extra_css:
  - style.css
{% endhighlight %}

{% include image.html url="/image/posts/2025-06-03-Mkdocs-How-to-maximize-content-space-width/1.jpg" description="[1] Before maximize content space/width" %}

{% include image.html url="/image/posts/2025-06-03-Mkdocs-How-to-maximize-content-space-width/2.jpg" description="[2] After maximize content space/width" %}
