---
layout: post
title: Summary of block, process and lambda in Ruby
date: 2015-08-17 13:36:42
categories: cheatsheet
tag: ruby
--- 

There are three ways to group trunk of code in Ruby which are `block`,
`process` and `lambda`. Each of them behave differently from others. This post
is all about the differences of them and its examples and use cases.

{% highlight text %}
|-------------------------+--------------------+-------------+------------------------|
| Characteristics         | Process            | Block       | Lambda                 |
|-------------------------+--------------------+-------------+------------------------|
| Object                  | yes                | no          | yes                    |
|-------------------------+--------------------+-------------+------------------------|
| Number of arguments*    | many               | 1           | many                   |
|-------------------------+--------------------+-------------+------------------------|
| Checking number of args | no                 | identifying | yes                    |
|-------------------------+--------------------+-------------+------------------------|
| Return behavior         | affect outer scope | identifying | not affect outer scope |
|-------------------------+--------------------+-------------+------------------------|
{% endhighlight %}



## Basic usage
{% highlight ruby %}
 # block
 def test_function(&a)
   a.call
 end
 
 test_function {
   p "it's block"
 }
 # lambda  
 lam = lambda{
   p "it's lambda"
 } 
 lam.call #OR#
 test_function(lam)

 # Process
 pro = Proc.new {
   p "it's proc"
 }
 pro.call #OR#
 test_function(pro)
{% endhighlight %}

## Object or not
- `Block` is not an object, cannot execute directly, it need to be passed to a method 
- `Proc` and `Lambda` are objects, its instance can be execute directly

## Number of block, proc and lambda passed in parameter field
- `Block`: A method can use only one block which passed in the parameter fields.
  Well, obviously, block is a kind of anonymous function. If there are two
  passing in parameter field. How could interpreter understand when should it
  use this or that block. Meanwhile, a method can only use one block or
  `anonymous function` which is passed in parameter field.

- `Proc` and `Lambda`: In fact, these two are identical and it's object
instances. On the other words, you are passing object in parameter field. Hence,
pass them as many as you want.

## Return behaviour
- `Block`: `return` cannot be used within a block. Here is [an article](#) about
  block `break` and `next` behaviours 
- `Lambda`: `return` instruction within a block only suspend instruction execute within
the block. It ***does not suspend*** outer method. 
- `Process`: `return` instruction also affect the outer scope. It ***suspends*** the
outer method directly. 

## Checking number of arguments passing to block, process, lambda
{% highlight text %}
|-------+-------+---------+--------|
|       | Block | Process | Lambda |
|-------+-------+---------+--------|
| check | no    | no      | yes    |
|-------+-------+---------+--------|
{% endhighlight %}

## Reference
- Adam Waxman, [What Is the Difference Between a Block, a Proc, and a Lambda in Ruby?](http://awaxman11.github.io/blog/2013/08/05/what-is-the-difference-between-a-block/)  

- StackOverFlow, [Return behavior in block](http://stackoverflow.com/questions/2325471/using-return-in-a-ruby-block)
