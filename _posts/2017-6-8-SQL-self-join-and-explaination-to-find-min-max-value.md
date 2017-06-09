---
layout: post
title: SQL self join table and explaination to find min/max values
date: 2017-6-8 12:12:18 +0700
categories: SQL
tag: sql
comments: true
---

## Introduction
It's general and popular to find min/max value of a column in tables with aggregate functions such as `min` and `max`.
However, I would like to use vanila way to solve this problem, in addition to explain how does it work with `join`.
The explaination can help you get a abstract of join and how does it work in processing.
## Issue
To help you understand how `join` can help you approach `min` and `max`, we need a good example. Now let start. We got
 alot of people in a company, each of them has more then one assessment during their work time. The question is how to
 get the `latest, newest` assessment and the `first, oldest` assessment. **The big question is how to get the latest
and the first assessment answers filter by that person and assessment, remember that an assessment can be done many times**. Our table will look like:
{% highlight text %}
table named: assessment_answers;
|-------------+-----------+---------------+--------------------+-------------|
| id          | person_id | assessment_id | assessment_answers | inserted_at |
|-------------+-----------+---------------+--------------------+-------------|
| integer, fk | int       | int           | jsonb              | datetime    |
|-------------+-----------+---------------+--------------------+-------------|
{% endhighlight %}

## Thinking approach
To find min/max value of `inserted_at` value filtered by the `person_id` and `assessment_id`, first we need to find all record filtered by `person_id` and `assessment_id`, then we must find a min/value of `inserted_at` via a loop to comparing one to others `inserted_at` siblings, one which is smaller than others is the smallest and one which is greater than all others is the greatest. This also can be understand in this way.  
1. If you can find a `group named A` from `a fixed set` filtered by some conditions, all elements in this `group A` can find a greater element from `a fix set`. On the other hands, other elements which does not belong to the `group A` cannot find any element which is greater than itself, which also means that those other element are the greatest.   
2. If you can find a `group named B` from `a fixed set` filtered by some conditions, all elemments in this `group B` can find a smaller element from `a fix set`. On the other hands, other elements which does not belong to the `group B` cannot find any element which is smaller than itself, which also mean that those elements are the smallest.  

## Solution
I would like to find the latest/newest assessments of all people. Let do it step by step and analyze:

The over all data set of a person who own id is 1. As you can see, for a single person, there are many assessments has been done by him/her. We have to find out the latest assessment answers of each assessment id. For example: assessment answers with id: 1, 7, 8, 9; the person has finished this assessment_id 2  four times.
{% highlight sql %}
select id, person_id, assessment_id, inserted_at from assessment_answers where person_id = 1;

 id | person_id | assessment_id |       inserted_at
----+-----------+---------------+-------------------------
  1 |         1 |             2 | 2016-12-14 04:04:46.477     x
  2 |         1 |             3 | 2016-12-14 04:07:11.96
  3 |         1 |             8 | 2016-12-14 04:07:12.74
  4 |         1 |             5 | 2016-12-14 04:07:13.177
  5 |         1 |             1 | 2016-12-14 04:07:14.053
  6 |         1 |             7 | 2016-12-14 04:07:14.427
  7 |         1 |             2 | 2016-12-16 01:19:25.61      x
  8 |         1 |             2 | 2017-02-24 22:13:12.79      x
  9 |         1 |             2 | 2017-02-25 09:48:03.53      x
 10 |         1 |             4 | 2017-02-14 00:00:00
 11 |         1 |             4 | 2017-02-22 00:00:00
 12 |         1 |             6 | 2017-02-14 00:00:00
(12 rows)
{% endhighlight %}  
   
Now, let find a group of element which can find a greater one among `the fixed set`. The comparing value based on `inserted_at` column.   

{% highlight sql %}
select aa.id, aa.person_id, aa.assessment_id, aa.inserted_at, ab.id, ab.person_id, ab.assessment_id 
from assessment_answers aa join assessment_answers ab
on aa.person_id = ab.person_id
and aa.assessment_id = ab.assessment_id
and aa.inserted_at < ab.inserted_at        -> I will explain why we set condition here not under _where_ phrase
where aa.person_id = 1
order by aa.id, ab.id;
{% endhighlight %}

{% highlight text %}
 id | person_id | assessment_id |       inserted_at       | id | person_id | assessment_id |      inserted_at       
