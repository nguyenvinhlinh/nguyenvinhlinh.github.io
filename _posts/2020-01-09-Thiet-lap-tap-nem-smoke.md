---
layout: post
title: CSGO, Thiết lập để tập ném smoke
date: 2020-01-09 00:10:40 +0700
categories: CSGO
tag: csgo
comments: true
---
{% highlight sh %}
sv_cheats 1;
sv_infinite_ammo 1;
ammo_grenade_limit_total 5;
mp_warmup_end;
mp_freezetime 0;
mp_roundtime 60;
mp_roundtime_defuse 60;
sv_grenade_trajectory 1;
sv_grenade_trajectory_time 10;
sv_showimpacts 1;
mp_limitteams 0;
mp_autoteambalance 0;
mp_maxmoney 60000;
mp_startmoney 60000;
mp_buytime 9999;
mp_buy_anywhere 1;
mp_restartgame 1;
bot_kick;
bot_stop;

bind "ALT" "noclip";
bind "i" "bot_place";
{% endhighlight %}
