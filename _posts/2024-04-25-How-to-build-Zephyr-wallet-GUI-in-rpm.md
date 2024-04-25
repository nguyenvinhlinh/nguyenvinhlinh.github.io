---
layout: post
title: "How to build Zephyr wallet GUI in .rpm package, aka Fedora OS?"
date: 2024-04-25 16:07:31
update:
location: Saigon
tags:
- Zephyr
categories:
- Mining Rig
seo_description: Building rpm package for Zephyr Wallet GUI ealisy on Fedora 39
seo_image: /image/posts/2024-04-25-How-to-build-Zephyr-wallet-GUI-in-rpm/seo.png
comments: true
---

## 1. Clone source code
Go to [https://github.com/ZephyrProtocol/zephyr-wallet](https://github.com/ZephyrProtocol/zephyr-wallet) and do `git clone`

{% highlight shell %}
$ git clone https://github.com/ZephyrProtocol/zephyr-wallet
{% endhighlight %}


## 2. Build zephyr wallet client
Change directory to `zephyr-wallet/client`, install packge dependencies and build

{% highlight shell %}
$ cd zephyr-wallet
$ cd client
$ npm install
$ export NODE_OPTIONS=--openssl-legacy-provider
$ npm run build:desktop
$ npm run copy-build
{% endhighlight %}

## 3. Build zephyr wallet desktop app
Change directory to `zephyr-wallet/zephyr-desktop-app`, install package dependencies.

{% highlight shell %}
$ cd zephyr-wallet/zephyr-desktop-app
$ npm install
{% endhighlight %}

Modify the file named `forge.config.js`  at line 90. Add a new maker named `@electron-forge/maker-rpm`. This config is a must for **Electron Forge** to build `.rpm` file.
For reference, please check [https://www.electronforge.io/config/makers/rpm](https://www.electronforge.io/config/makers/rpm).

{% highlight js %}
{
  name: '@electron-forge/maker-rpm',
  config: {
    options: {
      homepage: 'http://example.com'
    }
  }
}
{% endhighlight %}



Now, it’s time to build rpm file, I do reference from `zephyr-wallet/sh/make.sh`



    $ cd zephyr-wallet/zephyr-desktop-app
    $ export ZEPHYR_DESKTOP_DEVELOPMENT=false
    $ export NODE_INSTALLER=npm
    $ npm run make -- --targets="@electron-forge/maker-rpm"

    > zephyr@1.0.2 make
    > npm run build && electron-forge make --targets=@electron-forge/maker-rpm


    > zephyr@1.0.2 build
    > tsc

    ✔ Checking your system
    ✔ Loading configuration
    ✔ Resolving make targets
      › Making for the following targets: rpm
    ✔ Running package command
      ✔ Preparing to package application
      ✔ Running packaging hooks
        ✔ Running generateAssets hook
        ✔ Running prePackage hook
      ✔ Packaging application
        ✔ Packaging for x64 on linux [11s]
      ✔ Running postPackage hook
    ✔ Running preMake hook
    ✔ Making distributables
      ✔ Making a rpm distributable for linux/x64 [42s]
    ✔ Running postMake hook
      › Artifacts available at: /home/***/Projects/zephyr-wallet/zephyr-desktop-app/out/make

The rpm file should be in `out/make/rpm/x86/`. Done!
{% include image.html url="/image/posts/2024-04-25-How-to-build-Zephyr-wallet-GUI-in-rpm/1.png" description="" %}

For quick testing without rpm install, you can execute `zephyr-wallet/zephyr-desktop-app/out/Zephyr-linux-x64/zephyr`.

For rpm istall, you can run the following command.

{% highlight shell %}
$ cd zephyr-desktop-app/out/make/rpm/x64
$ sudo dnf install zephyr-1.0.2-1.x86_64.rpm
{% endhighlight %}


## 4. Screenshots
{% include image.html url="/image/posts/2024-04-25-How-to-build-Zephyr-wallet-GUI-in-rpm/2.png" description="Zephyr Application Shortcut" %}

{% include image.html url="/image/posts/2024-04-25-How-to-build-Zephyr-wallet-GUI-in-rpm/3.png" description="Zephyr Wallet GUI" %}
