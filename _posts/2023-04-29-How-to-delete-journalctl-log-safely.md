---
layout: post
title: "How to delete journalctl log safely?"
date: 2023-04-29 00:10:12
update:
location: Saigon
tags:
- Linux
- Journalctl
categories:
- Linux
seo_description: How to delete journalctl log safely?
seo_image:
comments: false
---

First of all, it's important to know how much space has been used for **journalctl log**. There are many method to get
this information, in this post, I would like to introduce two method.
- Disk Usage (`du` command), given that logs stored in `/var/log/journal`. You can use this following command.

{% highlight shell %}
$ du --human-readable --summarize /var/log/journal
3.0G	/var/log/journal

$ du -sh /var/log/journal
3.0G	/var/log/journal
{% endhighlight %}

- Using `journalctl --disk-usage`
{% highlight shell %}
$ journalctl --disk-usage
Archived and active journals take up 2.8G in the file system.
{% endhighlight %}

Now, come back to our main topic - deleting journalctl log safely.
- Delete log data by time, in this example, it only keeo 7-day old data.
{% highlight shell  %}
$ journalctl --vacuum-time=7d
Vacuuming done, freed 0B of archived journals from /run/log/journal.
Vacuuming done, freed 0B of archived journals from /var/log/journal/f5393db751dc400898dc12ef55768680.
Vacuuming done, freed 0B of archived journals from /var/log/journal.
{% endhighlight %}


- Delete log data by disk usage, in the following example, it only keeps data up 1GB. This command uses `G` for Gigabyte,
`M` for Megabyte, `K` for Kilobyte.
{% highlight  shell %}
$ journalctl --vacuum-size=1G
Vacuuming done, freed 0B of archived journals from /var/log/journal.
Vacuuming done, freed 0B of archived journals from /run/log/journal.
Vacuuming done, freed 0B of archived journals from /var/log/journal/f5393db751dc400898dc12ef55768680.
{% endhighlight %}
