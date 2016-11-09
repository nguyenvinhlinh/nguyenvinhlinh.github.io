---
layout: post
title: "Disable active record (nodatabase uses) in Rails 4"
date: 2015-01-27 12:24:00
categories:
- Ruby on Rails 4
tags: ruby, rails4, active-record
--- 
This article shows a quick tweak to unuse database gem, disable active record in Ruby on Rails 4.x

## 1. For new projects, run the following command to generate new project

{% highlight bash %}
rails new YourProject --skip-active-record
{% endhighlight %}

## 2. For existing projects
- Edit file `config/application.rb`, remove `require 'rails/all'` and add:
{% highlight ruby %}
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"
{% endhighlight %}
- Edit file `/config/environment/development.rb`, remove the following line:
{% highlight ruby %}
config.active_record.migration_error = :page_load
{% endhighlight%}
- Remove gem named `sqlite3` in `Gemfile`
- Delete or Comment (recommend) `database.yml`, `db/schema.rb`
- Delete configuration in files in `config/environments` directory
