---
layout: post
title: Comparison of LinkList,Tuples, Maps, HashDict and Keyword Comparison in Elixir
date: 2015-12-01 13:37:56
categories: etc
tag: etc
--- 

**1. Tuples**  
It's an order collection of values. There is a tip for using Tuples, a typical tuples 
has two to four elements  
*  Once created, a tuples cannot be modified, the only thing we can do is
matching(assigning) variable with new tuple.  
*  If the number of tuple element is great,(probably greater than 4 elements),
programmer should use `Map`


**2. List (LinkList)**  
The list of Elixir is link-list, there are some features/specification that you
should noted.  
* It is easy to travel from head to tail, but expensive to get to particular
element for example `a[22]`. You will have to loop via 21 elements.  
* It's easy to add an new element to a link-list to the head or tail.  

**3. Keyword List**  
Keyword list is a list of tuples of pair values. An example below explain the
keyword list.
{% highlight elixir %}
[name: "Linh", age: 2]
[{:name, "Linh}, {:age, 2}]
{% endhighlight %}
* Keyword list allows duplicated key value, because in fact, it's a list  

**4. Map**  
Map is used to save collection with a pair of key and value. Unlike keyword
list, Map does not allow duplicated keys. Accessing a map by: 
{% highlight Elixir %}
states = %{ "AL" => "Alabama", "WI" => "Wisconsin" }
states["AL"]
{% endhighlight %}

