---
layout: post
title: "Talend, How to export log in JSON Format?"
date: 2023-06-21 13:51:32
update:
location: Saigon
tags: Talend
categories: Talend
seo_description: Exporting json log in Talend 8.0.1
seo_image: /image/posts/2023-06-21-Talend-How-to-export-log-in-JSON-Format/seo.png
comments: true
---

# Step 1: Go to File → Project Properties

{% include image.html url="/image/posts/2023-06-21-Talend-How-to-export-log-in-JSON-Format/1.png" description="[1] File → Project Properties" %}

# Step 2: Go to log4j section and Activate log4j in components (Log4j version: log4j2)
{% include image.html url="/image/posts/2023-06-21-Talend-How-to-export-log-in-JSON-Format/2.png" description="[2] Activate log4j in components" %}

In the **Log4j template**, use the following template.

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<Configuration >
  <Appenders>
    <Console name="Console" target="SYSTEM_OUT">
      <PatternLayout  >
        <pattern>
          {% raw %}{ 'timestamp':"%d{ISO8601}", 'level':"%level", 'category':"%c", 'message':"%enc{%m}{JSON}" }%n{% endraw %}
        </pattern>
      </PatternLayout>
    </Console>
  </Appenders>

  <Loggers>
    <Root level="INFO">
      <AppenderRef ref="Console" />
    </Root>
  </Loggers>
</Configuration>
{% endhighlight %}


# Step 3: Create tJava in Talend Job to export log

{% include image.html url="/image/posts/2023-06-21-Talend-How-to-export-log-in-JSON-Format/3.png" description="[3] tJava" %}

- Basic settings code:

{% highlight java %}
String message = "Hello World";
log.fatal(message);
log.error(message);
log.warn(message);
log.info(message);
log.debug(message);
log.trace(message);
{% endhighlight %}

- Advanced settings code:
{% highlight java %}
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;
{% endhighlight %}

You then can **RUN**  your talend job, the output should look like the following.

{% include image.html url="/image/posts/2023-06-21-Talend-How-to-export-log-in-JSON-Format/4.png" description="[4] Basic Run - Console" %}

# References
- Configure PatternLayout, [jmcollin92](https://stackoverflow.com/users/1616656/jmcollin92), 2021, May 24, [https://stackoverflow.com/questions/29387007/does-log4j-support-json-format#comment119606534_37455869](https://stackoverflow.com/questions/29387007/does-log4j-support-json-format#comment119606534_37455869).
- Handle special character in json log message, [Nishan B](https://stackoverflow.com/users/8255039/nishan-b), 2022, November 25, [https://stackoverflow.com/questions/29387007/does-log4j-support-json-format#comment131629876_37455869](https://stackoverflow.com/questions/29387007/does-log4j-support-json-format#comment131629876_37455869).
