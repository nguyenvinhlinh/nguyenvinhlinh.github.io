---
layout: post
title: "Bootstrap fonts working with rails 4, asset pipeline"
date: 2015-04-09 00:00:00 +0700
categories:
- Ruby on Rails 4
tags: rails4, asset pipeline, fonts, bootstrap
---
**Problems**: Cannot load the fonts of bootstrap
**Reason**: In Rails, all assets are loaded from `host:port/assets` not
`host:port/fonts`
**Solution**: Replace the source url in `@font-face`, from `../fonts/` to
  `/assets`

Original version:
{% highlight css %}
@font-face {
  font-family: 'Glyphicons Halflings';
  src: url('../fonts/glyphicons-halflings-regular.eot');
  src: url('../fonts/glyphicons-halflings-regular.eot?#iefix') format('embedded-opentype'), url('../fonts/glyphicons-halflings-regular.woff') format('woff'), url('../fonts/glyphicons-halflings-regular.ttf') format('truetype'), url('../fonts/glyphicons-halflings-regular.svg#glyphicons_halflingsregular') format('svg');
}
{% endhighlight %}

Edited version:
{% highlight css %}
@font-face {
  font-family: 'Glyphicons Halflings';
  src: url('/assets/glyphicons-halflings-regular.eot');
  src: url('/assets/glyphicons-halflings-regular.eot?#iefix') format('embedded-opentype'), url('/assets/glyphicons-halflings-regular.woff') format('woff'), url('/assets/glyphicons-halflings-regular.ttf') format('truetype'), url('/assets/glyphicons-halflings-regular.svg#glyphicons_halflingsregular') format('svg');
}
{% endhighlight %}
