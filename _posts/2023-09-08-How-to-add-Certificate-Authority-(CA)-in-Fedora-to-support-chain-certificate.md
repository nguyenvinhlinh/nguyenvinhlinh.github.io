---
layout: post
title: "How to add Certificate Authority (CA) in Fedora to support chain certificate?"
date: 2023-09-08 19:27:45
update: 2025-06-02 12:36:00
location: Saigon
tags:
- SSL
- Fedora
categories:
- SSL
seo_description:
seo_image: /image/posts/2023-09-08-How-to-add-Certificate-Authority-(CA)-in-Fedora-to-support-chain-certificate/seo.png
comments: true
---

# Step 1. Using chrome to extract certificates.

{% include image.html url="/image/posts/2023-09-08-How-to-add-Certificate-Authority-(CA)-in-Fedora-to-support-chain-certificate/1.png" description="[1] Open certificate viewer in Google Chrome" %}

{% include image.html url="/image/posts/2023-09-08-How-to-add-Certificate-Authority-(CA)-in-Fedora-to-support-chain-certificate/2.png" description="[2] Export certificate" %}

**Only need to use extract CA’s certificate**. Export it with file extension named `.pem`


Please take a note that,  `update-ca-trust` determines certificate format using file header which locates in very first bytes in the binary file. Eventhough you save certificates with `.crt` , `.cer`, it’s still `.pem`.

To determine file format, you shoule use command file, for example `$ file file_name`.

To illustrate this point. I’ll give an example.

{% highlight shell %}

####### List all file, take a look at the file extension, .crt and .pem
$ ls -l
'Default Trust_DigiCert Global Root CA.crt'
'Default Trust_DigiCert Global Root CA.pem'


####### Determine file format with command named `file`
$ file *
Default Trust_DigiCert Global Root CA.crt: PEM certificate
Default Trust_DigiCert Global Root CA.pem: PEM certificate
{% endhighlight %}


# Step 2. Copy certificate authority’s certificate  to `/etc/pki/ca-trust/source/anchors`

# Step 3. Update `/etc/ssl/certs/ca-certificates.crt`
{% highlight shell %}
$ sudo update-ca-trust extract
{% endhighlight %}

You can check this file  `/etc/ssl/certs/ca-certificates.crt` to ensure that it is updated.

# Step 4. Testing
This is an image before `update-ca-trust`
{% include image.html url="/image/posts/2023-09-08-How-to-add-Certificate-Authority-(CA)-in-Fedora-to-support-chain-certificate/3.png" description="[3] Before update-ca-trust" %}

And, this is an image after `update-ca-trust`.
{% include image.html url="/image/posts/2023-09-08-How-to-add-Certificate-Authority-(CA)-in-Fedora-to-support-chain-certificate/4.png" description="[3] After update-ca-trust" %}

Good luck!
