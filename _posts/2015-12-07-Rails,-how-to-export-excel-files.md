---
layout: post
title: Rails, how to export excel files
date: 2015-12-07 18:10:53 +0700
categories:
- Ruby on Rails 4
tag:
- ruby
- rails4
---

On the front-end, instead of using Ajax(post, get). I uses `window.location`
{% highlight javascript %}
$("#export-quote-button").click(function(){
  var encoded = $.param(getQuoteParams(), true);
  var url = "/quotes/tran_stats/export_search_result?" + encoded;
  window.location = url;
});
{% endhighlight %}

On the back-end, I uses a gem named `spreadsheet`
{% highlight ruby %}
def export_search_result
    require 'spreadsheet'
    require 'stringio'
    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet
    #YOUR DATA PROCESSOR HERE
    file_name = "abc.xls"
    spreadsheet = StringIO.new
    book.write spreadsheet
    send_data(spreadsheet.string, :filename => file_name,
              :type => "application/vnd.ms-excel")
end
{% endhighlight %}
