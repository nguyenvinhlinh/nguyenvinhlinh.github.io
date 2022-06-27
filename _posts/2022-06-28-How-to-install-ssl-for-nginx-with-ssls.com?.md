---
layout: post
title: "How to install ssl for nginx with ssls.com?"
date: 2022-06-28 01:30:46
update:
location: Saigon
tags:
- SSL
- Nginx
categories: SSL
seo_description:
seo_image:
comments: false
---
In this post, I would like to introduce a way to quickly setup SSL certificate for any website with `ssls.com`.

## Step 1: Generate private key and certificate signing request (csr).

To generate private key and certificate signing request, use the following command with a note of these parameters.
- **-keyout**: private key, for example: `your_domain.pem`
- **-out**: certificate signing request, for example `your_domain.csr`

{% highlight sh %}
$ openssl req -new -newkey rsa:2048 -nodes \
              -keyout your_domain.pem \
              -out your_domain.csr \
              -subj /CN=www.hexalink.xyz
{% endhighlight %}

## Step 2: Via the ssls.com, submit certificate signing request (csr)
{% include image.html url="/image/posts/2022-06-28-How-to-install-ssl-for-nginx-with-ssls.com/1.png" description="[1] Submit Certificate Signing Request" %}

## Step 3: Add a CNAME record in the Domain Manager like Hostinger & Waiting

## Step 4: Get certificate issued and download
After the download process, there gonna be three file
- your_domain.ca-bundle
- your_domain.crt
- your_domain.p7b

{% include image.html url="/image/posts/2022-06-28-How-to-install-ssl-for-nginx-with-ssls.com/2.png" description="[2] Download Certificate from ssls.com" %}

## Step 5: Concat bundle `your_domain.ca-bundle` and `your_domain.crt` in order with your favorite text editor
when concating, becareful of the missing new line error. This is an example of missing new line.
```text
-----END CERTIFICATE----------BEGIN CERTIFICATE-----
```

We can name concated file as `ssl-bundle.crt`.

After this time, there are two file that you need to bring to the nginx server.
1. Private key file from **Step 1**
2. Certificate file (`ssl-bundle.crt`) which has been concated from `your_domain.ca-bundle` and `your_domain.crt` in order.

## Step 6: Install private key and certificate file to nginx
This is an example of nginx config file, the most important attribute are:
- `listen 443;`
- `ssl on;`
- `ssl_certificate /etc/ssl/ssl-bundle.crt;`
- `ssl_certificate_key /etc/ssl/your_domain.pem;`

{% highlight nginx %}
server {

    listen 443; <----

    ssl on;     <----

    ssl_certificate /etc/ssl/ssl-bundle.crt;       <----

    ssl_certificate_key /etc/ssl/your_domain.pem;  <----

    server_name your_domain;

    access_log /var/log/nginx/nginx.vhost.access.log;

    error_log /var/log/nginx/nginx.vhost.error.log;

    location / {

        root /var/www/;

        index index.html;

    }

}
{% endhighlight %}

After finished editing, restart nginx server with `systemctl restart nginx` and enjoy.


## Reference List
- How to install an SSL certificate on a NGINX server?, July 9, 2019, [https://www.ssls.com/knowledgebase/how-to-install-an-ssl-certificate-on-a-nginx-server/](https://www.ssls.com/knowledgebase/how-to-install-an-ssl-certificate-on-a-nginx-server/)