----+-----------+---------------+-------------------------+----+-----------+---------------+------------------------
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  7 |         1 |             2 | 2016-12-16 01:19:25.61
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  8 |         1 |             2 | 2017-02-24 22:13:12.79
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  9 |         1 |             2 | 2017-02-25 09:48:03.53
  7 |         1 |             2 | 2016-12-16 01:19:25.61  |  8 |         1 |             2 | 2017-02-24 22:13:12.79
  7 |         1 |             2 | 2016-12-16 01:19:25.61  |  9 |         1 |             2 | 2017-02-25 09:48:03.53
  8 |         1 |             2 | 2017-02-24 22:13:12.79  |  9 |         1 |             2 | 2017-02-25 09:48:03.53
 10 |         1 |             4 | 2017-02-14 00:00:00     | 11 |         1 |             4 | 2017-02-22 00:00:00
(7 rows)
{% endhighlight %}  

The fixed set we are talking about is starting from id `1 -> 12`, however, our group contain `1, 7, 8, 10`. `1, 7, 8, 10` can find greater element for instance:
{% highlight text %}
 id | person_id | assessment_id |       inserted_at       | id | person_id | assessment_id |      inserted_at       
----+-----------+---------------+-------------------------+----+-----------+---------------+------------------------
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  7 |         1 |             2 | 2016-12-16 01:19:25.61
{% endhighlight %}

The `inserted_at(id_1)` is smaller than `inserted_at(id_7)`. For those elements which does not belong to this group cannot find greater element, because they are greatest ones. The other elements should include `2, 3, 4, 5, 6, 9, 11, 12`. The previous query used `join` phrase as a consequence, it remove all unsatisfied element for condition `aa.insrted_at < ab.inserted_at`. On the other hands, `left join` takes satisfied and unsatisfied records.

{% highlight sql %}
select aa.id, aa.person_id, aa.assessment_id, aa.inserted_at, ab.id, ab.person_id, ab.assessment_id, ab.inserted_at from assessment_answers aa
left join assessment_answers ab
on aa.person_id = ab.person_id
and aa.assessment_id = ab.assessment_id
and aa.inserted_at < ab.inserted_at
where aa.person_id = 1
order by aa.id, ab.id;
{% endhighlight %}

{% highlight text %}
 id | person_id | assessment_id |       inserted_at       | id | person_id | assessment_id |      inserted_at       
----+-----------+---------------+-------------------------+----+-----------+---------------+------------------------
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  7 |         1 |             2 | 2016-12-16 01:19:25.61
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  8 |         1 |             2 | 2017-02-24 22:13:12.79
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  9 |         1 |             2 | 2017-02-25 09:48:03.53
  2 |         1 |             3 | 2016-12-14 04:07:11.96  |    |           |               | 
  3 |         1 |             8 | 2016-12-14 04:07:12.74  |    |           |               | 
  4 |         1 |             5 | 2016-12-14 04:07:13.177 |    |           |               | 
  5 |         1 |             1 | 2016-12-14 04:07:14.053 |    |           |               | 
  6 |         1 |             7 | 2016-12-14 04:07:14.427 |    |           |               | 
  7 |         1 |             2 | 2016-12-16 01:19:25.61  |  8 |         1 |             2 | 2017-02-24 22:13:12.79
  7 |         1 |             2 | 2016-12-16 01:19:25.61  |  9 |         1 |             2 | 2017-02-25 09:48:03.53
  8 |         1 |             2 | 2017-02-24 22:13:12.79  |  9 |         1 |             2 | 2017-02-25 09:48:03.53
  9 |         1 |             2 | 2017-02-25 09:48:03.53  |    |           |               | 
 10 |         1 |             4 | 2017-02-14 00:00:00     | 11 |         1 |             4 | 2017-02-22 00:00:00
 11 |         1 |             4 | 2017-02-22 00:00:00     |    |           |               | 
 12 |         1 |             6 | 2017-02-14 00:00:00     |    |           |               | 
(15 rows)
{% endhighlight %}

Now let check the id of assessment answers records if the id `2, 3, 4, 5, 6, 7, 9, 11, 12` are the greatest. They cannot find any greater elements.   

Let finalize our works to extract the greatest element only

{% highlight sql %}
select aa.id, aa.person_id, aa.assessment_id, aa.inserted_at, ab.id, ab.person_id, ab.assessment_id, ab.inserted_at from assessment_answers aa
left join assessment_answers ab
on aa.person_id = ab.person_id
and aa.assessment_id = ab.assessment_id
and aa.inserted_at < ab.inserted_at
where aa.person_id = 1
and ab.id is null
order by aa.id, ab.id;
{% endhighlight %}

{% highlight text %}
 id | person_id | assessment_id |       inserted_at       | id | person_id | assessment_id | inserted_at 
