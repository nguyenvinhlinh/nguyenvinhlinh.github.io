---
layout: post
title: Generate entity relationship based on model, Ruby on rails
date: 2015-08-07 23:55:27
categories:
- Ruby on Rails 4
tag: rails
---

During this time, I am in an internship program. There is a big concern, I have
to work with a very big project, and there is no documentation. The number of
tables in project's database is more than 20, still no documentation.  

A big nightmare for an intern one. It's important to make an entity relationship
diagram, at least with a hope that I can get cope easily with the project.  

Game on!, There is a gem named `erd` - [url](https://github.com/voormedia/rails-erd)

# Setup and Installation
- Install graphviz (fedora)
{% highlight bash %}
sudo dnf install -y graphviz
{% endhighlight %}
- Add gem erd to gem file
{% highlight yaml %}
group :development do
  gem "rails-erd"
end
{% endhighlight %}
- Install bundle
{% highlight bash %}
bundle install
{% endhighlight %}

# Configuration
Configuration file will be loaded at `~/.erdconfig` or
`...project_rails/.erdconfig`, file config in the root of project will take
higher priority than in the home directory.

{% highlight yaml %}
attributes:
  - content
  - foreign_key
  - inheritance
disconnected: true
filename: erd
filetype: pdf
indirect: true
inheritance: false
markup: true
notation: simple
orientation: horizontal
polymorphism: false
sort: true
warn: true
title: sample title
exclude: null
prepend_primary: false
{% endhighlight %}

# Generating entity diagram file
Entity diagram will be generated in the root directory of project.
{% highlight bash %}
bundle exec erd
{% endhighlight %}
