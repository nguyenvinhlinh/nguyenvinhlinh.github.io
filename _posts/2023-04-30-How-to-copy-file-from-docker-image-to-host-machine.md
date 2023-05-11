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
{% highlight shell %}
$ mkdir -p /var/tmp/nguyenvinhlinh.github.io-dist
$ docker build -f Dockerfile  --target=release --output type=local,dest=/var/tmp/nguyenvinhlinh.github.io-dist .

[+] Building 29.7s (12/12) FINISHED
 => [internal] load .dockerignore                                                                                                                                                                                                        0.0s
 => => transferring context: 120B                                                                                                                                                                                                        0.0s
 => [internal] load build definition from Dockerfile                                                                                                                                                                                     0.0s
 => => transferring dockerfile: 424B                                                                                                                                                                                                     0.0s
 => [internal] load metadata for docker.io/library/ruby:3.2.0                                                                                                                                                                            1.8s
 => [1/5] FROM docker.io/library/ruby:3.2.0@sha256:98e340a1e5a9a61ee0c30e464a058da093ab8179460ed096a2a763a3abaa6c47                                                                                                                      0.0s
 => CACHED [2/5] WORKDIR /opt/nguyenvinhlinh.github.io                                                                                                                                                                                   0.0s
 => [internal] load build context                                                                                                                                                                                                        0.1s
 => => transferring context: 103.72kB                                                                                                                                                                                                    0.0s
 => [build 3/6] COPY . /opt/nguyenvinhlinh.github.io                                                                                                                                                                                     0.1s
 => [build 4/6] RUN bundle config set --local deployment true                                                                                                                                                                            0.7s
 => [build 5/6] RUN bundle install                                                                                                                                                                                                      23.7s
 => [build 6/6] RUN bundle exec jekyll build --destination=/opt/nguyenvinhlinh.github.io/dist                                                                                                                                            2.6s
 => [release 1/1] COPY --from=build  /opt/nguyenvinhlinh.github.io/dist /                                                                                                                                                                0.2s
 => exporting to client                                                                                                                                                                                                                  0.2s
 => => copying files 12.10MB
{% endhighlight %}
In this step, the key point here is about to copy all files from stage named `release` to host directory at `/var/tmp/nguyenvinhlinh.github.io-dist`.

Good luck, have fun!
## References
- Docker, Custom build outputs, [https://docs.docker.com/engine/reference/commandline/build/#output](https://docs.docker.com/engine/reference/commandline/build/#output)
