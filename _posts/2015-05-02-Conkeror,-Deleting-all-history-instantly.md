---
layout: post
title: "Conkeror, Deleting all history instantly"
date: 2015-05-02 20:43:42
tags: Conkeror, history, delete
categories: Conkeror
---
There is a small function you have to write to delete your history instantly. [source](http://retroj.net/git/conkerorrc/history.js)

{% highlight javascript %}
function history_clear () {
    var history = Cc["@mozilla.org/browser/nav-history-service;1"]
        .getService(Ci.nsIBrowserHistory);
    history.removeAllPages();
}
interactive("history-clear",
    "Clear the history.",
    history_clear);
{% endhighlight %}

