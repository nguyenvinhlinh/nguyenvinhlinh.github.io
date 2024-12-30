---
layout: post
title: "How to install open-webui for llama model on Fedora"
date: 2024-12-30 21:39:33
update:
location: Saigon
tags:
- llm
- llama
categories: LLM
seo_description: A native way to install open-webui for LLAMA models on Fedora OS (no docker)
seo_image: /image/posts/2024-12-30-How-to-install-open-webui-for-llama-model/seo.png
comments: true
---

This guide is about installing [open-webui](https://github.com/open-webui/open-webui) on fedora.

## 1. Update `python` & `pip`
{% highlight shell %}
dnf update python -y
pip install --upgrade pip
{% endhighlight %}

## 2. Install open-webui [guide](https://github.com/open-webui/open-webui?tab=readme-ov-file#how-to-install-)

- Create directory `/opt/open-webui`
{% highlight shell %}
$ mkdir /opt/open-webui
$ cd /opt/open-webui
{% endhighlight %}

- change ownership to your user, do not run with root due to security issue.
{% highlight shell %}
$ chown nguyenvinhlinh:nguyenvinhlinh -Rv /opt/open-webui/
{% endhighlight %}

- Setup virtual environment (`venv`) & install `open-webui` (do not run as root)
{% highlight shell %}
$ python -m venv open-webui-env
$ source open-webui-env/bin/activate
$ pip install open-webui
{% endhighlight %}


## 3. Start open-webui server (do not run as root)
{% highlight shell %}
$ open-webui serve
{% endhighlight %}

- Server should be available on [http://127.0.0.1:8080](http://127.0.0.1:8080)
- All data (sqlite, uploads, cache, db) can be found at `/opt/open-webui/open-webui-env/lib/python3.12/site-packages/open_webui/data`

{% include image.html url="/image/posts/2024-12-30-How-to-install-open-webui-for-llama-model/1.png " description="open-webui on Chrome" %}

## 4. Install `Ollama` software [guide](https://ollama.com/download)
{% highlight shell %}
$ curl -fsSL https://ollama.com/install.sh | sh
$ ollama --version
{% endhighlight %}

## 5. Using `ollama` to pull/download model
{% highlight shell %}
$ ollama pull llama3.2
{% endhighlight %}

## 6. Running with systemd service `/etc/systemd/system/open-webui.service`

{% highlight systemd %}
[Unit]
Description=Open WebUI (LLAMA)
After=network.target

[Service]
WorkingDirectory=/opt/open-webui
ExecStart=/opt/open-webui/open-webui-env/bin/open-webui serve
User=nguyenvinhlinh
RemainAfterExit=yes
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
{% endhighlight %}

Enable and start `open-webui` service
{% highlight shell %}
$ systemctl enable open-webui
$ systemctl start  open-webui
{% endhighlight %}



## References
- Github Open-WebUI, [https://github.com/open-webui/open-webui](https://github.com/open-webui/open-webui)
- Ollama, [https://ollama.com/](https://ollama.com/)
- How to enable a virtualenv in a systemd service unit?, [https://stackoverflow.com/questions/37211115/how-to-enable-a-virtualenv-in-a-systemd-service-unit](https://stackoverflow.com/questions/37211115/how-to-enable-a-virtualenv-in-a-systemd-service-unit)
