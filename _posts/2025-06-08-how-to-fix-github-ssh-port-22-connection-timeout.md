---
layout: post
title: "How to fix ssh: connect to host github.com port 22: Connection timed out"
date: 2025-06-08 23:41:18
update:
location: Saigon
tags:
- git
- linux
- ssh
categories: Linux
seo_description: Sometime, VPN provider (cloudflare's warp vpn) blocks connection with port 22 including github.com. You can switch ssh connection to github at port 443 to work around.
seo_image:
comments: true
---

At first, let make it clear! on May 25th, [vietnamese goverment started blocking telegram](https://vnexpress.net/nha-mang-phai-chan-telegram-tai-viet-nam-4889659.html).

As a consequence, I have to use [CloudFlare WARP](https://developers.cloudflare.com/warp-client/get-started/linux/) to dogde it. It's fine till I have trouble **pushing/cloning** my source code to github. I am pretty sure that CloudFlare did
something as a middle man!

```sh
$ ssh -T git@github.com
# ssh: connect to host github.com port 22: Connection timed out
```

So, there are two choices:
- [1] Turn off cloudflare's warp client
- [2] Change github ssh port from `22` to `443`

This post is all about the second solution. Do ssh to `ssh.github.com port 443` instead of `github.com port 22`.


If you run `ssh -T -p 443 git@ssh.github.com` and it works, you can continue reading this post. Else, this post is not for you cause **ssh.github.com port 443 is also BLOCKED**.
```sh
$ ssh -T -p 443 git@ssh.github.com
# Hi nguyenvinhlinh! You've successfully authenticated, but GitHub does not provide shell access.
```

If you see that message `Hi nguyenvinhlinh! You've successfully authenticated, but GitHub does not provide shell access.` You can alias ssh's config and work around `ssh's port 22, connection timeout error`.

I will make it short! Edit file `~/.ssh/config` with the following config.

```config
Host github.com
Hostname ssh.github.com
Port 443
```

And test it with: `ssh -T git@github.com`. You should see output like:

```text
Hi nguyenvinhlinh! You've successfully authenticated, but GitHub does not provide shell access.
```

Good luck!

# References
- Tamal/git-ssh-error-fix.sh, [https://gist.github.com/Tamal/1cc77f88ef3e900aeae65f0e5e504794](https://gist.github.com/Tamal/1cc77f88ef3e900aeae65f0e5e504794)
- What does ‘ssh: connect to host github.com port 22: Connection timed out’ mean?, [https://hyeny.medium.com/what-does-ssh-connect-to-host-github-com-port-22-connection-timed-out-mean-8cd68a0ea5](https://hyeny.medium.com/what-does-ssh-connect-to-host-github-com-port-22-connection-timed-out-mean-8cd68a0ea5c)
