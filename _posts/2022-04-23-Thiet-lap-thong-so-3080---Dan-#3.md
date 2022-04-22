---
layout: post
title: "Thiết lập thông số 3080 - Dàn #3 Chu Tước"
date: 2022-04-23 00:57:47
update:
location: Saigon
tags:
categories:
- Mining Rig
seo_description:
seo_image:
comments: false
---

# I. Lời mở đầu
Bài viết này phục vụ mục đích duy nhất là đó là nếu tôi lỡ tay xóa mấy profile trên **MSI Afterburner**, **Minerstat**.
Tôi sẽ quay lại đây xem. Hiện tại đây là 4 VGA trực thuộc dàn **#3 Chu Tước**. Cả 4 VGA này đều là dòng Lite Hash Rate (LHR).

| No | VGA                          |
|----|------------------------------|
| 1  | MSI 3080 VENTUS 10G OC (LHR) |
| 2  | MSI 3080 VENTUS 10G OC (LHR) |
| 3  | MSI 3080 VENTUS 10G OC (LHR) |
| 4  | MSI 3080 VENTUS 10G OC (LHR) |

{% include image.html url="/image/posts/2022-04-23-Thiet-lap-thong-so-3080---Dan-3/1.png" description="[1] Chu Tước" %}

# II. Mức thiết lập - Ethereum - 70MH/s

{% include image.html url="/image/posts/2022-04-23-Thiet-lap-thong-so-3080---Dan-3/2.png" description="[2] T-rex miner" %}


## a. T-rex config.json
Config này hoàn toàn có thể sử dụng trong **minerstat**

{% highlight json %}

{
    "pools": [
        {
        "user": "(WALLET:ETH)⁣",
        "worker": "(WORKER)⁣",
        "url": "(POOL:ETH)⁣",
        "pass": "x"
    }
    ],
    "no-nvml": false,
    "api-bind-http": "127.0.0.1:4068",
    "json-response": true,
    "pci-indexing": true,
    "retries": 3,
    "retry-pause": 5,
    "timeout": 500,
    "no-watchdog": true,
    "algo": "ethash",
    "exit-on-cuda-error": true,
    "exit-on-connection-lost": false,
    "coin" : "Ethash",
    "gpu-report-interval": 5,
    "lhr-tune": -1,
    "lhr-autotune-mode": "full",
    "lhr-autotune-step-size": 0.2
}
{% endhighlight %}

## b. Thiết lập với Minerstat

| No | VGA                          | Core Clock | Mem Clock  |
|----|------------------------------|------------|------------|
| 1  | MSI 3080 VENTUS 10G OC (LHR) | 1150 MH/s  | 10041 MH/s |
| 2  | MSI 3080 VENTUS 10G OC (LHR) | 1150 MH/s  | 10041 MH/s |
| 3  | MSI 3080 VENTUS 10G OC (LHR) | 1150 MH/s  | 10041 MH/s |
| 4  | MSI 3080 VENTUS 10G OC (LHR) | 1150 MH/s  | 10041 MH/s |


## c. Thiết lập với MSI Afterburner
Lưu ý chỉ dùng **MSI Afterburner** để debug.

| No | VGA                          | Power Limit | Temp. Limit | +/- Core Clock | +/- Mem Clock |
|----|------------------------------|-------------|-------------|----------------|---------------|
| 1  | MSI 3080 VENTUS 10G OC (LHR) | 75%         | 65C         | -502 MH/s      | +800 MH/s     |
| 2  | MSI 3080 VENTUS 10G OC (LHR) | 75%         | 65C         | -502 MH/s      | +800 MH/s     |
| 3  | MSI 3080 VENTUS 10G OC (LHR) | 75%         | 65C         | -502 MH/s      | +800 MH/s     |
| 4  | MSI 3080 VENTUS 10G OC (LHR) | 75%         | 65C         | -502 MH/s      | +800 MH/s     |


## d. Kết quả thu được

| No | VGA                          | Power Consumption | Hashrate       | GPU Temp. | Memory Temp. |
|----|------------------------------|-------------------|----------------|-----------|--------------|
| 1  | MSI 3080 VENTUS 10G OC (LHR) | 231 Walt          | 73.24 MH/s     | 61C       | 106C         |
| 2  | MSI 3080 VENTUS 10G OC (LHR) | 237 Walt          | 72.56 MH/s     | 58C       | 102C         |
| 3  | MSI 3080 VENTUS 10G OC (LHR) | 236 Walt          | 73.22 MH/s     | 59C       | 104C         |
| 4  | MSI 3080 VENTUS 10G OC (LHR) | 237 Walt          | 72.78 MH/s     | 56C       | 100C         |
|    |                              |                   |                |           |              |
|    | **Total**                    | **941 Walt**      | **291.8 MH/s** | --        | --           |
