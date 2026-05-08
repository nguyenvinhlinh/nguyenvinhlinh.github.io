---
layout: post
title: "Kỹ thuật sử dụng cảm biến hiệu điện thế ZMPT101B"
date: 2026-04-10 23:54:29
update:
location:
tags:
categories: Arduino
seo_description:
seo_image:
comments: true
---

Bài viết này miêu tả những kỹ thuật và lưu ý mà tôi đã học được để sử dụng cảm biển `ZMPT101B`.

- 1. Ngay khi mua cảm biến `ZMPT101B`, cần tinh chỉnh triết áp với `Serial Plotter`, xung không nên bị bè ở đầu, mất góc ở đỉnh.
- 2. Sau khi làm xong bước một, lúc này sẽ tinh chỉnh tiếp đến giá trị `Sensitivity`.
- 3. Mỗi cảm biến lại có những sai số khác nhau, hoàn toàn không thể sử dụng tinh chỉnh (`calibration`) của cảm biến này áp dụng cho cảm biển khác, mặc dù là cùng một model.


## 1. Vặn triết áp và theo dõi trên Serial Plotter
Trước khi điều chỉnh, bắt buộc phải cắm dây điện xoay chiều vào cảm biến `ZMPT101B`. Bên cạnh đó, phải có phần mềm **Arduino-IDE**, mở công cụ `Serial Plotter`. **Arduino-CLI** không có tính năng này.

Việc điều chỉnh triết áp dựa trên các tiêu chí sau:

- Giá trị / biên độ là lớn nhất khi xem trên Serial
- Đỉnh của sóng không được phép bè ra, mất góc nhọn.


```c++
void setup() {
  Serial.begin(115200);
}

void loop() {
  Serial.println(analogRead(A0));
  delayMicroseconds(1000);
}
```

{% include image.html url="/image/posts/2026-04-10-Ky-thuat-su-dung-cam-bien-hieu-dien-the-ZMPT101B/1.jpg" description="[1] Serial Plotter sau khi tinh chỉnh triết áp" %}

## 2. Tìm kiếm vị trí tham chiếu (Zero Point)
Định nghĩa vị trí tham chiếu (`Zero Point`) là vị trí mà ở đó không ghi nhận giá trị hiệu điện thế điện xoay chiều.

Để tim giá trị này, ta tháo toàn bộ dây AC cần đo ra khỏi cảm biến và chạy đoạn code sau. Ở phía bên tôi, tôi thu được giá trị là `511`.

```c++
const int WINDOW_TIME = 1000;
const int ZMPT101B_PIN = A0;

unsigned long sumOfSampleData = 0;
unsigned long sampleCounter = 0;
unsigned long startTime;
void setup() {
  Serial.begin(115200);
  startTime = millis();
}

void loop() {

  int sampleData = analogRead(ZMPT101B_PIN);
  sumOfSampleData += sampleData;
  sampleCounter += 1;

  if(millis() - startTime >= WINDOW_TIME) {
    int sampleAvg = sumOfSampleData / sampleCounter;
    Serial.print("Zero Point: ");
    Serial.println(sampleAvg);
    sumOfSampleData = 0;
    sampleCounter = 0;
    startTime = millis();
  }
}
```


```text
14:11:15.109 -> Zero Point: 511
14:11:16.106 -> Zero Point: 511
...
14:11:22.113 -> Zero Point: 511
14:11:23.109 -> Zero Point: 511
```

Bên cảm biến của tôi, kết quả là `511`.

## 3. Tìm hệ số chuyển đổi `scale`
Ở đoạn này bắt buộc phải có đồng hồ chính xác bên ngoài, đo trước hiệu điện thế điện xoay chiều AC. Sau đó, gài giá trị vào `EXPECTED_VOLTAGE`
ở đoạn code dưới đây và chạy. Khi chạy code, đảm bảo dây AC cần đo đã gắn vào cảm biến `ZMPT101B` chắc chắn.

Ở bên nhà tôi, hiệu điện thế đo được là `233V` (Hoàn toàn không phải là `220V` đâu nhé). Giá trị `scale` tôi thu được là `1.38`

```c++
#include <math.h>

const int ZMPT101B_PIN       = A0;
const float EXPECTED_VOLTAGE = 233.0;
const unsigned int zeroPoint = 511;
const int WINDOW_TIME        = 1000;

unsigned long  sumOfSquareOfSampleDataMinusZeroPoint = 0;
unsigned long  sampleCounter                         = 0;
unsigned long  startTime;
float          rootMeanSquare = 0.0f;

void setup() {
  Serial.begin(115200);
  startTime = millis();
}

void loop() {
  int sampleData = analogRead(ZMPT101B_PIN);
  sumOfSquareOfSampleDataMinusZeroPoint += (sampleData - zeroPoint) * (sampleData - zeroPoint);
  sampleCounter += 1;

  if (millis() - startTime >= WINDOW_TIME) {
    rootMeanSquare = sqrt((float) sumOfSquareOfSampleDataMinusZeroPoint / sampleCounter);
    float scale = EXPECTED_VOLTAGE / rootMeanSquare;
    Serial.print("Root Mean Square: ");
    Serial.print(rootMeanSquare);
    Serial.print(" (in ");
    Serial.print(sampleCounter);
    Serial.print(" samples). Scale: ");
    Serial.println(scale);

    sumOfSquareOfSampleDataMinusZeroPoint = 0;
    sampleCounter = 0;
    startTime = millis();
  }
}
```

```text
14:04:15.083 -> Voltage: 233.00 | Root Mean Square: 168.56 (in 17856 samples) | Scale: 1.38
14:04:17.108 -> Voltage: 233.00 | Root Mean Square: 168.53 (in 17855 samples) | Scale: 1.38
14:04:19.099 -> Voltage: 233.00 | Root Mean Square: 168.69 (in 17855 samples) | Scale: 1.38
14:04:21.088 -> Voltage: 233.00 | Root Mean Square: 168.73 (in 17855 samples) | Scale: 1.38
```

Phương pháp như sau:
- Tính toán giá trị hiệu dụng (`Root Mean Square - RMS`) của giá trị sensor với giá trị tham chiếu (zero point) trong một khoảng thời gian (`WINDOW_TIME`)
- Kết hợp với giá trị hiệu điện thế AC đo đạc từ một đồng hồ đo điện khác (`EXPECTED_VOLTAGE`)
- Tồn tại sự tương quan giữa `giá trị hiệu dụng của sensor` và hiệu điện thế `EXPECTED_VOLTAGE`, tỷ lệ này ta gọi là `SCALE`(Hệ số chuyển đổi)
- Tính toán tỷ lệ `SCALE = EXPECTED_VOLTAGE / RMS`

## 4. Tìm giá trị hiệu điện thế tức thời
Sau khi tìm được giá trị `SCALE - hệ số chuyển đổi`, ví dụ cảm biến cho ta giá trị là `X`, muốn tìm ra hiệu điện thế tức thời, ta làm như sau:

```
Vtức_thời = (X - ZeroPoint) * Scale
```


## 5. Lưu ý
- Một khi đã tinh chỉnh xong, không được phép vặn triết áp. Nếu mà lỡ vặn, phải làm lại từ đầu.
