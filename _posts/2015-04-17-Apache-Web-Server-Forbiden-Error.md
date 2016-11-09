---
layout: post
title: Apache Web Server, Forbidden Error
date: 2015-04-17
categories: etc
tag: Apache,Web Server, Forbidden Error, Index
---
**Problem**: Apache Web Server announces that `Forbidden Error`, given that developers configure `Allow` and `Deny` directory with no mistake  
**Reason**: A lack of `Indexes` for files in directory.  
**Solution**: Add option `Indexes` in directory tag `<Directory>`

**Example**: The following configuration causes forbidden error

{% highlight bash%}
<Directory "/home/pvt/apache2/htdocs">
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>

{% endhighlight%}

The following configuration solve the problem
{% highlight bash%}
<Directory "/home/pvt/apache2/htdocs">
    Options Indexes FollowSymLinks
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>
{% endhighlight%}
