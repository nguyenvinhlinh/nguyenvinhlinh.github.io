---
layout: post
title: CSGO, Cách lưu và chạy file config
date: 2020-01-09 00:10:40 +0700
categories: CSGO
tag: csgo
comments: true

---

Đây là hướng dẫn lưu và chạy file config trong game csgo. Dưới đây là ví dụ cụ thể, bạn muốn tập ném smoke,
bạn chắc chắn sẽ phải gõ một đống lệnh mà bạn thậm chí không thể nhớ hết. Bạn không muốn mỗi lần tập ném
smoke lại phải gõ một đống lệnh. Và ngay cả khi có copy/paste, nó cũng quá bất tiện.

Bài hướng dẫn dưới đây giúp bạn khắc phục vấn đề này. Dưới đây là chi tiết cách làm.

1. Vào và tạo file tại thư mục
{% highlight text %}

C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\cfg

{% endhighlight %}


Tôi sẽ tạo file có tên là `smk.cfg`, lưu ý là đuôi file phải là `.cfg`


2. Edit nội dung file và lưu lại

{% highlight text %}
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

bind "ALT" "noclip";
{% endhighlight %}

3. Trong game, vào `console` và chạy lệnh
{% highlight text %}
exec smk
{% endhighlight %}

`smk` chính là tên file config vừa nãy tôi đã tạo.
