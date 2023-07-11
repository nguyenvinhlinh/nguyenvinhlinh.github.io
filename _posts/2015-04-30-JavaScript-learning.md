---
layout: post
title: JavaScript learning
date: 2015-04-30 +0700
categories: cheatsheet
tag: JavaScript
---
# 1. Function and Variable
**a. Declare function**
{% highlight javascript %}
var function_name = function(){
//Do something here
}
{% endhighlight %}
**b. Declare variable**
{% highlight javascript %}
var variable_name = 123;
{% endhighlight %}
**c. Reuse method**
{% highlight javascript %}
var function_namedA = function(){
    this.age = 123;
    Console.log(this.age);
}
var Bob = {
    age = 12;
}
Bob.function_namedA();
//The age of Bob changed from 12 to 123
{% endhighlight %}
#2. Object
**a. Make an object**
{% highlight javascript %}
// type 1
var object_name = {
	variable_name1 = 123;
    variable_name2 = 123;
}
// type 2
object  = new Object();
object.variable_name1 = 123;
{% endhighlight %}
**b. Make constructor of an object**
{% highlight javascript %}
function Person(job, age){
    this.job = job;
    this.age = age;
}
{% endhighlight %}

**c. Use constructor of an object**
{% highlight javascript %}
var Bob = new Person('engineer', 23);
{% endhighlight %}
**d. Use variables of an object**
{% highlight javascript %}
//type 1
var a = object[var_name]
//type 2
var a = object.var_name
{% endhighlight %}
**e. Private and public variables and function**
- `private variables` are declared with the `var` keyword inside the object, and
  can only be accessed by private functions and privileged methods.
- `private functions` are declared inline inside the object's constructor (or
	alternatively may be defined via var `functionName=function(){...})` and may
	only be called by privileged methods (including the object's constructor).
- `privileged methods` are declared with `this.methodName=function(){...}` and
	may invoked by code external to the object.
- `public properties` are declared with `this.variableName` and may be
	read/written from outside the object.
- `public methods` are defined by `Classname.prototype.methodName =
	function(){...}` and may be called from outside the object.
- `prototype properties` are defined by `Classname.prototype.propertyName = someValue`
- `static properties` are defined by `Classname.propertyName = someValue`

{% highlight javascript %}
var Person = function(job, age){
    //job and age are public variables
    this.job = job;
    this.age = age;
	//sex is private variable
	var sex = 'male';
	//printJob() is a public function
    this.printJob(){
	    Console.log(this.job);
	}
	//sayHello() is private function
	var sayHello = function(){
	    Console.log('Hello');
	}
}
Person.variable = 123; //variable is pointing to object named Person
Person.prototype.variable = 345; //variable is pointing to the function of object named Person
{% endhighlight %}
#3. Inheritance
**a.Inheritance object**
{% highlight javascript %}
var a = {a: 1};
// a ---> Object.prototype ---> null

var b = Object.create(a);
// b ---> a ---> Object.prototype ---> null
console.log(b.a); // 1 (inherited)

var c = Object.create(b);
// c ---> b ---> a ---> Object.prototype ---> null

var d = Object.create(null);
// d ---> null
console.log(d.hasOwnProperty);
// undefined, because d doesn't inherit from Object.prototype
{% endhighlight %}
#4. Notes
- Keyword `this`, within a function, this refers to object which call the
function.
