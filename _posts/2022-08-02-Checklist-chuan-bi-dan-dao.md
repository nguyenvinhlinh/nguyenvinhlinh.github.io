---
layout: post
title: "Checklist chuẩn bị dàn đào"
date: 2022-08-02 13:26:03
update:
location: Saigon
tags:
- Mining Rig
categories:
- Mining Rig
seo_description: Checklist chuan bi dan dao
seo_image:
comments: true
---

Bài viết này được viết để hỗ trợ cho các dàn đào sử dụng hệ điều hành Window 10. Ý kiến cá nhân, tôi không thích
sử dụng các hệ điều hành chuyên dụng ví dụ như Minerstat OS, tôi thích sử dụng Minerstat Window hơn.

{% include image.html url="/image/posts/2022-08-02-Checklist-chuan-bi-dan-dao/1.png" description="Dàn Đào" %}

# I. BIOS
- Advanced → SATA Mode Selection: `AHCI`
- Advanced → CSM Configuration
    - CSM Support: `Enabled`
    - Gate A20 Active: `Upon Request` (Mặc định)
    - Option ROM Messages: `Force BIOS` (Mặc định)
    - Boot option filter: `UEFI and Legacy`
    - Network: `Do not lauch` (Mặc định)
    - Storage: `UEFI`
    - Video: `Legacy` (Mặc định)
    - Other PCI devices: `UEFI` (Mặc định)
- Advanced → USB Configuration
    - Legacy USB Support: `Disabled`
- Chipset → Restore AC Power Loss: `Power On`

# II. Window 10
## 1. Phần mềm
- Google Chrome: [https://www.google.com/chrome/](https://www.google.com/chrome/)
- NVIDIA Driver: [https://www.nvidia.com/download/index.aspx](https://www.nvidia.com/download/index.aspx)
- MSI Afterburner: [https://www.msi.com/Landing/afterburner/graphics-cards](https://www.msi.com/Landing/afterburner/graphics-cards)
- Anydesk: [https://anydesk.com/](https://anydesk.com/)
    - Cài đặt password với profile là `Unattended Access`
- Minerstat: [https://minerstat.com/software/windows](https://minerstat.com/software/windows)


## 2. Thiết lập thêm trong Window 10
- User Account Control Settings: `Never Notify`
- Power Option: `High Performance`
    - Turn off the display: `Never`
    - Put the computer to sleep: `Never`
- Virtual Memory: mỗi VGA là 8,000 MB, ví dụ cài đặt cho 4 x 3080, tổng cộng là 32,000 MB.
    - Initial size (MB): `32,000` MB
    - Maximum size (MB): `32,000` MB
- Visual Effects: `Adjust for best performance`
