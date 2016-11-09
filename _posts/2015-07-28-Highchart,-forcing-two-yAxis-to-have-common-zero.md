---
layout: post
title: Highchart, forcing dual yAxis to have common zero
date: 2015-07-28 17:02:25
categories: etc
tag: highchart.js 
--- 

Highchart is a common javascript library which use to display graph with many
beautiful features, however, there is a small need in use of highchart.js. It's
about having dual yAxis, and how to balance common zero between two yAxis.  

There is no built-in feature that can help you deal with this solution but
changing the min, max value via setExtremes() method.  

I did write a small method which can help solve this problem, small but
achievable.
[github](https://github.com/nguyenvinhlinh/Highchart-BalanceCommonZero)

## How to use
1. Given that, on the html there is a div which is used for highcharts, this div
is only for rendering graph for example `$("#graph")`
2. After include the balancezero.js, you can test by running the command on the
web console `balanceZeroRoot(dom_element)` or for example `balanceZeroRoot($("#graph"))`
3.  By default, there is exist behavior for `show` and `hide` plots, you need to
modify those default behavior to work with `balancezero.js`. For each kind of
graph, there is exist option name `legendItemClick` for example
[link](http://api.highcharts.com/highcharts#plotOptions.area.events.legendItemClick)
{% highlight javascript %}
plotOptions: { // shared option on plottin the graph
  series: {
    borderColor: '#000000',
    pointStart: Date.parse(data.start_date),
    pointEnd: Date.parse(data.end_date),
    pointInterval: 24 * 3600 * 1000,
    groupPadding: 0, // group for each point on the x-axis
    shadow: false,
    animation: false,
    events: {
      legendItemClick: function(){
        if(this.visible == true){
          this.setVisible(false, false);
        }else {
          this.setVisible(true, false);
        }
        balanceZeroRoot(YOUR_GRAPH_DOM_ELEMENT);
        return false;
        }
    }
  }
}
{% endhighlight %}
- In addition, there is also a need to load `balanceZeroRoot()` right after
data loaded. There are many kind of graph, the code below is an example about
`chart` [type](http://api.highcharts.com/highcharts#chart.events.load)
{% highlight javascript %}
chart: {
  events: {
    load: function (){
      balanceZeroRoot(YOUR_GRAPH_DOM_ELEMENT);
    } 
  }
}
{% endhighlight %}

## Note
- The demand to have common zero for dual yAxis has been there for 2 years
[link](http://stackoverflow.com/questions/16086049/how-can-i-force-multiple-y-axis-in-highcharts-to-have-a-common-zero)
, however there is no good solution which fit for me even the one from the admin
of highcharts, the plugin does not work perfectly.

- Highcharts's admin response:
  [link](http://highcharts.uservoice.com/forums/55896-general/suggestions/2554384-multiple-axis-alignment-control#{toggle_previous_statuses}),
  jsfiddle
  [link](http://jsfiddle.net/gh/get/jquery/1.7.2/highslide-software/highcharts.com/tree/master/samples/highcharts/studies/alignthresholds/)
  





