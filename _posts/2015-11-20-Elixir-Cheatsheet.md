---
layout: post
title: Elixir Cheatsheet
date: 2015-11-20 15:37:17
categories: cheatsheet
tag: etc
--- 

This is cheatsheet for Elixir, it's a not a summary of this language, this
article all about tweak, remember note for Elixir language.


**1. For loop**  
Given that, we we a list of map
{% highlight elixir %}
people = [
  %{name: "Linh", age: 22},
  %{name: "Son", age: 18},
  %{name: "Long", age: 15},
]
{% endhighlight %}

{% highlight elixir %}
for person <- people, do: (
  IO.inspect person
)
{% endhighlight %}

Elixir supports a for conditional loop.
{% highlight elixir %}
for person = %{age: tuoi}<- people, tuoi < 20, do: (
  IO.inspect person
)
{% endhighlight %}

**2. Update a map**  
{% highlight elixir %}
old_map = %{attr1: 1, attr2: 2 }
new_map = %{old_map | attr1:  3}
{% endhighlight %}

**3. Struct**  
 Generate Struct
{% highlight elixir %}
defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true
end

sub1 = %Subcriber{}
sub2 = %Subcriber{name: "sub2", paid: true, over_18: false}
{% endhighlight %}

 Use Struct attribute
{% highlight elixir %}
sub1.name
sub2.name
sub2[:name]
{% endhighlight %}

 Update attr in a struct
{% highlight elixir %}
sub2 = %Subcriber{name: "sub2", paid: true, over_18: false}
sub2 = %{sub2 | name: "Another sub2"}

#alternative solution:
put_in(sub2.name, "new_name")
{% endhighlight %}
