---
layout: post
title: "Cách build Monero"
date: 2026-11-08 15:58:14
update:
location: Saigon
tags:
- monero
- linux
- fedora
categories:
- Cryptocurrency Node
seo_description: Build Monero trực tiếp từ mã nguồn trên Fedora
seo_image: /image/posts/2026-11-08-Cach-build-Monero/seo.png
comments: true
---

## I. Mở đầu
Bài viết này tập trung vào việc build monero từ source code trên Fedora, mọi thông tin trên bài viết này được lấy từ [Repo Monero, file Readme.md](https://github.com/monero-project/monero).

Lưu ý là Monero hiện tại không phải là `monorepo`. Nó tách riêng 2 phiên bản:
- Monero: [https://github.com/monero-project/monero](https://github.com/monero-project/monero)
- Monero-GUI: [https://github.com/monero-project/monero-gui](https://github.com/monero-project/monero-gui)

Bài viết này tập trung vào chỉ dẫn build cái đầu tiên: [Monero](https://github.com/monero-project/monero)
## II. Nội dung

### Bước 1: Cài đặt các thư viện liên quan
```sh
$ sudo dnf install gcc gcc-c++ cmake pkgconf boost-devel openssl-devel zeromq-devel unbound-devel \
           libsodium-devel libunwind-devel ccache doxygen graphviz hidapi-devel libusb1-devel \
           protobuf-devel protobuf-compiler rust cargo
```

### Bước 2: Clone source code & repository phụ
```sh
$ git clone --recursive https://github.com/monero-project/monero
$ git submodule init && git submodule update
```

Lần sau, bạn chỉ cần
- `$ git fetch origin`: để kéo mã nguồn mới về
- `$ git checkout TAG`: để chọn tag cho mã nguồn
- `$ git submodule init && git submodule update`: để cài đặt và update các repository phụ

### Bước 3: Build
```sh
$ make -j $(nproc)
```
Đây là kết quả của tôi sau khi build phiên bản `v0.18.5.4`.
```sh
➜ monero (85f036ba7) ✗  tree build/Linux/_HEAD_detached_at_v0.18.5.4_/release/bin
build/Linux/_HEAD_detached_at_v0.18.5.4_/release/bin
├── monero-blockchain-ancestry
├── monero-blockchain-depth
├── monero-blockchain-export
├── monero-blockchain-import
├── monero-blockchain-mark-spent-outputs
├── monero-blockchain-prune
├── monero-blockchain-prune-known-spent-data
├── monero-blockchain-stats
├── monero-blockchain-usage
├── monerod
├── monero-gen-ssl-cert
├── monero-gen-trusted-multisig
├── monero-wallet-cli
└── monero-wallet-rpc
```

Bài viết đến đây là kết thúc. Lần tới khi tôi build monero, tôi sẽ tiết kiệm được 2 phút cuộc đời.

## III. Trích dẫn
- Monero, [https://github.com/monero-project/monero](https://github.com/monero-project/monero)
