---
layout: post
title: "Fedora, Change directory quickly with autojump"
date: 2025-06-13 12:56:35
update:
location: Saigon
tags:
- autojump
- rpm
- fedora
categories: Linux
seo_description: Setup autojump for Fedora in easy mode
seo_image: /image/posts/2025-06-13-Fedora-change-directory-quickly-with-autojump/seo.png
comments: true
---

## Why do I create this post?
Damn man, I really expected that after install `dnf install autojump-zsh`, everything should run without any modification, I can start using `j`
command. But no, command `j` not found. This post is all about installing `autojump` on Fedora.

Each user has their favorite shell, I am using `zsh`. this guide is all about setup `autojump` on `zsh`. The methodology is the same for `fish` or `bash`.

## How to install
### Step 1: Install `dnf install autojump-zsh -y`

```shell
$ sudo dnf install autojump-zsh -y
# Output
Updating and loading repositories:
Repositories loaded.
Package                                  Arch              Version           Repository        Size
Installing:
 autojump-zsh                            noarch            22.5.3-17.fc41    fedora         2.8 KiB
Installing dependencies:
 autojump                                noarch            22.5.3-17.fc41    fedora        93.2 KiB

Transaction Summary:
 Installing:         2 packages

Complete!

```
### Step 2: Find installed file location `rpm -ql autojump-zsh`
```shell
$ rpm -ql autojump-zsh
# Output
/usr/share/autojump/autojump.zsh
/usr/share/zsh/site-functions/_j
```
### Step 3: Load `autojump.zsh` when start terminal
I am using `zsh`, it means that I need modify `~/.zshrc` and append `source /usr/share/autojump/autojump.zsh`.

It will load `autojump.zsh` when terminal start.

```shell
# File ~/.zshrc

source /usr/share/autojump/autojump.zsh
```

Good luck, have fun!
