---
layout: post
title: "SELinux, cannot login to shell after enable it "
date: 2024-11-29 23:48:07
update:
location: Saigon
tags:
categories: Linux
seo_description: Enable SELinux after along time disabled causes login issue.
seo_image: /image/posts/2024-11-29-cannot-login-to-shell-after-enable-SELinux/seo.png
comments: true
---
After along time disable `SELinux`, now you might want to enable it in `Enforcing` mode. After OS boot, in terminal,
you may not login even though you did enter correct username/password. It's because your files not to be labeled or
labeled with `SELinux context` not matching the install policy.

The solution is that you ask `SELinux` to re-label in the next reboot. Enter the following command.

{% highlight sh %}
$ touch /.autorelabel
{% endhighlight %}

Then reboot!

In case you forget to do it. you need to go to rescue mode while booting the system, the `GRUB2` menu will be displayed.
To boot the system into rescue mode using bash follow these steps:

- Select the boot entry you wish to edit with the arrow keys.
- Select the entry you wish to edit by pressing `e`.
- Use the arrow keys to go to select the line beginning with `linux, linux16, or linuxefi`.
- Go the the end of that line and include a space and the following `rw init=/bin/bash`.
  If your disk is encrypted, you may need to add `plymouth.enable=0`
- Press `Ctrl-x` or `F10` to boot the entry
- Then enter command line `touch /.autorelabel` and reboot!

Good luck!

Refereces:
- Again enabled SELINUX and now the user logins wont work in enforcing mode, [https://serverfault.com/questions/1033769/again-enabled-selinux-and-now-the-user-logins-wont-work-in-enforcing-mode](https://serverfault.com/questions/1033769/again-enabled-selinux-and-now-the-user-logins-wont-work-in-enforcing-mode)
- How to reset the root password in Rescue Mode, [https://docs.fedoraproject.org/en-US/quick-docs/reset-root-password/](https://docs.fedoraproject.org/en-US/quick-docs/reset-root-password/)
