---
layout: post
title: "How to block suspend/hibernate/sleep on Fedora?"
date: 2025-04-16 16:04:52
update:
location: Saigon
tags:
categories:
- Linux
seo_description: Blocking suspend/hibernate/sleep on Fedora!
seo_image:
comments: true
---

Execute the following command to block Fedora going to suspend/hibernate/sleep mode

## Part 1. Systemd
{% highlight sh %}
systemctl mask sleep.target;
systemctl mask hibernate.target;
systemctl mask sleep.target;
systemctl mask hybrid-sleep.target;
{% endhighlight %}

## Part 2. Gnome Desktop Management
How to find which config to update?
```sh
sudo -u gdm dbus-run-session gsettings list-recursively org.gnome.settings-daemon.plugins.power | grep sleep

org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 900
org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 900
org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
```

Change `sleep-inactive-ac-timeout` & `sleep-inactive-battery-timeout` to `0`

{% highlight sh %}
sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
{% endhighlight %}
