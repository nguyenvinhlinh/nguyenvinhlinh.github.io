---
layout: post
title: "Compressing image directly on Fedora's Nautilus (File Explorer)"
date: 2025-08-15 11:33:17
update:
location: Saigon
tags:
- ffmpeg
- gnome
- nautilus
- zenity
categories: Linux
seo_description: An polished way to compress images backed by ffmpeg, bash and zenity. You can run it directly on nautilus - File explorer
seo_image: /image/posts/2025-08-15-Compressing-image-on-Fedora-with-GUI/seo.png
comments: true
---

## I. What is it?
This post is all about compressing image on Gnome Desktop Environment with GUI. This is core script

```sh
ffmpeg -i "$img" -q:v 4 "$output_dir/$filename"
```

`-q:v 4`: refers to **quality for video**. It's value range is `1-31`, the smaller this value is, the higher the quality.

There are two way to executable the script
- [1] Open `gnome-terminal` and execute script.
- [2] Open `nautilus` (default file explorer on GNOME).

In addition, to enhance user experience, I used `zenity` to display progress bar.

## II. How to do?
- Create a file named `01-compress-images.sh` at `~/.local/share/nautilus/scripts/`

{% highlight sh %}
#!/bin/bash
input_dir="$1"
output_dir="${input_dir}_compressed"
mkdir -p "$output_dir"

shopt -s nullglob
files=("$input_dir"/*.{jpg,jpeg,png,webp})
total=${#files[@]}
count=0

(
for img in "${files[@]}"; do
    [ -f "$img" ] || continue
    filename=$(basename "$img")
    ffmpeg -i "$img" -q:v 4 "$output_dir/$filename" &>/dev/null
    count=$((count+1))
    echo $(( count * 100 / total ))
    echo "# [$count/$total] Compressing: $filename"
done
) | zenity --progress --title="Compress Images" --percentage=0 --auto-close

zenity --info --text="Finished! Compressed images stored at:\n$output_dir"
{% endhighlight %}


- Use `chmod` to make `01-compress-images.sh` executable.

{% highlight sh %}
$ chmod +x 01-compress-images.sh
{% endhighlight %}

## III. Result

<video controls width="600" >
  <source src="/image/posts/2025-08-15-Compressing-image-on-Fedora-with-GUI/1.webm" type="video/webm">
</video>
