---
layout: post
title: "Cách build Bitcoin Knots"
date: 2025-10-08 12:45:27
update:
location: Saigon
tags:
- bitcoin
categories:
- Cryptocurrency Node
seo_description: Build Bitcoin Knots từ mã nguồn
seo_image: /image/posts/2025-10-08-Cach-build-Bitcoin-Knots/seo.png
comments: true
---

# I. Giới thiệu

Bây giờ là 8/10/2025, hiện tại trong mã nguồn của [bitcoin core](https://github.com/bitcoin/bitcoin) đang có một vấn đề mà đến giờ còn đang rất tranh cãi.

- Sử dụng bitcoin blockchain để lưu dữ liệu rác, tranh ảnh, những thứ thậm chí hoàn toàn không có liên quan đến giao dịch.

Kỹ thuật này mấu chốt là, sử dụng các ô nhớ còn trống, chèn dữ liệu vào mà không ảnh hưởng đến logic khi xác thực giao dịch.

- Lạm dụng ô nhớ public key trong giao dịch `multisig`, chèn data vào vị trí của public key
- Lạm dụng ô nhớ `Witness`  (liên quan đến Taproot)
- Lạm dụng ô nhớ `OP_RETURN`

Thậm chí, hiện tại ô nhớ `OP_RETURN` còn bỏ giới hạn tối đa, cho phép `OP_RETURN` sử dụng tới kích cỡ tối đa của 1 Block.

Cá nhân tôi, tôi không thoải mái với việc lạm dụng này, nó cần giới hạn!

Bên lề một chút, chúng ta cần hiểu là mục địch ban đầu là thiện chí, nhưng người dùng thì lạm dụng
- `multisig` chỉ những giao dịch cần nhiều private key ký xác nhận .
- `Taproot` sinh ra nhằm mục đích là làm giảm data trong `tx`, từ đó giảm phí giao dịch.
- `OP_RETURN` thì được sử dụng để lưu trữ dữ liệu bên ngoài blockchain (off-chain), ví dụ trong `OP_RETURN` có thể chèn `Tên, Địa Chỉ, Nội dung chuyển tiền`

---

**Ơ, thế [Bitcoin Knots](https://github.com/bitcoinknots/bitcoin/) nó là gì?**

- Bitcoin Knots là mã nguồn folk từ Bitcoin Core.
- Bitcoin Knots sử dụng Bitcoin blockchain

**Nó giúp được gì?**

- Bitcoin Knots cho phép người vận hành node (như tôi) từ chối broadcast các giao dịch lạm dụng đến các node khác.
- Tuy nhiên, nó sẽ vẫn cho phép các **Block** được xác thực từ miner, kể cả khi **Block** đó có các giao dịch lạm dụng, miễn là **Block** tuân theo cơ chế đồng thuận.
- Bằng việc tôi hosting Bitcoin Knots, nó như là một phiếu bầu của tôi cho việc phản đối các giao dịch có tính lạm dung trên mạng lưới.

**Nó không làm được gì?**
- Kể cả **Block** có toàn là giao dịch lạm dụng, miễn là thỏa mãn cơ chế đồng thuận. Tôi vẫn phải chấp nhận **Block** này.

# II. Cách build
## 1. Clone source code [bitcoin knots](https://github.com/bitcoinknots/bitcoin/)

```
$ git clone https://github.com/bitcoinknots/bitcoin bitcoin_knots
```

## 2. Build source code
Hướng dẫn đầy đủ có sẵn trong source code rồi. Hãy xem ở đây nhé (./bitcoin_knots/doc/build-unix.md) hoặc [UNIX BUILD NOTES](https://github.com/bitcoinknots/bitcoin/blob/29.x-knots/doc/build-unix.md). Còn dưới này chỉ là bản tóm gọm nhất thôi.

Từ mã nguồn này sẽ build được:

- bitcoin-cli
- bitcoind
- bitcoin-qt
- bitcoin-tx
- bitcoin-util
- bitcoin-wallet
- test_bitcoin
- test_bitcoin-qt


```sh
$ cd bitcoin_knots
$ cmake -B build  -DBUILD_GUI=ON -DWITH_QT_VERSION=5
$ cmake --build build -j 32
```

Giải thích:
- `-DBUILD_GUI=ON`: để tạo ra bitcoin-qt (GUI)
- `-DWITH_QT_VERSION=5`: GUI dùng QT version 5
- `-j 32`: Sử dụng nhiều thread hơn để giảm thời gian build. (Kiểm tra với command`$ nproc`)

Tất cả các file được build xong sẽ nằm trong `./build/bin`.

Phương cách build của bitcoin là theo target, ví dụ tôi chỉ cần dùng `bitcoind`, tôi hoàn toàn có thể tiết kiệm thời gian và chạy như sau:

```sh
$ cd bitcoin_knots
$ cmake -B build
$ cmake --build build --target bitcoind -j 32

# Command output:
[ 98%] Built target bitcoin_util
[ 98%] Built target bitcoin_common
[ 98%] Built target bitcoin_wallet
[ 98%] Built target bitcoin_node
[ 98%] Building CXX object src/CMakeFiles/bitcoind.dir/bitcoind.cpp.o
[ 98%] Building CXX object src/CMakeFiles/bitcoind.dir/init/bitcoind.cpp.o
[100%] Linking CXX executable ../bin/bitcoind
[100%] Built target bitcoind

```

Để xem chi tiết tất cả các tham số cho `$ cmake -B build` ở đây - [Autotools to CMake Options Mapping](https://github.com/bitcoin-core/bitcoin-devwiki/wiki/Autotools-to-CMake-Options-Mapping).

Lúc trước, giai đoạn build sẽ dùng `./configure` rồi chèn tham số trước khi chạy `cmake`, tuy nhiên ở phiên bản mới, không cần dùng đến `./configure` nữa.

# 3. Cách sử dụng `bitcoind`
Mặc định phiên bản `bitcoind` được tạo ra từ mã nguồn [Bitcoin Knots](https://github.com/bitcoinknots/bitcoin/) đã gài các tham số mặc định nhằm loại bỏ không
broadcast các tx lạm dụng rồi. Tôi chỉ đơn giản là thay thế file `bitcoind` khi chạy node mà thôi. Bên node của tôi chạy, tôi còn thêm `datacarrier=0` nhằm
loại bỏ giao dịch có `OP_RETURN`, Bạn có thể giữ `OP_RETURN` kết hợp với giới hạn ô nhớ nhằm loại bỏ tx lạm dụng, tôi thì tắt luôn.

Để tiện tham khao, đây là file `bitcoin.conf` mặc định, bạn có thể xem nó ở `bitcoin_knots/share/examples/bitcoin.conf`. Trong nhiều flag thì đây là cái quan trọng

- `rejectparasites`: Refuse to relay or mine parasitic overlay protocols

Bên cạnh đó, bạn có thể vào [Bitcoin Config Editor](https://bitcoinconfig.space/) để tham khảo thêm, nó cung cấp giao diện dễ sử dụng nên rất tiện.
