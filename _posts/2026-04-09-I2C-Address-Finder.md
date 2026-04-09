---
layout: post
title: "Tìm kiếm I2C address cho board Arduino"
date: 2026-04-09 16:19:44
update:
location: Saigon
tags:
- arduino
- arduinocli
categories: Arduino
seo_description: Finding I2C address with Arduino
seo_image: /image/posts/2026-04-09-I2C-Address-Finder/seo.jpg
comments: true
---
<video controls>
  <source src="/image/posts/2026-04-09-I2C-Address-Finder/1.webm" type="video/webm">
  Trình duyệt của bạn không hỗ trợ video.
</video>

Tôi không sử dụng `Arduino-IDE` mà sử dụng `arduino-cli` để tạo project (`$ arduino-cli sketch new i2c_address_finder`).
Sau khi tạo xong project, hãy thay đổi nội dung của file `.ino` giống như dưới đây, trước khi copy-paste, hay để tôi giải thích về quy trình:

- Thư viện `Wire` dành cho giao thức với `I2C`. Method `Wire.begin()` dùng để xác lập board arduino chúng
ta đang sử dụng sẽ đóng vai trò là `MAIN`. Các linh kiện sensor, màn hình bên ngoài sẽ đóng vai trò là `SUB`.
- Chúng ta muốn là arduino khi tìm được address `I2C` sẽ in ra trên màn hình monitor cho chúng ta xem. Giai đoạn này sẽ phụ thuộc vào `Serial`
    - `Serial.begin(__baudrate__)`: Xác định truyền tín hiệu với giao thức Serial cùng `baudrate`. Trong code là `9600` (Liên quan đến bước )
    - `Serial.print("__text__")`: In text trên màn hình monitor
- Địa chỉ I2C được miêu tả bởi `7 bit`, có số lượng tối đa là 128 giá trị. Theo như tài liệu, trong số 128 giá trị khả dĩ, sẽ có các địa chỉ đặc
biệt, không được sử dụng cho thiết bị `SUB`. Trong code dưới đây, chúng ta vẫn sẽ quét qua. Và sử dụng hai method sau:
    - `Wire.beginTransmission(__byte_address__)`: Khởi tạo kết nối đến `SUB` với địa chỉ `__byte_address__`
    - `Wire.endTransmission()`: Đóng kết nối, nếu giá trị trả về bằng `0` thì nghĩa là đã kết nối và đóng thành công. Ta tìm được địa chỉ `I2C` hợp lệ.
    - `Serial.println(i, HEX)`: In giá trị address ở dạng hexadecimal


```c++
#include <Wire.h>

void setup() {
  Wire.begin();
  Serial.begin(9600);
  delay(1000);
  Serial.println("Hexalink.xyz");
  Serial.println("Scanning...");
}

void loop() {
  for (byte i = 0; i < 128; i++) {
    Wire.beginTransmission(i);
    if (Wire.endTransmission() == 0) {
      Serial.print("Found at 0x");
      Serial.println(i, HEX);
    }
  }
  delay(2000);
}
```
### Bước 1: Find board & port

```sh
$ arduino-cli board list

Port         Protocol Type              Board Name  FQBN            Core
/dev/ttyACM0 serial   Serial Port (USB) Arduino UNO arduino:avr:uno arduino:avr
```

- Fully Qualified Board Name (FQBN): `arduino:avr:uno`
- Port: `/dev/ttyACM0`

### Bước 2: Compile
```sh
$ arduino-cli compile --fqbn arduino:avr:uno

Sketch uses 3704 bytes (11%) of program storage space. Maximum is 32256 bytes.
Global variables use 428 bytes (20%) of dynamic memory, leaving 1620 bytes for local variables. Maximum is 2048 bytes.
```

### Bước 3: Upload

```sh
$ arduino-cli upload --fqbn arduino:avr:uno --port /dev/ttyACM0

New upload port: /dev/ttyACM0 (serial)
```

### Bước 4: Monitor
```sh
$ arduino-cli monitor -p /dev/ttyACM0 --config  9600

Monitor port settings:
  baudrate=9600
  bits=8
  dtr=on
  parity=none
  rts=on
  stop_bits=1

Connecting to /dev/ttyACM0. Press CTRL-C to exit.
Scat 0x27
Scanning...
Found at 0x27
Found at 0x27
```

Xem trên monitor, địa chỉ I2C `0x27` đã tìm được.
