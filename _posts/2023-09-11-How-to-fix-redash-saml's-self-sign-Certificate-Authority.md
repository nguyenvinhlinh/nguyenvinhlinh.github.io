---
layout: post
title: "How to fix redash saml's self-sign Certificate Authority?"
date: 2023-09-11 21:28:01
update:
location: Saigon
tags:
categories:
- Redash
seo_description:
seo_image:
comments: true
---

{% highlight text %}
During handling of the above exception, another exception occurred:
Traceback (most recent call last):
  File "/usr/local/lib/python3.7/site-packages/urllib3/connectionpool.py", line 600, in urlopen
    chunked=chunked)
  File "/usr/local/lib/python3.7/site-packages/urllib3/connectionpool.py", line 343, in _make_request
    self._validate_conn(conn)
  File "/usr/local/lib/python3.7/site-packages/urllib3/connectionpool.py", line 839, in _validate_conn
    conn.connect()
  File "/usr/local/lib/python3.7/site-packages/urllib3/connection.py", line 344, in connect
    ssl_context=context)
  File "/usr/local/lib/python3.7/site-packages/urllib3/util/ssl_.py", line 345, in ssl_wrap_socket
    return context.wrap_socket(sock, server_hostname=server_hostname)
  File "/usr/local/lib/python3.7/site-packages/urllib3/contrib/pyopenssl.py", line 462, in wrap_socket
    raise ssl.SSLError('bad handshake: %r' % e)
ssl.SSLError: ("bad handshake: Error([('SSL routines', 'tls_process_server_certificate', 'certificate verify failed')])",)
{% endhighlight %}

{% highlight text %}
During handling of the above exception, another exception occurred:
Traceback (most recent call last):
  File "/usr/local/lib/python3.7/site-packages/requests/adapters.py", line 449, in send
    timeout=timeout
  File "/usr/local/lib/python3.7/site-packages/urllib3/connectionpool.py", line 638, in urlopen
    _stacktrace=sys.exc_info()[2])
  File "/usr/local/lib/python3.7/site-packages/urllib3/util/retry.py", line 399, in increment
    raise MaxRetryError(_pool, url, error or ResponseError(cause))
urllib3.exceptions.MaxRetryError: HTTPSConnectionPool(host=MY_ADFS_SERVER.LOCAL', port=443):
Max retries exceeded with url: /FederationMetadata/2007-06/FederationMetadata.xml
(Caused by SSLError(SSLError("bad handshake: Error([('SSL routines', 'tls_process_server_certificate', 'certificate verify failed')])")))
{% endhighlight %}

# Why does it happen?
Redash trying to get **SAML's** `FederationMetadata.xml` from a self-sign ADFS server. Python package named `certifi` did not update with your new CA's certificate.

# How to solve?
- Find `certifi`'s `cacert.pem` and update it.
In terminal, type `python` to access its interactive shell. Then, type the following command.

{% highlight python %}
>>> import certifi
>>> certifi.where()
'/usr/local/lib/python3.7/site-packages/certifi/cacert.pem'
{% endhighlight %}

In this case, it's `/usr/local/lib/python3.7/site-packages/certifi/cacert.pem`.

- Append your CA's certificate to `cacert.pem`.

{% highlight she %}
$ cat my-ca.crt >> /usr/local/lib/python3.7/site-packages/certifi/cacert.pem
{% endhighlight %}

Good luck!

# Reference
- How to fix “certificate verify failed: self signed certificate in certificate chain”or “certificate verify failed: unable to get local issuer certificate” error while verifying certificates to SSL enabled website in python3 scripts, Sheng Jie Han, 2021, June 3, [https://community.ibm.com/community/user/ibmz-and-linuxone/blogs/sheng-jie-han/2021/06/03/how-to-fix-certificate-verify-failed-self-signed-c](https://community.ibm.com/community/user/ibmz-and-linuxone/blogs/sheng-jie-han/2021/06/03/how-to-fix-certificate-verify-failed-self-signed-c)
