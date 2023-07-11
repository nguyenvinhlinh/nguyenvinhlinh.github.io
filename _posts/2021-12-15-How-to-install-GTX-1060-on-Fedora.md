---
layout: post
title: "How to install VGA - GTX 1060 on Fedora with Secure Boot enabled?"
date:   2021-12-15 14:55:51 +0700
update: 2022-04-29 12:00:00 +0700
tags:
- Linux
- VGA
- Driver
- Nvidia
categories:
- Linux
seo_description: Just another tutorial to install Nvidia driver for GTX 1060 on Fedora 34.
seo_image: /image/posts/2021-12-15-How-to-install-GTX-1060-on-Fedora/1.png
comments: true
---

In this post, I would like to introduce solution to install VGA drivers for 1060 on Fedora with enabled `SECURE BOOT`.

## Step 1: Determine vga installed on the motherboard.
On terminal, use the following command to see avaialble installed VGA.
{% highlight bash %}
lspci |grep -E "VGA|3D"
{% endhighlight %}

Example output:

{% highlight sh %}
02:00.0 VGA compatible controller: NVIDIA Corporation GP106 [GeForce GTX 1060 6GB] (rev a1)
04:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 30)
{% endhighlight %}

## Step 2: Download nvidia driver from [Nvidia Official Website](https://www.nvidia.com/Download/Find.aspx?lang=en-us)

{% include image.html url="/image/posts/2021-12-15-How-to-install-GTX-1060-on-Fedora/1.png" description="[1] NVIDIA Driver Downloads" %}

In this post, I would like to pick the latest stable version `510.68.02` which was released on April 26, 2022. After your downloading finished, remember to make the file
executable with `chmod +x NVIDIA-Linux-x86_64-510.68.02.run`, and copy it to `$HOME/Software/VGA-1060-key`, you will need to execute this file each time your update your kernels.

{% highlight sh %}
mkdir -p $HOME/Software/VGA-1060-key;
cd $HOME/Software/VGA-1060-key;
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/470.94/NVIDIA-Linux-x86_64-470.94.run;
chmod +x NVIDIA-Linux-x86_64-470.94.run;
{% endhighlight %}

## Step 3: Generate new pair `private-key` and `public-key`

{% highlight sh %}
mkdir -p $HOME/Software/VGA-1060-key/key;
cd $HOME/Software/VGA-1060-key/key;
openssl req -new -x509 -newkey rsa:2048 -keyout vga-1060.key -outform DER -out vga-1060.der -nodes -days 365000 -subj "/CN=Graphics Drivers";
{% endhighlight %}


Your directory tree should look like:
{% include image.html url="/image/posts/2021-12-15-How-to-install-GTX-1060-on-Fedora/2.png" description="[2] Directory Tree" %}

## Step 4: Enroll new public key with `mokutil`
You need to run this command to import your new public key with `mokutil`, this program will ask you a password for enrolling, which then be asked in the next reboot.
{% highlight sh %}
sudo mokutil --import $HOME/Software/VGA-1060-key/key/vga-1060.der;
{% endhighlight %}

## Step 5: Make `install.sh` in `VGA-1060-key` directory
This is `install.sh` content:
{% highlight sh %}
#!/bin/bash
./NVIDIA-Linux-x86_64-510.68.02.run --module-signing-secret-key=/home/YOUR_USERNAME/Software/VGA-1060-key/key/vga-1060.key \
                                    --module-signing-public-key=/home/YOUR_USERNAME/Software/VGA-1060-key/key/vga-1060.der
{% endhighlight %}

Each time you update your kernel, you need to go boots OS with `level 3` and run this script `install.sh`.

{% include image.html url="/image/posts/2021-12-15-How-to-install-GTX-1060-on-Fedora/3.png" description="[3] Directory Tree" %}

## Step 5: Install package dependencies & update OS
This step ensure you got the lastest kernel & all dependent packages.

```sh
sudo dnf install kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig;
sudo dnf update;
```

## Step 6: Disable `nouveau`
- Create or edit `/etc/modprobe.d/blacklist-nouveau.conf`
{% highlight sh %}
sudo echo "blacklist nouveau" >> /etc/modprobe.d/blacklist-nouveau.conf
{% endhighlight %}

- Edit `/etc/default/grub`
Append following flag to the end of `GRUB_CMDLINE_LINUX`
    - `rd.driver.blacklist=nouveau`
    - `modprobe.blacklist=nouveau`
    - `nvidia-drm.modeset=1`

For example:
{% include image.html url="/image/posts/2021-12-15-How-to-install-GTX-1060-on-Fedora/4.png" description="[4] /etc/default/grub" %}

## Step 7: Update grub2 config & generate new `initramfs`
```sh
grub2-mkconfig -o /boot/grub2/grub.cfg;

## Backup old initramfs nouveau image ##
mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-with-nouveau.img;

## Generate new initramfs image ##
dracut /boot/initramfs-$(uname -r).img $(uname -r);
```


## Step 8: Boots OS on `level 3` and execute the `install.sh`
Boots OS on `level 3` and reboot
{% highlight bash %}
sudo systemctl set-default multi-user.target;
sudo shutdown -r now;
{% endhighlight %}

After login, go to `VGA-1060-key` directory and execute `install.sh`. At this step, just keep accepting and the driver will be installed.

{% highlight sh %}
cd /home/nguyenvinhlinh/Software/VGA-1060-key;
sudo ./install.sh;
{% endhighlight %}

After installing vga driver, you will need reboot OS on `level 5 - graphical`
{% highlight sh %}
systemctl set-default graphical.target;
shutdown -r now;
{% endhighlight %}

Next time, if you update your kernel, you can run this step (`Step 8`) again, it should be fine. In addition, you should encrypt your `private-key` with `gpg`,
it's not a good practice leave it unencrypted. You can check this guide [Mã hóa và giải mã file trên linux sử dụng GPG](/linux/2020/05/09/Ma-hoa-giai-ma-file.html)



## Reference
- Fedora 35/34/33 NVIDIA [495.46 / 470.94 / 390.144 / 340.108] Drivers Install Guide, JR, 2021, December 13, [https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/](https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/)
- How to install nvidia driver with secure boot enabled?, Zanna, 2018, June 25, [https://askubuntu.com/questions/1023036/how-to-install-nvidia-driver-with-secure-boot-enabled](https://askubuntu.com/questions/1023036/how-to-install-nvidia-driver-with-secure-boot-enabled)
