---
layout: post
title: "How to install Woodpecker natively on Fedora 41"
date: 2024-12-01 17:38:30
update:
location: Saigon
tags:
categories: Linux
seo_description: Setup Woodpecker CI/CD for my homelab
seo_image:
comments: true
---

Keynotes:

- Fedora 41 installed on VM Workstation
- Disable SELinux
- Enable firewall-cmd
- Woodpecker v2.8.0 - [https://github.com/woodpecker-ci/woodpecker/releases/tag/v2.8.0](https://github.com/woodpecker-ci/woodpecker/releases/tag/v2.8.0)
- SSL enabled

# 1. Download and install
You can use `curl` or `wget` to download from [woodpecker releases](https://github.com/woodpecker-ci/woodpecker/releases). Then use

{% highlight sh %}
$ rpm install file.rpm
{% endhighlight %}

# 2. Systemd - /etc/systemd/system/woodpecker-server.service
{% highlight systemd  %}
[Unit]
Description=Woodpecker Server
After=network.target

[Service]
WorkingDirectory=/opt/woodpecker-server
EnvironmentFile=/opt/woodpecker-server/woodpecker-server.conf
ExecStart=woodpecker-server
User=root
RemainAfterExit=yes
Restart=on-failure
RestartSec=10
TimeoutStopSec=infinity

[Install]
WantedBy=multi-user.target
{% endhighlight %}

# 3. Config - /opt/woodpecker-server/woodpecker-server.conf
I config to use **Gitlab Login - Single Sign On**. Plese check this [link](https://woodpecker-ci.org/docs/administration/forges/github) for more detail.

Github SSO use three variables:
- `WOODPECKER_GITHUB`
- `WOODPECKER_GITHUB_CLIENT`
- `WOODPECKER_GITHUB_SECRET`

{% highlight config %}
WOODPECKER_HOST=https://woodpecker.homelab
WOODPECKER_GITHUB=true
WOODPECKER_GITHUB_CLIENT=XXX
WOODPECKER_GITHUB_SECRET=XXX
WOODPECKER_OPEN=false

WOODPECKER_SERVER_CERT=/opt/woodpecker-server/ssl/woodpecker.homelab.bundle.crt
WOODPECKER_SERVER_KEY=/opt/woodpecker-server/ssl/woodpecker.homelab.key
WOODPECKER_DATABASE_DRIVER=sqlite3
WOODPECKER_DATABASE_DATASOURCE=/opt/woodpecker-server/db/woodpecker.sqlite
{% endhighlight %}

# 4. Firewall-cmd service - /etc/firewalld/services/woodpecker-server.xml

{% highlight xml %}
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>Woodpecker Server</short>
  <description>This option allows woodpecker to use tcp port 443 HTTPS</description>
  <port protocol="tcp" port="443"/>
</service>
{% endhighlight %}

# 5. Test script before using systemd
Write this script and execute it.
{% highlight shell %}
$ export WOODPECKER_HOST=https://woodpecker.homelab

$ export WOODPECKER_GITHUB=true
$ export WOODPECKER_GITHUB_CLIENT=XXX
$ export WOODPECKER_GITHUB_SECRET=XXX

$ export WOODPECKER_OPEN=true

$ export WOODPECKER_SERVER_CERT=/opt/woodpecker/ssl/woodpecker.homelab.bundle.crt
$ export WOODPECKER_SERVER_KEY=/opt/woodpecker/ssl/woodpecker.homelab.key

$ export WOODPECKER_DATABASE_DRIVER=sqlite3
$ export WOODPECKER_DATABASE_DATASOURCE=/opt/woodpecker/db/woodpecker.sqlite
$ export WOODPECKER_LOG_LEVEL=debug

$ woodpecker-server
{% endhighlight %}

For ssl certificate generator, follow this guide [Cách làm Certificate Authority cấp SSL nội bộ]({% post_url 2024-07-14-Cach-lam-Certificate-Authority-cap-SSL %}).
# 6. References
- Woodpecker Server configuration, [https://woodpecker-ci.org/docs/administration/server-config](https://woodpecker-ci.org/docs/administration/server-config)
