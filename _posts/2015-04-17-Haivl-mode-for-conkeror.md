---
layout: post
title: Haivl mode for Conkeror
date: 2015-04-17 00:00:00 +0700
categories: Projects
tag: Conkeror, haivl, page-mode
---
This project is a project for hackday in Cogini company in 2014
**1. Identify the page mode**
{% highlight javascript %}
define_keymaps_page_mode("haivl_mode",
       build_url_regexp($domain="haivainoi",
					    $allow_www = true,
					    $tlds = ["com", "tv"]),
       {normal: haivl_keymap},
       $display_name = "haivl");
{% endhighlight %}

**2. Declare css selector, relative variables**
{% highlight javascript %}
var haivl = {};
haivl.selector = {};
haivl.selector.nav = ".top-menu.left>ul>li>a"
haivl.selector.seemore = ".button-readmore>a"
haivl.name = ["New", "Unread", "Vote","Video","Hot", "SeeMore"];
{% endhighlight %}

**3. Declare function to make a `click` action to DOM node**
{% highlight javascript %}
haivl.doClick = function(I, index ){
  var document = I.buffer.document;
  var button_array = document.querySelectorAll(haivl.selector.nav);
  if(button_array[index] != null){
	dom_node_click(button_array[index]);
  }else {
 	I.minibuffer.message("Button: " + haivl.name[index] + " not found." + "length: "+ button_array.length);
  }
  I.minibuffer.message(I);
}
haivl.doClickSeeMore = function(I){
  var document = I.buffer.document;
  var button = document.querySelector(haivl.selector.seemore);

  if(button != null){
	dom_node_click(button);
  }else {
 	I.minibuffer.message("Button: " + haivl.name[5] + " not found.");
  }
}
{% endhighlight %}
**4. Make those function become interactive**
{% highlight javascript %}
interactive("haivl-1","new feeds", function(I){
  haivl.doClick(I, 0);
});
interactive("haivl-2", "unread feeds",function(I){
  haivl.doClick(I,1);
});
interactive("haivl-3", "vote feeds", function(I){
  haivl.doClick(I,2);
});
interactive("haivl-4", "video feeds", function(I){
  haivl.doClick(I,3);
});
interactive("haivl-5", "hot feeds", function(I){
  haivl.doClick(I,4);
});
interactive("haivl-seemore", "see more feeds",function(I){
  haivl.doClickSeeMore(I);
})

{% endhighlight %}

**5. Reference**
I must say thank to Tran Xuan Truong, Quan Bao Thien To. When I write this bunch
of code I don't know much about javascript. In addition, regarding Conkeror
technical issues, I gained help from Tran Xuan Truong who is a master in Conkeror
Web browser and he is one who has a big love in programming. Thank you, I will
remember the hackday.

Right now, It's April 14, 2015. I note this memory to remember a day of doing new
things, learning new things and of course, because it's a memorial hackday.
Even though, currently, the [haivl.com](haivl.com) has been collapsed,but this project still
work with [haivainoi.com](haivainoi.com)
