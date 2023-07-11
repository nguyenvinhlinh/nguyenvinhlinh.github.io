---
layout: post
title: "Talend, Overriding context params when deployment"
date: 2023-05-12 03:45:29 +0700
update:
location: Saigon
tags:
- Talend
categories:
- Talend
seo_description: "Talend, Overriding context params when deployment"
seo_image: /image/posts/2023-05-12-Talend-Overriding-context-params-when-deployment/5-seo.png
comments: true
---

In this tutorial, I would like to introduce a new topic - **How to override context params when deploy talend job**.
In general, there are two method

- config via file.
- config by passing parameter in shell script.

Before going further with these two method, I would like to establish a list of context variable and write a small `tJava` code to print out these context variables.

| Variable Name | Variable Type   | Value                  |
| ------------- | --------------- | ---------------------- |
| var_1         | String          | var_1_original_content |
| _var_2        | String          | var_2_original_content |
| var_3         | Password        | password               |
| var_4         | int - Integer   | 1                      |
| var_5         | float - Float   | 2.2                    |
| var_6         | double - Double | 3.3                    |
| var_7         | Date            | 2023-05-11 00:00:00    |


{% include image.html url="/image/posts/2023-05-12-Talend-Overriding-context-params-when-deployment/1.png" description="[1] Context " %}

Then, I create a new tJava component with the following content.

{% highlight java %}
System.out.println("Hello World!");
String var1 = context.var_1;
String var2 = context._var_2;
String var3 = context.var_3;
Integer var4 = context.var_4;
Float var5 = context.var_5;
Double var6 = context.var_6;
Date var7 = context.var_7;

System.out.println("context.var_1: "  + var1);
System.out.println("context._var_2: " + var2);
System.out.println("context.var_3: "  + var3);
System.out.println("context.var_4: "  + var4);
System.out.println("context.var_5: "  + var5);
System.out.println("context.var_6: "  + var6);
System.out.println("context.var_7: "  + var7);
{% endhighlight %}

Now, I build job, choose  Override parameter's value, for quick value defining, I choose Value from selected
context, and Finish. A zip file will be generated and it’s ready to execute.

{% include image.html url="/image/posts/2023-05-12-Talend-Overriding-context-params-when-deployment/2.png" description="[2] Build Step 1" %}
{% include image.html url="/image/posts/2023-05-12-Talend-Overriding-context-params-when-deployment/3.png" description="[3] Build Step 2" %}
{% include image.html url="/image/posts/2023-05-12-Talend-Overriding-context-params-when-deployment/4.png" description="[4] Build Step 3" %}

After you extract the zip file, you gonna see file directory tree like this.
{% include image.html url="/image/posts/2023-05-12-Talend-Overriding-context-params-when-deployment/5.png" description="[5] Extracted directory" %}

To execute the job, in my case, you need to run the following command. And, as you can see, our context parameters has been printed well.

{% highlight shell %}

$ pwd
C:\Users\Nguyen Vinh Linh\Temporary\etl_01_test_override_context_params_1.0\etl_01_test_override_context_params

$ .\etl_01_test_override_context_params\etl_01_test_override_context_params_run.ps1
Hello World!
context.var_1: var_1_original_content
context._var_2: var_2_original_content
context.var_3: original_password
context.var_4: 1
context.var_5: 2.2
context.var_6: 3.3
context.var_7: Thu May 11 00:00:00 ICT 2023
{% endhighlight %}

Now, we are ready to go the main part - Config runtime parameters via file & executable scripts.

## I. Config with `file.properties`
Open `Default.properties` with your your favorite text editor and edit this file to update context params.

{% highlight properties %}
#this is context properties
#Thu May 11 12:51:57 ICT 2023
_var_2=var_2_original_content
var_1=var_1_original_content
var_3=enc\:routine.encryption.key.v1\:yw2kFUbYTflWCDmJafHrHq1+vdJ6QPYjQebpT0pO1NcoDTJc5A++/y67rudl
var_4=1
var_5=2.2
var_6=3.3
var_7=2023-05-11 00\:00\:00
{% endhighlight %}

At this step, it’s important to escape special character if you play with datetime type. In my case, it’s var_7.

## II. Config with executable scripts (.bat, .ps1, .sh)
This is my content of files
- `etl_01_test_override_context_params_run.ps1`
{% highlight powershell %}
$fileDir = Split-Path -Parent $MyInvocation.MyCommand.Path
cd $fileDir
java '-Dtalend.component.manager.m2.repository=%cd%/../lib' '-Xms256M' '-Xmx1024M' -cp '.;../lib/routines.jar;../lib/log4j-slf4j-impl-2.13.2.jar;../lib/log4j-api-2.13.2.jar;../lib/log4j-core-2.13.2.jar;../lib/jboss-marshalling-2.0.12.Final.jar;../lib/dom4j-2.1.3.jar;../lib/slf4j-api-1.7.29.jar;../lib/crypto-utils-0.31.12.jar;etl_01_test_override_context_params_1_0.jar;' context_params_test.etl_01_test_override_context_params_1_0.etl_01_test_override_context_params --context=Default $args

{% endhighlight %}

`$args` will pass all arguments to running script.


- `etl_01_test_override_context_params_run.sh`

{% highlight shell %}

#!/bin/sh
cd `dirname $0`
ROOT_PATH=`pwd`
java -Dtalend.component.manager.m2.repository=$ROOT_PATH/../lib -Xms256M -Xmx1024M -cp .:$ROOT_PATH:$ROOT_PATH/../lib/routines.jar:$ROOT_PATH/../lib/log4j-slf4j-impl-2.13.2.jar:$ROOT_PATH/../lib/log4j-api-2.13.2.jar:$ROOT_PATH/../lib/log4j-core-2.13.2.jar:$ROOT_PATH/../lib/jboss-marshalling-2.0.12.Final.jar:$ROOT_PATH/../lib/dom4j-2.1.3.jar:$ROOT_PATH/../lib/slf4j-api-1.7.29.jar:$ROOT_PATH/../lib/crypto-utils-0.31.12.jar:$ROOT_PATH/etl_01_test_override_context_params_1_0.jar: context_params_test.etl_01_test_override_context_params_1_0.etl_01_test_override_context_params --context=Default "$@"
{% endhighlight %}

`$@` similar to `$args` but in shell script, it will pass all arguments to running script.

To override context parameters, I just need to add `--context_param var_1=var_1_value`  when execute the script. For example

{% highlight powershell %}
#Powershell
$ .\etl_01_test_override_context_params\etl_01_test_override_context_params_run.ps1 --context_param var_1=var1 --context_param _var_2=var2 --context_param var_3=new_password --context_param var_7="2023-05-3 23:59:59"

Hello World!
context.var_1: var1
context._var_2: var2
context.var_3: new_password
context.var_4: 1
context.var_5: 2.2
context.var_6: 3.3
context.var_7: Wed May 03 23:59:59 ICT 2023
{% endhighlight %}

{% highlight shell %}
#Bash
$ .\etl_01_test_override_context_params\etl_01_test_override_context_params_run.sh --context_param var_1=var1 --context_param _var_2=var2 --context_param var_3=new_password --context_param var_7="2023-05-3 23:59:59"

Hello World!
context.var_1: var1
context._var_2: var2
context.var_3: new_password
context.var_4: 1
context.var_5: 2.2
context.var_6: 3.3
context.var_7: Wed May 03 23:59:59 ICT 2023
{% endhighlight %}

Good luck!
