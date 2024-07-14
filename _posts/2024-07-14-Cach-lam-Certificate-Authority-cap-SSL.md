---
layout: post
title: "Cách làm Certificate Authority cấp SSL nội bộ"
date: 2024-07-14 23:32:20
update:
location: Saigon
tags:
categories:
- SSL
seo_description: Cách tạo Certificate Authority để cấp chứng chỉ SSL nội bộ
seo_image: /image/posts/2024-07-14-Cach-lam-Certificate-Authority-cap-SSL/1.png
comments: true
---

{% include image.html url="/image/posts/2024-07-14-Cach-lam-Certificate-Authority-cap-SSL/1.png" description="[1] Mô hình chứng chỉ" %}


# I. Tạo Certificate Authority
## a. Tạo private key
{% highlight shell %}
$ openssl genrsa -des3 -out my-ca.key 4096
{% endhighlight %}

## b. Tạo certificate
{% highlight shell %}
$ openssl req -x509 -new -nodes -key my-ca.key -sha256 -days 365000 -out my-ca.pem
{% endhighlight %}

Kết quả của quá trình này là file `my-ca.pem` đây là certificate của **Certificate Authority**. Nói một cách khác, một **Certificate Authority** đã được tạo.

# II. Tạo web1.local certificate
## a. Tạo private key
{% highlight shell %}
$ openssl genrsa -out web1.local.key 4096
{% endhighlight %}

## b. Tạo yêu cầu chứng nhận, (Certificate signing request)
{% highlight shell %}
$ openssl req -new -key web1.local.key -out web1.local.csr
{% endhighlight %}

## c. Tạo thêm  X509 V3 certificate extension config file
Tạo file có tên là `web1.local.ext`

{% highlight properties %}
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = web1.local
{% endhighlight %}

## d. Tạo certificate cho web1.local
Yêu cầu:
- my-ca.key - private key của **Certificate Authority(CA)**
- my-ca.pem - certificate của **Certificate Authority(CA)**
- web1.local.csr - yêu cầu tạo chứng chỉ(Certificate signing request - CSR) của trang web, ví dụ **web1.local**
- web1.local.ext - extension của yêu cầu tạo chứng chỉ.

{% highlight shell  %}
$ openssl x509 -req -in ./web1.local-cert/web1.local.csr  -CA ./ca-cert/my-ca.pem  -CAkey ./ca-cert/my-ca.key \
    -CAcreateserial -out ./web1.local-cert/web1.local.crt -days 365 -sha256 -extfile  ./web1.local-cert/web1.local.ext
{% endhighlight %}
