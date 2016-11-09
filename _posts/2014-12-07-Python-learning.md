---
layout: post
title: "Python - learning"
date: 2014-12-07 15:55:37
categories: cheatsheet
tags: python
---
This is a remember note to learn python, more or less, it's writen for me -the author to rememeber main issues of python.

## 1. Scope and Namespace
{% highlight python %}
def scope_test():
    def do_local():
        spam = "local spam"
    def do_nonlocal():
        nonlocal spam
        spam = "nonlocal spam"
    def do_global():
        global spam
        spam = "global spam"
    spam = "test spam"
    do_local()
    print("After local assignment:", spam)
    do_nonlocal()
    print("After nonlocal assignment:", spam)
    do_global()
    print("After global assignment:", spam)
scope_test()
print("In global scope:", spam)
{% endhighlight %}

The output is:
{%highlight text%}
After local assignment: test spam  
After nonlocal assignment: nonlocal spam  
After global assignment: nonlocal spam  
In global scope: global spam
{%endhighlight%}

Explaination:   
1. Local variable always is always used inside local scope. In the example, local variable
`spam` has value is `local spam`, when do_local() invoked, `spam` only created inside a
function, it has no use outside.  
2. Non local variable has been declared and it affect within `scope_test` and only within `scope_test`.  
3. Global variable only used in global scope.  
4. In Python, a function can exist inside a function, in the example above,  `do_local` insides `scope_test`.  
5. Functions make its own scope.

##2. Class 
{%highlight python%}
class Dog:

    kind = 'canine'         # class variable shared by all instances
    def __init__(self, name):
        self.name = name    # instance variable unique to each instance
>>> d = Dog('Fido')
>>> e = Dog('Buddy')
>>> d.kind                  # shared by all dogs
'canine'
>>> e.kind                  # shared by all dogs
'canine'
>>> d.name                  # unique to d
'Fido'
>>> e.name                  # unique to e
'Buddy'
{%endhighlight%}
Notes:  
1. Class variables shared by all instances, `kind` is class variable.  
2. Instance variables shared by each instance,`name` is instance variable.  
3. Function can be define outside class.
{%highlight python%}
# Function defined outside the class
def f1(self, x, y):
    return min(x, x+y)

class C:
    f = f1
    def g(self):
        return 'hello world'
    h = g

{%endhighlight%}

## 3. Inheritence
{%highlight python %}
class DerivedClassName(BaseClassName):
    <statement-1>
    .
    .
    .
    <statement-N>

class DerivedClassName(modname.BaseClassName):
    <statement-1>
    .
    .
    .
    <statement-N>
{% endhighlight %}
Call baseclass method, base class must be in global scope:
{%highlight python%}
BaseClassName.methodname(self, arguments)
{%endhighlight%}

Check instance type:  
{%highlight python%}
isinstance(obj, int) #check if `obj` is instance of `int`
issubclass(bool, int) #check if `bool` is subclass of `int`
{%endhighlight%}

