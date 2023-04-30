---
layout: post
title: "How to copy files from docker image to host machine?"
date: 2023-04-30 16:23:53
update:
location: Saigon
tags:
- Linux
- Docker
categories:
- Linux
seo_description: How to copy files from docker image to host machine?
seo_image:
comments: true
---
## Step 1: Prepare dockerfile
In this post, I would like to take an example building html file for jekyll blog.
{% highlight dockerfile %}
from ruby:3.2.0 as build

WORKDIR /opt/nguyenvinhlinh.github.io
COPY . /opt/nguyenvinhlinh.github.io

RUN bundle config set --local deployment true
RUN bundle install
RUN bundle exec jekyll build --destination=/opt/nguyenvinhlinh.github.io/dist

FROM scratch as release
COPY --from=build  /opt/nguyenvinhlinh.github.io/dist /
{% endhighlight %}

The build step will make statis file in `/opt/nguyenvinhlinh.github.io/dist`, then at `release` stage, it copies all files from that `dist` directory to `/`
## Step 2: Execute `docker build` command
{% highlight shell%}
$ mkdir -p /var/tmp/nguyenvinhlinh.github.io-dist
$ docker build -f Dockerfile  --target=release --output type=local,dest=/var/tmp/nguyenvinhlinh.github.io-dist .
{% endhighlight %}
In this step, the key point here is about to copy all files from stage named `release` to host directory at `/var/tmp/nguyenvinhlinh.github.io-dist`.

Good luck, have fun!
