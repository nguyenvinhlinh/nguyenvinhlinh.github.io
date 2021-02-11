---
layout: post
title: "Tinh chỉnh Afterburner, chi phí & lợi nhuận vận hành MSI RTX 3080"
date: 2021-02-12 00:21:58
tags: MSI, RTX3080, Mining
categories: MiningRig
---

# I. Giới Thiệu
Tôi đã mua MSI 3080 Ventus 10G OC vào ngày 2/2/2021 và MSI Trio X Gaming vào ngày 2/5/2021. Sau một thời gian sử dụng
đây là các thiết lập `MSI Afterburner` tôi đang sử dụng để đào Ethereum (ETH). Trước khi đi sâu vào thiết lập,
tôi muốn đề cập đến giá của ETH hiện tại, `ngày 11/2/2021, 1 ETH = $1,789 USD, xấp xỉ 41,196,850 VND`. Bên cạnh đó, giá
điện sinh hoạt tôi đang sử dụng theo bảng sau:

{% include image.html url="/image/posts/2021-02-12-Tinh-chinh-afterburner,-chi-phi-va-loi-nhuan-van-hanh-MSI-RTX-3080/1.png" description="[1] Bảng giá điện" %}

{% include image.html url="/image/posts/2021-02-12-Tinh-chinh-afterburner,-chi-phi-va-loi-nhuan-van-hanh-MSI-RTX-3080/2.png" description="[2] 11/2/2021 23:23 GMT+7, CoinMarketCap, Giá trị Ethereum" %}

`MSI 3080 Ventus 10G OC & Trio X Gaming` sau khi đã áp dụng các thiệt lập sẽ có hiệu năng như hình dưới đây. Hoàn toàn có
thể đấy lên 101MH/s nếu muốn. Tuy nhiên tôi chỉ muốn ở mức **100MH/s** cho mỗi card màn hình. Nếu bạn để ý kĩ, bạn sẽ thấy răng
mặc dù Ventus và Trio có mức hashrate là tương đương nhau, tuy nhiên số lượng share của Trio luôn luôn lớn hơn của Ventus,
khá là kì quặc, có lẽ là tiền nào của nấy. Khi nào thị trường bớt khan hiếm, tôi sẽ thử xem `MSI 3080 Suprim` có gì đặc biệt hơn.

{% include image.html url="/image/posts/2021-02-12-Tinh-chinh-afterburner,-chi-phi-va-loi-nhuan-van-hanh-MSI-RTX-3080/3.jpeg" description="[3] Hiệu năng sau khi tinh chỉnh" %}


# II. MSI 3080 Ventus 10G OC
- Power Limit: 80%
- Temperature Limit: 65 độ C
- Core Clock: -502
- Memory Clock: +1300 MHz
- Fan: Auto

Mức thiết lập này sẽ có kết quả như sau:

- Hashrate: 100.622 MH/s
- Tiêu thụ: 256W
- Nhiệt độ: 55 độ C

# III. MSI 3080 Trio X Gaming
- Power Limit: 116%
- Temperature Limit: 70 độ C
- Core Clock: -502
- Memory Clock: +1300 Mhz
- Fan: Auto

Mức thiết lập này sẽ có kết quả như sau:

- Hashrate: 100.417MH/s
- Tiêu thụ: 319W
- Nhiệt độ: 60 độ C


# IV. Chi phí và lợi nhuận
## a. Chi phí

Phi phí dưới đây sẽ dựa trên thông tin ghi trên phần mềm, chưa có áp dụng cho case, quạt của case 4U.

- Tổng năng lượng điện tiêu thụ cho MSI 3090 Ventus & Trio trong một tháng: `414kWh`
- Tổng tiền điện trong một tháng theo bảng giá điện sinh hoạt 2020: `949,978 VND`

{% include image.html url="/image/posts/2021-02-12-Tinh-chinh-afterburner,-chi-phi-va-loi-nhuan-van-hanh-MSI-RTX-3080/4.png" description="[4] Tiền điện phải trả cho riêng Ventus & Trio (414kWh)" %}


## b. Lợi nhuận

Theo như trang web https://www.cryptocompare.com/ thì với hashrate là `201MH/s` , mỗi tháng sẽ kiếm đc `0.3766 Ethereum`.
Nếu quy đổi số Ethereum này thành USD thì sẽ là `$669 USD` hoặc là `15,514,733 VND` . Sau khi trừ đi chi phí  lợi nhuận
còn lại sẽ là `14.564.755 VND`.

{% include image.html url="/image/posts/2021-02-12-Tinh-chinh-afterburner,-chi-phi-va-loi-nhuan-van-hanh-MSI-RTX-3080/5.png" description="[5] 12/2/2021, CryptoCompare, 201MH/s sẽ cho ra 0.3766 ETH một tháng" %}

# V. Trích Dẫn
Bảng Giá Điện Sinh Hoạt 2020-Giá Bán Điện Kinh Doanh EVN 2020, [https://vuphong.vn/bang-gia-dien-sinh-hoat-2020-gia-ban-dien-kinh-doanh-evn-2020/?gclid=Cj0KCQiAyJOBBhDCARIsAJG2h5dKdg4-F3BXhEVhDcn8_bQQr-VW8uTR3Fql8j3nQjN4bp-LPxIWyAAaApRjEALw_wcB](https://vuphong.vn/bang-gia-dien-sinh-hoat-2020-gia-ban-dien-kinh-doanh-evn-2020/?gclid=Cj0KCQiAyJOBBhDCARIsAJG2h5dKdg4-F3BXhEVhDcn8_bQQr-VW8uTR3Fql8j3nQjN4bp-LPxIWyAAaApRjEALw_wcB)

CryptoCompare, [https://www.cryptocompare.com/mining/calculator/eth?HashingPower=201&HashingUnit=MH%2Fs&PowerConsumption=0&CostPerkWh=0.11&MiningPoolFee=1](https://www.cryptocompare.com/mining/calculator/eth?HashingPower=201&HashingUnit=MH%2Fs&PowerConsumption=0&CostPerkWh=0.11&MiningPoolFee=1)

CoinMarketCap, [https://coinmarketcap.com/vi/currencies/ethereum/](https://coinmarketcap.com/vi/currencies/ethereum/)
