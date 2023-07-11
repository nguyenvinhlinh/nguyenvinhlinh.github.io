---
layout: post
title: "How to scan IP by opened PORT?"
date: 2021-04-26 20:41:19 +0700
tags:
- OS
- Linux
- Network
categories: OS
---

Let say there is a host in the network that open a port at `80`. The main question is how to determine the host. Using `nmap` is the best solution.
After you have successfully installed the `nmap`, you can use the following command.

```sh
nmap -sV -p 80 192.168.2.1-255
```
