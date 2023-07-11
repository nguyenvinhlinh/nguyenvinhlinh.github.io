---
layout: post
title: "Emacs, Ruby On Rails Configuration"
date: 2015-05-16 10:30:37 +0700
tags: emacs, rails
categories:
- Ruby on Rails 4
---
### Robe ###
**1. Source: [link](https://github.com/dgutov/robe)**
**2. Features**
- Jump to read the documentation of methods
- Complete the symbol at point, actually, it will show a list of available
method for given character or class

**3. Interactive Function**
 - `M-.` to jump to the definition
 - `M-,` to jump back
 - `C-c C-d` to see the documentation
 - `C-c C-k` to refresh Rails environment
 - `C-M-i` to complete the symbol at point
 - `ruby-load-file` to update ruby file

### Highlight Indentation ###
**1. Source [link](https://github.com/antonj/Highlight-Indentation-for-Emacs/)**
**2. Feature**
- Color the method columns (scope)
- User can differentiate current scope to upper and lower scope
**3. Variables**
{% highlight lisp %}
(set-face-background 'highlight-indentation-face "#808080")
(set-face-background 'highlight-indentation-current-column-face "#e5e5e5")
{% endhighlight %}

**4. Interactive Functions**
- `highlight-indentation-current-column-mode`: current column will be
highlighted only or with particular colors.
- `highlight-indentation-mode`: highlight all columns.


### Ruby-Flymake ###
**1. Source [link](https://github.com/purcell/flymake-ruby)**
**2. Feature**
- checking syntax



### Reference List ####
- Emacs configuration for rails,[link](http://lorefnon.me/2014/02/02/configuring-emacs-for-rails.html)
