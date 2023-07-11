---
layout: post
title: "HTTPS và các khái niệm liên quan"
date: 2021-01-13 10:06:22 +0700
tags: https
categories: SSL
---
# I. Từ vựng
- Certificate Authority (CA): Cơ quan có thẩm quyền để xác nhận SSL
- Certificate signing request (CSR): Yêu cầu chứng nhận chứng chỉ SSL
- Certificate: Chứng chỉ

# II. Các file liên quan trong việc cài đặt HTTPS
- Private key file: Như tên gọi nó chính là `private key`
- Certificate signing request(`csr`): File này được tạo ra sau khi có `private key`. Khi tạo `yêu cầu chứng nhận chứng chỉ`, sẽ cần phải cung cấp thêm các thông tin như tên quốc gia, email, và nhiều hơn nữa. Những thông tin được dùng để xác nhận và tạo ra `certificate` (`chứng chỉ`), đơn vị tạo ra `chứng chỉ` được gọi là `Certificate Authority`. Tuy nhiên cũng có thể tự tạo ra `chứng chỉ` từ `yêu cầu chứng nhận chứng chỉ`, vì người chứng nhận không phải là `Certificate Authority` nên là trên web browser, trình duyệt sẽ hiển thị màu đỏ bên cạnh đường link.
- Certificate(`chứng chỉ`)

Theo như các khái niệm trên thì khi cài đặt HTTPS cho server, chỉ cần `private key` và `certificate`. Nếu `private key` đã được mã hóa thì lúc cài đặt cho server phải nhớ thêm `mật khẩu` để server có thể giải mã.

# III. Các bước liên quan

### 1a. Lệnh để tạo private key đã mã hóa
```sh
openssl genrsa -des3 -out domain.key 2048
```
Lưu ý rằng file `domain.key` đã được mã hóa. Để sử dụng cho server, cần được giải mã.
```sh
-des3: mã hóa private key theo thuật toán `DES` 3 lần.
2048: độ dài của private key
```

### 1b. Lệnh tạo private key không được mã hóa
```sh
openssl genrsa -out private.key 2048
```

### 2. Lệnh để tạo `yêu cầu chứng nhận chứng chỉ`(csr) từ `private key`
```sh
openssl req -key domain.key -new -out domain.csr
```

### 3. Lệnh để tự tạo `certificate` từ `yêu cầu chứng nhận chứng chỉ` và `private key`
```sh
openssl x509 -signkey domain.key -in domain.csr -req -days 365 -out domain.crt
```

### 4. Lệnh giải mã `private key`
```sh
openssl rsa -in encrypted.key -out decrypted.key
```

# IV. Lưu ý
Không khuyên khích việc xem manual của openssl rồi tự làm, document của command openssl rất khó hiểu và chỉ mang tính chất tham khảo, đôi khi tự xem rồi không biết thứ tự đâu mà làm.
Ví dụ như lệnh tạo `certificate` từ `private key` và `csr`, xem manual mà ko hiểu nên sắp xếp argument như thế nào cho thích hợp. Tốt nhất là làm theo hướng dẫn.
