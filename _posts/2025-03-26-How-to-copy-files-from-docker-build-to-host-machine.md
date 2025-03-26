---
layout: post
title: "How to copy files from docker build to host machine?"
date: 2025-03-26 18:53:42
update:
location: Saigon
tags:
- docker
categories: etc
seo_description: Using docker build and extract files to host machine
seo_image:
comments: true
---
This guide is all about copy/extract file from docker build process, then copy it to host machine.

This method is very useful when you have to release/package `.rpm` file for further usage, but in this post,
I will use `mkdocs` for example, I build mkdocs html files with docker, then copy those html files to host
machine.

There are two things to consider:
- **Dockerfile**
- And **Build Command** for that **Dockerfile**

# I. Dockerfile
The key note is line number `8` and `9`

{% highlight Dockerfile linenos %}
FROM python:3.13.0 AS build

WORKDIR /opt/mining_rig_monitor_document_src
COPY . /opt/mining_rig_monitor_document_src
RUN pip install -r requirements.txt
RUN mkdocs build -c

FROM scratch AS release
COPY --from=build /opt/mining_rig_monitor_document_src/site /

{% endhighlight %}

`RUN mkdocs build -c` will create a directory named `site` which stores all html files. Then, from `scratch` image, we copy all thoses  html files to `/`

# II. Docker build command
This following command will copy all files from `release` stage to `nginx-dist`.

```shell
DOCKER_BUILDKIT=1 docker build -f  Dockerfile --target=release --output nginx-dist .
```

```text
➜ mining_rig_monitor_document (master) ✗ pwd
/home/nguyenvinhlinh/Projects/mining_rig_monitor_document


➜ mining_rig_monitor_document (master) ✗ tree -L 1
.
├── Dockerfile
├── docs
├── mining_rig_monitor_document
├── mkdocs.yml
├── nginx-dist      <<-- your files from docker build
├── readme.md
├── release_tar.sh
├── requirements.txt
├── site
├── venv
└── wireframe

```
