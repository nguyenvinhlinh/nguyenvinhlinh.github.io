---
layout: post
title: "Hướng dẫn cách update firmware cho Ender-3 Pro"
date: 2023-05-20 11:48:45 +0700
update:
location: Saigon
tags:
- Ender-3 Pro
categories:
- 3D Print
seo_description:
seo_image: /image/posts/2023-05-20-Huong-dan-cach-update-firmware-cho-Ender-3-Pro/seo.jpeg
comments: true
---

Trong bài hướng dẫn này, chúng ta sẽ tìm cách nâng cấp firmware cho máy in 3D **Creality Ender-3 Pro**. Trước khi đi vào chi tiết, đây là thông số máy in 3D của tôi trước khi nâng cấp.

- CPU: ATMEGA1284P
- Motherboard: Creality3D V1.1.4
- Version: Melzi 1.1.6.2

Cá nhân tôi khi bắt đầu mò mẫm cài đặt firmware mới, tôi cảm giác mình đang đi vào một cái lỗ thỏ. Đây là những phần việc chính mà chúng ta sẽ làm

- Cài đặt bootloader cho Creality Ender-3 Pro
- Cài đặt firmware Marlin cho Creality Ender-3 Pro

Đây là cách các phần cứng nối với nhau.

# I. Cài đặt bootloader cho Creality Ender-3 Pro
Ở bước này, tôi sẽ dụng Arduino UNO như một công cụ trung gian để rồi cài đặt bootloader cho máy in 3D.

Để tránh nhầm lẫn, chỉ cắm `Arduino UNO` vào máy tính, chúng ta chưa kết nối thứ gì vào máy in 3D.
{% include image.html url="/image/posts/2023-05-20-Huong-dan-cach-update-firmware-cho-Ender-3-Pro/1.png" description="[1] Hardware Links" %}

Sau khi cắm **Arduino UNO**  vào máy tính, mở phần mềm **Arduino IDE**, chọn `File > Example > 11. ArduinoISP > ArduinoISP`.

{% include image.html url="/image/posts/2023-05-20-Huong-dan-cach-update-firmware-cho-Ender-3-Pro/2.png" description="[2] ArduinoISP" %}

Ở mục `Tools > Programmer hãy chọn AVRISP mkII` . Sau đó, hãy verify và upload sketch này lên **Arduino UNO**.
**Lưu ý là vẫn giữ kết nối giữa máy tính và Arduino sau khi upload thành công.**


Bây giờ là lúc cắm Arduino UNO vào máy in 3D Creality Ender-3 Pro thông qua cổng ISP. Các linh kiện sẽ kết nối như thế này.
{% include image.html url="/image/posts/2023-05-20-Huong-dan-cach-update-firmware-cho-Ender-3-Pro/3.png" description="[3] Hardware links" %}
Đây là mạch của máy in 3D.

{% include image.html url="/image/posts/2023-05-20-Huong-dan-cach-update-firmware-cho-Ender-3-Pro/4.png" description="[4] Creality3D v1.1.4 & ISP jacks" %}

Còn đây là mạch **Arduino UNO**. Khi nối dây, **lưu ý là socket số 10 của Arduino sẽ nối vào chân số 3 trên mạch máy in 3D**.
Các chân còn lại 1, 2, 4, 5, 6 nối như bình thường.

{% include image.html url="/image/posts/2023-05-20-Huong-dan-cach-update-firmware-cho-Ender-3-Pro/5.png" description="[5] Arduino UNO & ISP jacks" %}

Sau khi kết nối mạch máy in 3D vào Arduino UNO, mặc dù chúng ta không cấp nguồn cho mạch máy in 3D, màn hình vẫn sẽ sáng vì nó lấy điện thông qua Arduino.

Giờ chúng ta quay trở lại với chương trình Arduino IDE để `burn bootloader` vào mạch máy in 3D thông qua Arduino UNO. Thao tác như sau

- `Tools > Board` , chọn Sanguino,
- `Tools > Port`, vẫn giữ port cũ, cái mà đang kết nối với Arduino.
- `Tools → Processor`, chọn `ATmega1284 or ATmega1284P (16MHz)`
- `Tools → Programmer`, chọn `Arduino as ISP`  (quan trọng)

Sau đó, ấn nút `Tools → Burn Bootloader` . Lúc này bootloader sẽ được cài vào mạch máy in 3D thông qua Arduino UNO.
Màn hình của máy in 3D sẽ có màu xanh, không có chữ gì cả. Đừng lo lắng. Bootloader đã cài đặt thành công rồi.
Bây giờ hãy tháo Arduino UNO và cable ISP, vai trò của **Arduino UNO** đã kết thúc.