----+-----------+---------------+-------------------------+----+-----------+---------------+-------------
  2 |         1 |             3 | 2016-12-14 04:07:11.96  |    |           |               | 
  3 |         1 |             8 | 2016-12-14 04:07:12.74  |    |           |               | 
  4 |         1 |             5 | 2016-12-14 04:07:13.177 |    |           |               | 
  5 |         1 |             1 | 2016-12-14 04:07:14.053 |    |           |               | 
  6 |         1 |             7 | 2016-12-14 04:07:14.427 |    |           |               | 
  9 |         1 |             2 | 2017-02-25 09:48:03.53  |    |           |               | 
 11 |         1 |             4 | 2017-02-22 00:00:00     |    |           |               | 
 12 |         1 |             6 | 2017-02-14 00:00:00     |    |           |               | 
(8 rows)
{% endhighlight %}

And for short, here it's final shot to find the latest/newest assessment answers of user(id: 1)   
{% highlight sql %}
select aa.id, aa.person_id, aa.assessment_id, aa.inserted_at from assessment_answers aa
left join assessment_answers ab
on aa.person_id = ab.person_id
and aa.assessment_id = ab.assessment_id
and aa.inserted_at < ab.inserted_at
where aa.person_id = 1
and ab.id is null
order by aa.id;
{% endhighlight %}

{% highlight text %}
 id | person_id | assessment_id |       inserted_at       
----+-----------+---------------+-------------------------
  2 |         1 |             3 | 2016-12-14 04:07:11.96
  3 |         1 |             8 | 2016-12-14 04:07:12.74
  4 |         1 |             5 | 2016-12-14 04:07:13.177
  5 |         1 |             1 | 2016-12-14 04:07:14.053
  6 |         1 |             7 | 2016-12-14 04:07:14.427
  9 |         1 |             2 | 2017-02-25 09:48:03.53
 11 |         1 |             4 | 2017-02-22 00:00:00
 12 |         1 |             6 | 2017-02-14 00:00:00
(8 rows)
{% endhighlight %}

To find the smallest value, here is your solution:  
{% highlight sql %}
select aa.id, aa.person_id, aa.assessment_id, aa.inserted_at from assessment_answers aa
left join assessment_answers ab
on aa.person_id = ab.person_id
and aa.assessment_id = ab.assessment_id
and aa.inserted_at > ab.inserted_at
where aa.person_id = 1
and ab.id is null
order by aa.id;
{% endhighlight %}

{% highlight text %}
 id | person_id | assessment_id |       inserted_at       
----+-----------+---------------+-------------------------
  1 |         1 |             2 | 2016-12-14 04:04:46.477
  2 |         1 |             3 | 2016-12-14 04:07:11.96
  3 |         1 |             8 | 2016-12-14 04:07:12.74
  4 |         1 |             5 | 2016-12-14 04:07:13.177
  5 |         1 |             1 | 2016-12-14 04:07:14.053
  6 |         1 |             7 | 2016-12-14 04:07:14.427
 10 |         1 |             4 | 2017-02-14 00:00:00
 12 |         1 |             6 | 2017-02-14 00:00:00

{% endhighlight %}

## Quesions
Q: Can we place the condition `aa.inserted_at < ab.inserted_at` under `where` phrase instead of under `lelft join on` phrase, and why?  
A: No, if we put the condition `aa.inserted_at < ab.inserted_at` under the `where` phrase, we can only get `a group of not-greatest elements`
{% highlight sql %}
select aa.id, aa.person_id, aa.assessment_id, aa.inserted_at, ab.id, ab.person_id, ab.assessment_id, ab.inserted_at from assessment_answers aa
left join assessment_answers ab
on aa.person_id = ab.person_id
and aa.assessment_id = ab.assessment_id
where aa.person_id = 1
and aa.inserted_at < ab.inserted_at
order by aa.id, ab.id;  
{% endhighlight %}

{% highlight text %}
 id | person_id | assessment_id |       inserted_at       | id | person_id | assessment_id |      inserted_at       
----+-----------+---------------+-------------------------+----+-----------+---------------+------------------------
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  7 |         1 |             2 | 2016-12-16 01:19:25.61
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  8 |         1 |             2 | 2017-02-24 22:13:12.79
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  9 |         1 |             2 | 2017-02-25 09:48:03.53
  7 |         1 |             2 | 2016-12-16 01:19:25.61  |  8 |         1 |             2 | 2017-02-24 22:13:12.79
  7 |         1 |             2 | 2016-12-16 01:19:25.61  |  9 |         1 |             2 | 2017-02-25 09:48:03.53
  8 |         1 |             2 | 2017-02-24 22:13:12.79  |  9 |         1 |             2 | 2017-02-25 09:48:03.53
 10 |         1 |             4 | 2017-02-14 00:00:00     | 11 |         1 |             4 | 2017-02-22 00:00:00
(7 rows)
{% endhighlight %}

