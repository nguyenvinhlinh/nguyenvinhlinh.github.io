---
layout: post
title: "Phân tích exec trong shell script"
date: 2022-07-27 02:03:38 +0700
update:
location: Saigon
tags:
- Linux
- Shell script
- Exec
categories: Linux
seo_description: Phân tích exec trong shell script
seo_image: /image/posts/2022-07-27-Phan-tich-exec-trong-shell-script/1.png
comments: true
---
## 1. Giới thiệu `exec`
Trước tiên cần giải thích hành vi của `exec`. Dưới đây là ví dụ của file có tên là `script.sh`. Trong file này, nó sẽ gọi `child_script.sh`

{% highlight bash %}

#!/bin/bash
...
...
...

./child_script.sh

{% endhighlight %}


Giả sử như là `child_script` này chạy khá lâu, lâu đến mức chúng ta có thể mở một terminal khác và rồi liệt kê danh sách những
**process** nào đang chạy. Chúng ta sẽ thấy có **hai process**.

- process dành cho `script.sh`
- process dành cho `child_script.sh`

Phân tích thêm một chút là mặc dù `script.sh`  đã chạy xong phần việc của nó, giờ đây nó kích hoạt `child_script.sh`, phần
code/chức năng lúc này đang được thực thi là năm trong `child_script.sh`. Lưu ý một chút là mặc dù để tên là `child_script.sh`
tuy nhiên đây cũng có thể là một đoạn script ngang cấp với `script.sh`, chỉ đơn giản là script này chạy trước, cái kia chạy sau,
script này gọi script kia.

Khi nhìn nhận ở góc độ này, chúng ta có thể nhận ra rằng việc nhận được danh sách process đang chạy có 2 process dành cho
`script.sh` và `child_script.sh` không phải lúc nào cũng là phương án tốt nhất.

Một cách tiếp cận khác đó là khi `script.sh` đã chạy xong, process dành cho nó sẽ bị khai tử, và khi liệt kê danh sách các
process đang chạy, chúng ta sẽ chỉ thấy process dành cho  `child_script.sh`  mà thôi.

Để làm được điều này, ta sẽ cần sử dụng `exec`. `script.sh` sau khi viết lại và sử dụng `exec` sẽ trông như sau:

{% highlight bash %}

#!/bin/bash
...
...
...

exec ./child_script.sh

{% endhighlight %}

## 2. Khi nào nên sử dụng?

`child_script.sh` là script cuối cùng cần phải kích hoạt sau khi chạy `script.sh`. Không sử dụng `exec` ở giữa file script
trừ trường hợp muốn cắt ngang `script.sh`.

Nếu vô ý sử dụng `exec` ở giữa file script, đoạn code nằm sau `exec` sẽ bị bỏ qua ngay cả khi `child_script.sh` đã xử lý xong.
Lý do là vì ngay khi sử dụng `exec`, process dành cho `script.sh` đã bị khai tử, thành ra, nó không có cơ sở để thực thi những
đoạn code nằm sau.

## 3. Demo

Trong một thư mục bất kỳ hãy tạo nội dung hai file `script.sh` và `child_script.sh` như sau:

`script.sh`

{% highlight bash %}
#!/bin/zsh

echo "this is script.sh"
sleep 1
./child_script.sh
{% endhighlight %}

`child_script.sh`

{% highlight bash%}
#!/bin/zsh

echo "this is child_script.sh"
sleep 20
{% endhighlight %}



Tình huống hiện tại, `exec` không được sử dụng, khi chạy `script.sh` ; Ta sẽ thấy có hai process.
Sử dụng lệnh `ps -a` để xem danh sách process.

- pid: 1 718 953 → `script.sh`
- pid: 1 718 976 → `child_script.sh`

{% include image.html url="/image/posts/2022-07-27-Phan-tich-exec-trong-shell-script/1.png" description="[1] Không sử dụng exec" %}

Và tiếp theo, khi thêm `exec` vào trước `./child_script.sh` trong file `script.sh`, ta sẽ chỉ thấy có một process là:

- pid: 1 718 065 → `child_script.sh`

{% include image.html url="/image/posts/2022-07-27-Phan-tich-exec-trong-shell-script/2.png" description="[2] Sử dụng exec" %}

Bài phân tích này kết thúc ở đây, chúc các bạn tìm được cách tiếp cận hợp lý khi viết script trong từng trường hợp cụ thể.

Cảm ơn đồng nghiệp của tôi là anh Duy đã dành thời gian quý báu của mình để giúp tôi hiểu thêm về exec.