# II. Cài đặt firmware Marlin cho máy in 3D
Bước đầu tiên, hãy download Marlin Firmware va Marlin Configration ở link dưới đây  [https://marlinfw.org/meta/download/](https://marlinfw.org/meta/download/)
{% include image.html url="/image/posts/2023-05-20-Huong-dan-cach-update-firmware-cho-Ender-3-Pro/6.png" description="[6] Marlin Firmware Downloads" %}

Từ bây giờ, tôi sẽ gọi thư mục sau khi giải nén **MarlinFirmware.zip**  là thư mục **MarlinFirmware**, còn thư mục sau khi giải nén **MarlinConfiguration.zip** là **MarlinConfiguration**.

Trong thư mục **MarlinFirmware**, sẽ có một thư mục con tên là `Marlin` hãy copy những file sau từ `MarlinConfiguration``/config/examples/Creality/Ender-3 Pro/CrealityV1`,  vào thư mục này:
- `_Bootscreen.h`
- `Configuration.h`
- `Configuration_adv.h`
- `_Statusscreen.h`
Trong thư mục `MarlinFirmware` , Edit file `platformio.ini` ,  thay đổi `default_envs = melzi_optimized`
Tôi sẽ giả định rằng bạn đã cài đặt xong phần mềm python và platformio. Trong thư mục **MarlinFirmware**, hãy chạy lệnh sau
để compile firmware mới, ở thời điểm tôi viết bài này, phiên bản marlin là **2.0.9.6**

{% highlight sh %}

$ platformio run

--------------------------------------------------------------------------------------
Verbose mode can be enabled via `-v, --verbose` option
CONFIGURATION: https://docs.platformio.org/page/boards/atmelavr/sanguino_atmega1284p.html
PLATFORM: Atmel AVR (3.4.0) > Sanguino ATmega1284p (16MHz)
HARDWARE: ATMEGA1284P 16MHz, 16KB RAM, 124KB Flash
DEBUG: Current (simavr) On-board (simavr)
PACKAGES:
 - framework-arduino-avr @ 5.1.0
 - toolchain-atmelavr @ 1.70300.191015 (7.3.0)
Converting Marlin.ino
LDF: Library Dependency Finder -> https://bit.ly/configure-pio-ldf
LDF Modes: Finder ~ chain, Compatibility ~ soft
Found 6 compatible libraries
Scanning dependencies...
Dependency Graph
|-- U8glib-HAL @ 0.5.2
|-- SPI @ 1.0
|-- Wire @ 1.0
Building in release mode
Compiling .pio/build/melzi_optimized/src/src/inc/Warnings.cpp.o
Linking .pio/build/melzi_optimized/firmware.elf
Checking size .pio/build/melzi_optimized/firmware.elf
Advanced Memory Usage is available via "PlatformIO Home > Project Inspect"
RAM:   [===       ]  29.4% (used 4820 bytes from 16384 bytes)
Flash: [==========]  99.6% (used 126450 bytes from 126976 bytes)
======================================================================================

Environment      Status    Duration
---------------  --------  ------------
melzi_optimized  SUCCESS   00:00:07.384
{% endhighlight %}

Firmware đã được build xong, nó nằm ở `.pio/build/melzi_optimized/firmware.hex`

Bây giờ chúng ta sẽ nối máy tính với máy in 3D thông qua cổng mini USB  và upload firmware.
{% highlight sh %}
platformio run --target upload -v
{% endhighlight %}
Tôi sử dụng `-v` (verbose), nó sẽ hiển thị chính xác command mà platformio sử dụng để upload firmware lên mạch máy in 3D.
Command đó nằm ở dòng thứ 6.

{% highlight text linenos %}
AVAILABLE: arduino
CURRENT: upload_protocol = arduino
BeforeUpload(["upload"], [".pio/build/melzi_optimized/firmware.hex"])
Auto-detected: /dev/ttyUSB0

avrdude -v -p atmega1284p -C /home/nguyenvinhlinh/.platformio/packages/tool-avrdude/avrdude.conf -c arduino -b 57600 -D -P /dev/ttyUSB1 -U flash:w:.pio/build/melzi_optimized/firmware.hex:i

avrdude: Version 6.3, compiled on Sep 12 2016 at 15:21:49
         Copyright (c) 2000-2005 Brian Dean, http://www.bdmicro.com/
         Copyright (c) 2007-2014 Joerg Wunsch

         System wide configuration file is "/home/nguyenvinhlinh/.platformio/packages/tool-avrdude/avrdude.conf"
         User configuration file is "/home/nguyenvinhlinh/.avrduderc"
         User configuration file does not exist or is not a regular file, skipping

         Using Port                    : /dev/ttyUSB0
         Using Programmer              : arduino
         Overriding Baud Rate          : 57600
{% endhighlight %}

Khả năng rất cao là chạy lệnh `platformio run --target upload -v` không thành công, nó chí build xong firmware chứ ko có upload được. Error log như sau:
{% highlight text %}
avrdude: stk500_recv(): programmer is not responding
avrdude: stk500_getsync() attempt 1 of 10: not in sync: resp=0xdb
avrdude: stk500_recv(): programmer is not responding
avrdude: stk500_getsync() attempt 2 of 10: not in sync: resp=0xdb
{% endhighlight %}


Lý do bị lỗi này là vì baud rate `-b 57600` không chính xác , Để khắc phục lỗi này, bạn chỉnh sửa `-b 115200`  sau đó chạy lại trên terminal.
Command sẽ trông như sau.

{% highlight sh %}
avrdude -v -p atmega1284p -C /home/nguyenvinhlinh/.platformio/packages/tool-avrdude/avrdude.conf \
        -c arduino -b 115200 -D -P /dev/ttyUSB1 -U flash:w:.pio/build/melzi_optimized/firmware.hex:i
{% endhighlight %}

Đến đây là đã kết thúc quá trình upload firmware mới lên máy in 3D Creality Ender-3 Pro. Trên máy in 3D, nó sẽ yêu cầu bạn `initialize lại EPROOM`,
bạn hãy đồng ý.  Nếu không hãy làm như sau `Configuration > Advanced Settings > Initialize EPROOM`. Sau đó, hãy kiểm tra version
`About Printer > Printer Info` , nó sẽ là `2.0.9.6`.

{% include image.html url="/image/posts/2023-05-20-Huong-dan-cach-update-firmware-cho-Ender-3-Pro/7.jpeg" description="[7] Ender-3 Pro - Marlin 2.0.9.6" %}
