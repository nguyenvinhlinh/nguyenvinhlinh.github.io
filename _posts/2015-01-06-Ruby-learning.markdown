---
layout: post
title: "Ruby - learning"
date: 2015-01-06 12:24:00 +0700
categories: cheatsheet
tags: Ruby
---
#1. Variable in ruby class
- Local variable: defined inside a method, the usage of local variable in only
inside a method. Prefix of local variable is `_` or `[a-z]`.
- Instance variable: instance variable is available accross methods and object,
meanwhile, instance variable change from object to object. Prefix of instance
variable is `@`. Instance variable is not shared among its descedants.
- Class variable: it belongs to a class and is a characteristic of this class.
Prefix is `@@`. Class variable is share among its descedants(childs).
- Global variable: class varaible is not across class, however, global variable
does. The prefix of global variable is `$`.
- Constant variable: it's similar to class variable but it's constant. Constant
varaibles should be in upper case for all letters.

#2. Commenting
- Using `=begin` and `=end`
{% highlight ruby %}
=begin
This is a multiline comment and con spwan as many lines as you
like. But =begin and =end should come in the first line only.
=end
{% endhighlight %}
- Using `#`
{% highlight ruby %}
 # This is a single line comment.
{% endhighlight %}

#3. Method
{% highlight ruby %}
def method_name (arg = default_value,arg2 = default_value2 )
    expression
end
{% endhighlight %}

#4. Block
- Block must be named after a name of a method (or a function), other while,
it does not work. Usage: In a method, there might be an chunk of code which is
used many time within the method, the point is that, this chunk of code is not
worth making a new function or maybe programmers don't want to make a function
on that chunk (they cannot think a name for that).
{% highlight ruby %}
def function_name
   puts "In a function"
   yield
   puts "Come back to function"
end

function_name{
   puts "In a block"
}
{% endhighlight %}
- It's also possible to insert parameters into a block. However, if a function has parameters, I don't know but there is a error and
cannot use block with function which have parameters.
{% highlight ruby %}
def function_name
   yield a, b
end
function_name {
   |a,b|
   puts a+b
}
{% endhighlight %}

#5. Class
- Class structure
{% highlight ruby %}
 #making a class
class Box
end
{% endhighlight %}
- Initial method
{% highlight ruby %}
class Box
 #`@` is a declare of instance varaibles
    def initialize(w,h)
	    @width = w
		@height = h
    end
end
{% endhighlight %}
- Getters and setters
{% highlight ruby %}
class Box
    @@number_of_box = 0
    def initialize(w,h)
	    @width = w
		@height = h
    end
    # These are getters
    def printWidth
	    @width
	end
    def printHeight
	    @height
    end
    #These are setters
	def setWidth=(new_value)
	    @width = new_value
	end
	def setHeight=(new_value)
	    @height = new_value
    end
	#usage of @@class variables
    def printNumberOfBox
	    puts @@number_of_box
	end
end
{% endhighlight %}
#6. Access control: Public, Private, Protected
- Public method: is called by anyone. By default, all methods excepting
  initialize method are public methods.
- Private method: only class methods can access private methods
- Protected method: is called by class method and its subclass method.
{% highlight ruby %}
private :functionA, :functionB
protected :functionD, :functionD
{% endhighlight %}

#7.Inheritance, method overriding, operator overloading
- '<' is used to indicate inheretent from class to class
{% highlight ruby %}
class Box
end

class AutoBox < Box
end
{% endhighlight %}
- Method overriding: change existing method (parent class) to new method
(child class)
{% highlight ruby %}
class Box
    def print
	    puts "base class"
    end
end

class AutoBox < Box
    def print
	    puts "child class"
    end
end
{% endhighlight %}
- Method overloading: Unlike java, ruby is using dynamic typed language, as a
results, it's impossible to using overriding if depending on variable types. On
the other hand, it uses number of parameters to differentiate methods.
{% highlight ruby %}
def function_name(a,b) #there is no type declaring, compiler does not know
end                    #how to override

def function_name(a,b) #As a consequence, compiler uses number of parameters to
end                    #differentiate two methods

def function_name(a)
end
{% endhighlight %}

# 8. Loop
**a. While loop**
{% highlight ruby %}
_counter = 0
while _counter < 5
  puts _counter
  _counter++
end
{% endhighlight %}
**b. For loop**
{% highlight ruby %}
  # range is [0-5]
for counter in 0..5
  puts counter
end
  # range is [0-5)
for counter in 0...5
  puts counter
end
{% endhighlight %}

#9. Symbols
**a. What is this**
Symbols in ruby are immutable. Besides this point, it's a `string`. It's able to print put the value of a symbol in term of `string` or `integer`
{% highlight ruby %}
:age #this is a symbol named age
puts :age # print out age's value in string
puts :age.object_id # print out age's object id
{% endhighlight %}
**b. Implementation**
Automatic make new method based on the symbols
{% highlight ruby %}
def make_me_a_setter(thename)
	eval <<-SETTERDONE
	def #{thename}(myarg)
		@#{thename} = myarg
	end
	SETTERDONE
end

class Example
	make_me_a_setter :symboll
	make_me_a_setter "stringg"

	def show_symboll
		puts @symboll
	end

	def show_stringg
		puts @stringg
	end
end

example = Example.new
example.symboll("ITS A SYMBOL")
example.stringg("ITS A STRING")
example.show_symboll
example.show_stringg
  # reference: http://www.troubleshooters.com/codecorn/ruby/symbols.htm
{% endhighlight %}

#10. Hash
**a. Declare a hash**
- Old hash
{% highlight ruby %}
old_hash = {:var1 => "cat", :var2 => "dog"}
{% endhighlight %}
- New hash
{% highlight ruby %}
new_hash = {var1 : "cat", var2 : "dog"}
{% endhighlight %}

**b. Access element**
{% highlight ruby %}
new_hash = {var1 : "cat", var2 : "dog"}
puts new_hash[:var1]
puts new_hash["var1"]
{% endhighlight %}

**c. Documentation [link](http://ruby-doc.org/core-2.2.0/Hash.html)**
