---
layout: post
title: "Tạo thumbnail vuông cho ảnh với ffmpeg"
date: 2025-11-29 10:08:28
update:
location: Saigon
tags:
- ffmpeg
categories: etc
seo_description:
seo_image: /image/posts/2025-11-29-Tao-thumbnail-vuong-cho-anh-voi-ffmpeg/seo.png
comments: true
---

<video src="/image/posts/2025-11-29-Tao-thumbnail-vuong-cho-anh-voi-ffmpeg/4.webm" controls></video>

## 1. Giới thiệu
Xin chào, trước tiên tôi sẽ tóm tắt lại yêu cầu tạo thumbnail từ ảnh
- Cho ảnh với bất kỳ tỷ lệ kích thước
- Tạo thumbnail mà trọng tâm trùng với trọng tâm của tấm ảnh gốc.
- Thumbnail có kích thước cố định 250x250px

{% include image.html url="/image/posts/2025-11-29-Tao-thumbnail-vuong-cho-anh-voi-ffmpeg/1.png" description="[1] Ảnh ngang" %}

{% include image.html url="/image/posts/2025-11-29-Tao-thumbnail-vuong-cho-anh-voi-ffmpeg/2.png" description="[2] Ảnh dọc" %}

## 2. Tóm tắt
Để tiết kiệm kiệm thời gian, Đây là command. Lưu ý thay đổi tên file

```sh
$ ffmpeg -i input_image.png \
    -vf "crop=min(in_w\,in_h):min(in_w\,in_h):(in_w-min(in_w\,in_h))/2:(in_h-min(in_w\,in_h))/2,scale=250:250" \
    -y -loglevel quiet output_image.png
```

## 3. Giải thích

- `-i input_image.png`: file ảnh gốc
- `-vf`: video filter
- `-y`: Cho phép ghi đè file nếu đã tồn tại.
- `-loglevel quiet`: Không xuất log, xóa cái này nếu cần debug.

Phần thú vị nhất ở đây là video filter, ở command trên dùng 2 filters‌/bộ lọc:
- **Crop/Cắt gọt** hình ảnh
- **Scale‌/Thu nhỏ** hình ảnh

### 3.1 **Crop/Cắt gọt** hình ảnh
**Crop** nhận 4 tham số thứ tự như sau: `chiều rộng kỳ vọng`, `chiều dài kỳ vọng`, `điểm x bắt đầu`, `điểm y bắt đầu`
Bên cạnh đó, `ffmpeg` con cho phép sử dụng function `min/max` với tham số `in_w/in_h`.
- `min(in_w,in_h)`: Lấy giá trị nhỏ nhất trong 2 giá trị chiều rộng và chiều cao. Lưu ý, thumbnail hình vuông, nên
`chiều rộng và dài kỳ vọng` chính là cạnh nhỏ nhất.
- `(in_w-min(in_w,in_h))/2`: Điểm x bắt đầu, chúng ta chia 2 vì muốn căn ngay giữa.
- `(in_h-min(in_w,in_h))/2`: Điểm y bắt đầu, chúng ta chia 2 vì muốn căn ngay giữa.

{% include image.html url="/image/posts/2025-11-29-Tao-thumbnail-vuong-cho-anh-voi-ffmpeg/3.png" description="[3] Sơ đồ" %}

### 3.2 **Scale‌/Thu nhỏ** hình ảnh
**Scale** nhận 2 tham số `chiều rộng kỳ vọng`, `chiều dài kỳ vọng`. Trong trường hợp này, ta muốn thumbnail kích cỡ là `250x250px`.


## 4. Sử dụng ngôn ngữ elixir để gọi ffmpeg
```elixir
def run_ffmpeg_command_250x250px(image_directory, in_image_file_name, out_image_file_name) do
    in_file_path =  Path.join([image_directory, in_image_file_name])
    out_file_path = Path.join([image_directory, out_image_file_name])

    cmd_arg_list = ["-i", in_file_path, "-vf", "crop=min(in_w\\,in_h):min(in_w\\,in_h):(in_w-min(in_w\\,in_h))/2:(in_h-min(in_w\\,in_h))/2,scale=250\:250",
                    "-y", "-loglevel", "quiet", out_file_path]

    cmd_output = System.cmd("ffmpeg", cmd_arg_list)

    case cmd_output do
      {_, 0} -> :ok
      _else -> {:error, :run_ffmpeg_command_250x250px}
    end
end
```

## 5. Sử dụng nautilus script để gọi ffmpeg
Lưu file tại: `.local/share/nautilus/scripts/03-ffmpeg-create-thumbnail-500px-for-files.zsh`. Để sử dụng, mở **File Explorer - Nautilus** chọn một hoặc
nhiều ảnh cần tạo thumbnail, chọn `Scripts`, chọn `03-ffmpeg-create-thumbnail-500px-for-files.zsh`.

```zsh
#!/bin/zsh
setopt EXTENDED_GLOB

function is_file_valid() {
    file_path=$1
    file_path_extension=${file_path:e}
    typeset -a allowed_file_extension_list=(png jpg)
    pattern_allowed_file_extension_list="(${(j:|:)allowed_file_extension_list})"

    if [[ $file_path_extension == ${~pattern_allowed_file_extension_list} ]]; then
        return 0
    else
        return 1
    fi
}

function create_thumbnail_file_path(){
    input_image_file_path=$1
    input_image_file_extension=${input_image_file_path:e}
    input_image_file_path_directory=${input_image_file_path:h}
    input_image_file_name=${input_image_file_path:t:r}
    print "${input_image_file_path_directory}/${input_image_file_name}_500x500.${input_image_file_extension}"
}

function ffmpeg_command() {
    input_image_file_path=$1
    output_image_file_path=$2

    ffmpeg -i $input_image_file_path \
           -vf "crop=min(in_w\,in_h):min(in_w\,in_h):(in_w-min(in_w\,in_h))/2:(in_h-min(in_w\,in_h))/2,scale=500:500" \
           -y -loglevel quiet $output_image_file_path
}

typeset -a selected_file_path_array
selected_file_path_array=(${(f)NAUTILUS_SCRIPT_SELECTED_FILE_PATHS})
for image_file_path in $selected_file_path_array; do
    if is_file_valid $image_file_path; then
        thumbnail_file_path=$(create_thumbnail_file_path $image_file_path)
        ffmpeg_command $image_file_path $thumbnail_file_path
    fi
done
```

## 5. Reference
- ffmpeg(1) - Linux man page, https://linux.die.net/man/1/ffmpeg

## 6. Lời cảm ơn
Cảm ơn chatgpt đã hỗ trợ tôi hiểu thêm về ffmpeg. Thực sự `ffmpeg` nó là một bộ công cụ không hề đơn giảnm Không có
chatgpt tôi thậm chí không biết là ffmpeg có hỗ trợ `in_w`, `in_h`, với function `min/max`, Việc tạo ra thumbnail
đã có thể phức tạp hơn rất rất là nhiều.
