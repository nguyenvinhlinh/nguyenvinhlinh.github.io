---
layout: post
title: "How does this website is built & delploy?"
date: 2024-07-05 10:43:20
update:
location: Saigon
tags:
- Projects
categories:
- Projects
seo_description:
seo_image:
comments: true
---

# 1. Introduction
This website is built with [**Jekyll**](https://jekyllrb.com/), build with [**Docker**](https://github.com/nguyenvinhlinh/nguyenvinhlinh.github.io/blob/master/Dockerfile) and deploy with
[**Nginx on bare metal**](https://nginx.org/en/). At the deploy step,
it's all about copy file html files from docker to nginx's www directory.

A process of **auto-build & auto-deploy** is done with [**Jenkins**](https://www.jenkins.io/).

# 2. Jenkins
## a. Build Trigger
I use **GitHub hook trigger for GITScm polling**.

{% include image.html url="/image/posts/2024-07-05-How-does-this-website-is-built-delploy/1.png" description="[1] Jenkins - Build Trigger" %}

In addition, on the github, I configure github's webhook.

{% include image.html url="/image/posts/2024-07-05-How-does-this-website-is-built-delploy/2.png" description="[2] Jenkins - Github's webhook" %}

## b. Pipeline
{% highlight groovy %}
pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/nguyenvinhlinh/nguyenvinhlinh.github.io'
            }
        }

        stage('Build') {
            steps {
                sh 'DOCKER_BUILDKIT=1 docker build -f  Dockerfile --target=release --output nginx-dist .'
            }
        }

        stage('Remove old html') {
            steps {
                sh 'rm -rvf /usr/share/nginx/hexalink.xyz.html/*'
            }
        }

        stage('Copy to /usr/share/nginx/hexalink.xyz.html/') {
            steps {
                sh 'cp -r ./nginx-dist/* /usr/share/nginx/hexalink.xyz.html/'
            }
        }
    }
}

{% endhighlight %}

There is a trick here to copy to nginx's www directory. user named `jenkins` does copy file htmls into the nginx's html directory.
As a consequence, prior to run pipeline,
- First, I create nginx's html directory  (`/usr/share/nginx/hexalink.xyz.html/`)
- Then, I change user ownership to `jenkins`.

# 3. Nginx
## a. Nginx config for hexalink.xyz / www.hexalink.xyz


{% highlight nginx %}
server {
    listen       443 ssl;
    listen       [::]:443 ssl;
    http2        on;
    server_name  hexalink.xyz www.hexalink.xyz;
    root         /usr/share/nginx/abc.xyz.html;

    ssl_certificate "/etc/pki/abc.xyz/www_abc_xyz.bundle.crt";
    ssl_certificate_key "/etc/pki/abc.xyz/www_abc_xyz.pem";
    ssl_session_cache shared:SSL:1m;
    ssl_session_timeout  10m;
    ssl_ciphers PROFILE=SYSTEM;
    ssl_prefer_server_ciphers on;
    charset UTF-8;

    # Load configuration files for the default server block.
    include /etc/nginx/default.d/*.conf;
}

{% endhighlight %}

## b. Nginx config for jenkins
I follow this tutorial [Reverse proxy - Nginx](https://www.jenkins.io/doc/book/system-administration/reverse-proxy-configuration-with-jenkins/reverse-proxy-configuration-nginx/).
