---
layout: post
title: "Git - cheatsheet"
date: 2014-12-05 12:24:00 +0700
categories: cheatsheet
tag: git
---
### 1. Untrack an already check-in directory or file ###
{%highlight bash%}
git rm -r --cached folder_name
{% endhighlight %}
-r : recursive
--cached: files or directories are only deleted on the git's index, not on local
storage.

### 2. See all submodules ###
{%highlight bash%}
cat .gitmodules
{%endhighlight%}

### 3. Add a submodule ###
{%highlight bash%}
git submodule add url_of_submodule
{%endhighlight%}


### 4. Initialize all submodules ###
{%highlight bash%}
git submodule init
{%endhighlight%}

### 5. Reset stage to the last commit ###
{%highlight bash%}
git reset --hard HEAD
{%endhighlight%}

### 6.Clone repository with a particular folder name  ###
{% highlight bash %}
git clone git@github.com:whatever folder-name
{% endhighlight %}
