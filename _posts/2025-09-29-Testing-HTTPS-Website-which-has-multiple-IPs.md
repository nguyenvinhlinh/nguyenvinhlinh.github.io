---
layout: post
title: "Testing HTTPS Website which has multiple IPs with terminal"
date: 2025-09-29 15:22:32
update:
location: Saigon
tags:
- https
- ssl
categories: SSL
seo_description: Testing HTTPS Website which has multiple IP with terminal
seo_image: /image/posts/2025-09-29-Testing-HTTPS-Website-which-has-multiple-IPs/seo.png
comments: true
---

# I. Problem
- `A Domain` can link to multiple `IP`.
- Web server is behind nginx as a reverse proxy, cannot call `curl` or `wget` directly to IP.
- Due to ISP blacklist, even though DNS does return IP list `ex: nslookup example.com 1.1.1.1` (query IP for domain name
`example.com` using dns server `1.1.1.1`), however, web browser cannot access it.
- Don't want to fetch http body, just header **ONLY**.

# II. Solution
Create a file named `test-https-ip.zsh` (I use z-shell `zsh`). After creating this file, please do `chmod +x` and source it before use.

```sh
#!/bin/zsh
#set -x # Dev only

function test_https_ip() {
    domain_name="$1"
    ip_list_parsing=$(nslookup $domain_name | awk '/^Address: / {print $2}')
    ip_list=(${(f)ip_list_parsing})

    echo "Found IP: $ip_list"
    for ip in $ip_list; do
        curl -H "Host: $domain_name" --resolve $domain_name:443:$ip https://$domain_name  --head --max-time 3 &> /dev/null
        if [ $? -eq 0 ]; then
            echo "Status IP: $ip (OK)"
        else
            echo "Status IP: $ip (ERROR)"
        fi
    done
}

```

**Explaination**:
- `set -x`: for debug, displaying executing command while running
- `awk`: do parsing, extract IP from `nslookup` command
- `${(f)ip_list_parsing}`: convert from nextline string to array list
- `--max-time 3`: total amount of time for a request is 3 seconds (avoid hanging).
- `&> /dev/null`: All info/error output from `curl` will go to `/dev/null`. Help beautifying TUI.

**How to use it**:

```sh
$ test_https_ip example.com
```

<video src="/image/posts/2025-09-29-Testing-HTTPS-Website-which-has-multiple-IPs/1.webm" controls></video>
