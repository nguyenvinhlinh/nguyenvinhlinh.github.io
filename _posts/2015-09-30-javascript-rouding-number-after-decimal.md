---
layout: post
title: JavaScript, rounding number after decimal
date: 2015-09-30 15:37:17 +0700
categories: etc
tag: etc
---

Given that, you have to work with many decimal number for example: 0.335, 0.345,
0.2, 96.6666. And then you want to round those number 2 digits after decimal.
The most general way is to used `toFix()`. However, the behavior of `toFix()` is
not good. Let test with value `0.335` and `0.345`.

{% highlight javascript %}
0.335.toFix(2) --> 0.33, we expected 0.33
0.345.tiFix(2) --> 0.35, we expected 0.34 FAIL!!!
{% endhighlight %}

The better solution is that, we try to use the first two digit after decimal, the only issue is that, these two digit up/down are depend on the third digit, perhaps the fifth one. Number 44 is to solve this issue. Any number `x.a-b-c-d` which has `c-d` >= 56, the `b` will be round up by one.

{% highlight javascript %}
var num = 0.335
var numX10000 = num * 10000;  --> 3350
var Math.floor((numX10000 + 44) / 100) --> 3350 + 44 = 3394, floor of 3394/100 = 33

var num = 0.345
var numX10000 = num * 10000;  --> 3450
var Math.floor((numX10000 + 44) / 100) --> 3450 + 44 = 3494, floor of 3494/100 = 34
{% endhighlight %}

A good solution come up with a compact function which can help you use in any time.
{% highlight javascript %}
function long_round_number(number, digit){
  var multiplier = Math.pow(10, digit + 2);
  var multiple_number = Math.floor(number * multiplier)
  var roundup_number = multiple_number + 44;
  var return_value = Math.floor(roundup_number / 100) / Math.pow(10, digit)
  return return_value;
}

function roundNumber(number, digit){
  var multiplier = Math.pow(10, digit + 2);
  var new_number = Math.floor(multiplier * number) + 44;
  return  Math.floor(new_number / 100) / Math.pow(10, digit);
}
{% endhighlight %}
