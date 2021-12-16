---
layout: post
title: "How to make executable jar with Gradle?"
date: 2021-12-16 01:11:42
tags:
- Linux
categories:
- Linux
seo_description: A solution to make an executable jar with Gradle.
seo_image: /image/posts/2021-12-16-How-to-make-executable-jar-with-gradle/1.png
comments: true
---

Gradle is a build automation tool for multi-language software development. It controls the development process in the tasks of compilation
and packaging to testing, deployment, and publishing. Supported languages include Java (as well as Kotlin, Groovy, Scala), C/C++, and
JavaScript. The other, if not the major function of Gradle is to collect statistical data about the usage of software libraries around
the globe.

In this post, I would like to introduce a solution to create an executable jar with Gradle. All modification related to a file named
`build.gradle`. This file located at `/project-root/app/build.gradle`. By default, this file will be generated with Gradle `init` task.

There are three part concerned:
- Add a plugin named `application` to `plugins` block.
{% highlight gradle %}
plugins {
    // Apply the application plugin to add support for building a CLI application in Java.
    id 'application'
}
{% endhighlight %}

- Define `mainClass` in `application` block.
{% highlight gradle %}
application {
    // Define the main class for the application.
    mainClass = 'JekyllPostGenerator.App'              # MODIFY IT
}
{% endhighlight %}

- Define `jar` block.
{% highlight gradle %}
jar {
    archiveBaseName = 'jekyll-post-generator'          # MODIFY IT
    archiveVersion =  '2.0.0'                          # MODIFY IT
    manifest {
        attributes(
               'Main-Class': 'JekyllPostGenerator.App' # MODIFY IT
        )
    }
}
{% endhighlight %}


Last but not least, you need to run gradle task named `jar` to created an executable jar file which would be created in `/root-project/app/build/libs`. Regarding above configuration,
my executable file will be `jekyll-post-generator-2.0.0.jar`. This file now can be executed with `java -jar jekyll-post-generator-2.0.0.jar`. And this is a command to create `jar` file.
```bash

# In the project-root
./gradlew jar

```

{% include image.html url="/image/posts/2021-12-16-How-to-make-executable-jar-with-gradle/1.png" description="[1] `gradlew jar` task output example." %}
