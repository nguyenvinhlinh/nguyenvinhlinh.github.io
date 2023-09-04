---
layout: post
title: "How to compile xmrig on Fedora?"
date: 2023-09-02 11:43:55
update:
location: Saigon
tags:
- monero
- xmrig
categories:
- Mining Rig
seo_description:
seo_image: /image/posts/2023-09-02-How-to-compile-xmrig-on-fedora/1.png
comments: true
---
This is a repost from [https://xmrig.com/docs/miner/build/fedora](https://xmrig.com/docs/miner/build/fedora) which then I can save my time searching in future.

# I. Basic build
Basic build is good for local machine, because it is easy, but if you need to run the miner on other machines please take a look at advanced build.
{% highlight sh %}
$ sudo dnf install -y git make cmake gcc gcc-c++ libstdc++-static libuv-static hwloc-devel openssl-devel
$ git clone https://github.com/xmrig/xmrig.git
$ mkdir xmrig/build && cd xmrig/build
$ cmake ..
$ make -j$(nproc)
{% endhighlight %}


# II. Advanced build
We use `build_deps.sh` script to build recent versions of `libuv`, `openssl` and `hwloc` as static libraries.

{% highlight sh %}
$ sudo dnf install -y git make cmake gcc gcc-c++ libstdc++-static automake libtool autoconf
$ git clone https://github.com/xmrig/xmrig.git
$ mkdir xmrig/build
$ cd xmrig/scripts && ./build_deps.sh && cd ../build
$ cmake .. -DXMRIG_DEPS=scripts/deps
$ make -j$(nproc)
{% endhighlight %}

Use command `ldd xmrig` to verify binary dependencies.

# III. Reference
- XMRig build fedora, [https://xmrig.com/docs/miner/build/fedora](https://xmrig.com/docs/miner/build/fedora)
