---
layout: post
title: "How to verify Hostinger domains for ZeroSSL certificate using DNS(CNAME)?"
date: 2020-10-10 00:08:51 +0700
tags: ssl, zerossl, cname, hostinger
categories: SSL
---

ZeroSSL is a free ssl certificate provider. I had follow all the instructions on their official website to configure my hostinger domain, but it's not enough.
At the domain verification step, it declared that `Invalid CAA Records` eventhough my CNAME record was configured correctly.
Seemingly, Hostinger CCA's default value is missing something.

{% include image.html url="/image/posts/2020-10-10-How-to-verify-domains-for-ZeroSSL-certificate-using-DNS-CNAME/1.png" description="[1] Invalid CCA Record" %}

The solution is that you need to check the `CCA` section belonging to `DNS Zone`. It's a must to have following yellow records in your CAA list.

{% include image.html url="/image/posts/2020-10-10-How-to-verify-domains-for-ZeroSSL-certificate-using-DNS-CNAME/2.png" description="[2] CCA List" %}

If you dont have those records, you need to add it manually one by one. Although, you submit new CAA records, it could take up to 30 minutes for verification.

{% highlight txt %}
|------+---------------------------+-------|
| name | content                   |   TTL |
|------+---------------------------+-------|
| @    | 0 issue "sectigo.com"     | 14400 |
| @    | 0 issuewild "sectigo.com" | 14400 |
|------+---------------------------+-------|
{% endhighlight %}


Reference: [https://help.zerossl.com/hc/en-us/articles/360015629499-Verification-error-Invalid-CAA-Records](https://help.zerossl.com/hc/en-us/articles/360015629499-Verification-error-Invalid-CAA-Records)