Q: If I use `left join` in this query, why dont I get a combine of satisfied and unsatisfied records:  
A: This is how the query look like and its result set.
{% highlight sql %}
select aa.id, aa.person_id, aa.assessment_id, aa.inserted_at, ab.id, ab.person_id, ab.assessment_id, ab.inserted_at from assessment_answers aa
left join assessment_answers ab
on aa.person_id = ab.person_id
and aa.assessment_id = ab.assessment_id
where aa.person_id = 1
order by aa.id, ab.id;    
{% endhighlight %}

{% highlight text %}
 id | person_id | assessment_id |       inserted_at       | id | person_id | assessment_id |       inserted_at       
----+-----------+---------------+-------------------------+----+-----------+---------------+-------------------------
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  1 |         1 |             2 | 2016-12-14 04:04:46.477
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  7 |         1 |             2 | 2016-12-16 01:19:25.61
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  8 |         1 |             2 | 2017-02-24 22:13:12.79
  1 |         1 |             2 | 2016-12-14 04:04:46.477 |  9 |         1 |             2 | 2017-02-25 09:48:03.53
  2 |         1 |             3 | 2016-12-14 04:07:11.96  |  2 |         1 |             3 | 2016-12-14 04:07:11.96
  3 |         1 |             8 | 2016-12-14 04:07:12.74  |  3 |         1 |             8 | 2016-12-14 04:07:12.74
  4 |         1 |             5 | 2016-12-14 04:07:13.177 |  4 |         1 |             5 | 2016-12-14 04:07:13.177
  5 |         1 |             1 | 2016-12-14 04:07:14.053 |  5 |         1 |             1 | 2016-12-14 04:07:14.053
  6 |         1 |             7 | 2016-12-14 04:07:14.427 |  6 |         1 |             7 | 2016-12-14 04:07:14.427
  7 |         1 |             2 | 2016-12-16 01:19:25.61  |  1 |         1 |             2 | 2016-12-14 04:04:46.477
  7 |         1 |             2 | 2016-12-16 01:19:25.61  |  7 |         1 |             2 | 2016-12-16 01:19:25.61
  7 |         1 |             2 | 2016-12-16 01:19:25.61  |  8 |         1 |             2 | 2017-02-24 22:13:12.79
  7 |         1 |             2 | 2016-12-16 01:19:25.61  |  9 |         1 |             2 | 2017-02-25 09:48:03.53
  8 |         1 |             2 | 2017-02-24 22:13:12.79  |  1 |         1 |             2 | 2016-12-14 04:04:46.477
  8 |         1 |             2 | 2017-02-24 22:13:12.79  |  7 |         1 |             2 | 2016-12-16 01:19:25.61
  8 |         1 |             2 | 2017-02-24 22:13:12.79  |  8 |         1 |             2 | 2017-02-24 22:13:12.79
  8 |         1 |             2 | 2017-02-24 22:13:12.79  |  9 |         1 |             2 | 2017-02-25 09:48:03.53
  9 |         1 |             2 | 2017-02-25 09:48:03.53  |  1 |         1 |             2 | 2016-12-14 04:04:46.477
  9 |         1 |             2 | 2017-02-25 09:48:03.53  |  7 |         1 |             2 | 2016-12-16 01:19:25.61
  9 |         1 |             2 | 2017-02-25 09:48:03.53  |  8 |         1 |             2 | 2017-02-24 22:13:12.79
  9 |         1 |             2 | 2017-02-25 09:48:03.53  |  9 |         1 |             2 | 2017-02-25 09:48:03.53
 10 |         1 |             4 | 2017-02-14 00:00:00     | 10 |         1 |             4 | 2017-02-14 00:00:00
 10 |         1 |             4 | 2017-02-14 00:00:00     | 11 |         1 |             4 | 2017-02-22 00:00:00
 11 |         1 |             4 | 2017-02-22 00:00:00     | 10 |         1 |             4 | 2017-02-14 00:00:00
 11 |         1 |             4 | 2017-02-22 00:00:00     | 11 |         1 |             4 | 2017-02-22 00:00:00
 12 |         1 |             6 | 2017-02-14 00:00:00     | 12 |         1 |             6 | 2017-02-14 00:00:00
(26 rows)
{% endhighlight %}

The condition I am talking here is `aa.person_id = ab.person_id` and `aa.assessment_id = ab.assessment_id`  
* Satisfied condition is `aa.person_id == ab.person_id` and `aa.assessment_id == ab.assessment_id`  
* Unsatisfied condition is `aa.person_id != ab.person_id` or `aa.assessment_id != ab.assessment_id`  
Why the record that are not satisfied exist in the result set. Hmm, that's a question I am think about. Personally, I think the developers of postgres did make an exception, hardcode perhap if people use `equal` in the `join` expression. 
