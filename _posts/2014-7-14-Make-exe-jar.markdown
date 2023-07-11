---
layout: post
title: "How to compile executable jar file from source code"
date: 2014-07-14 23:00:00 +0700
categories:  etc
tag: java, jar
---
This thread will illustrate how to make a executable file.

#1.Create file "manifest.txt"

{% highlight bash linenos %}
Main Class: package.to.my.ProgramLaucher
\n - 'this character will not be writen, I mean that you need to end with a new line'
{% endhighlight %}

for example, my class is:

{% highlight java linenos %}
package cosc2101.assignment1.controller;
public class ProgramLauncher {
    public static void main(String[] args) {
	     System.out.println("Hello World");
    }
}
{% endhighlight %}

then, my manifest file should be
{% highlight bash linenos %}
Main Class: cosc2010.assignment1.controller.ProgramLaucher
next line here(compulsory)
{% endhighlight %}

#2. Making file .class
This file is a compiled file of file.java. In order to make this file. Use the
following command on the terminal.

{% highlight bash %}
javac .path/to/file.java
{% endhighlight %}

In this case, my output is a file named `ProgramLaucher.class`
#3.Setting up folder for compile
In order to compile java source code, you need to add file manifest.txt and
compiled file `file.class`. For example in the case above, after make a new
directory, our directory should be

{% highlight bash %}
------/
      manifest.txt
	  cosc2101/assignment1/controller/ProgrammerLaucher.class
{% endhighlight %}

#4. Make .jar file
Within this directory
{% highlight bash %}
jar -cvfm ProgramLaucher.jar manifest.txt *.class

'c' refers to creating new archive file, in this case, it is
`ProgramLaucher.jar`
'v' refers to verbose, while processing, all relevant details will be report on
the terminal screen
'f' refers to specified file .jar will be created - creating option is assigned
by `c` but, what and where to create is assigned by `f`
'm' refers to manifest file
{% endhighlight %}

#5. Run file .jar
Using the following command
{% highlight bash %}
java -jar ProgramLaucher.jar
{% endhighlight %}
