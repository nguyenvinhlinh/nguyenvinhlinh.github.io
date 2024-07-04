---
layout: post
title: "How to install ssl certificate for nginx with SSLs.com?"
date: 2022-06-28 01:30:46 +0700
update: 2024-07-04 17:03:50
location: Saigon
tags:
- SSL
- Nginx
categories: SSL
seo_description: Installing SSL certificate with SSLs.com
seo_image:
comments: true
---
In this post, I would like to introduce a way to quickly setup SSL certificate for any website with [https://www.ssls.com/](https://www.ssls.com/)

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

## Step 5: Concat bundle `your_domain.crt` and `your_domain.ca-bundle` in order with your favorite text editor.
Please becareful while do concat
- missing new line error. This is an example of missing new line.
```text
-----END CERTIFICATE----------BEGIN CERTIFICATE-----
```
- Incorrect order, `.crt` before `.ca-bundle`

We can name concated file as `ssl-bundle.crt`.

After this time, there are two file that you need to bring to the nginx server.
1. Private key file from **Step 1**, for example: `your_domain.pem`
2. Certificate file (`ssl-bundle.crt`) which is a  concat version of `your_domain.ca-bundle` and `your_domain.crt` in order.

## Step 6: Install private key and certificate file to nginx
Before configure `nginx.conf` file at `/etc/nginx`, it's a need to copy private key file and certificate file to `/etc/pki/nginx/`.

You can choose different directory, but you need to make it up to date in the `nginx.conf` file.

This is an example of nginx config file, the most important attribute are:
- `listen 443;`
- `ssl on;`
- `ssl_certificate /etc/pki/nginx/ssl-bundle.crt;`
- `ssl_certificate_key /etc/pki/nginx/your_domain.pem;`



{% highlight nginx %}
server {
    listen       443 ssl;  <-----
    listen       [::]:443 ssl; <-----
    http2        on;
    server_name  abc.xyz;  <-----
    root         /usr/share/nginx/abc.xyz.html; <-----

    ssl_certificate "/etc/pki/abc.xyz/www_abc_xyz.bundle.crt";   <-----
    ssl_certificate_key "/etc/pki/abc.xyz/www_abc_xyz.pem";      <-----
    ssl_session_cache shared:SSL:1m;
    ssl_session_timeout  10m;
    ssl_ciphers PROFILE=SYSTEM;
    ssl_prefer_server_ciphers on;
    charset UTF-8;

    # Load configuration files for the default server block.
    include /etc/nginx/default.d/*.conf;
}

{% endhighlight %}

After finished editing, restart nginx server with `systemctl restart nginx` and enjoy.


## Reference List
- How to install an SSL certificate on a NGINX server?, July 9, 2019, [https://www.ssls.com/knowledgebase/how-to-install-an-ssl-certificate-on-a-nginx-server/](https://www.ssls.com/knowledgebase/how-to-install-an-ssl-certificate-on-a-nginx-server/)
