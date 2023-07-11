---
layout: post
title: "Single Sign On sử dụng SAML - Cách hoạt động"
date: 2021-07-31 16:07:24 +0700
tags:
- sso
- saml
categories:
- SSO
---

# I. Mục đích

Mục đích sau cùng của tất cả những thứ này là gia tăng trải nghiệm người dùng. Một doanh nghiệp có thể đang sử dụng nhiều ứng dụng. Mỗi ứng dụng này chắn chắn sẽ chứa users. Cách làm truyền thống và dễ gặp nhất đó là mỗi ứng dụng sẽ có một danh sách users tách biệt. Tuy nhiên, cách làm này làm giảm trải nghiệm người dùng rất nhiều, họ phải đăng nhập lại cho mỗi ứng dụng họ muốn sử dụng, ghi nhớ password; là người quản trị, việc thêm users / xóa users cho hệ thống cũng sẽ mệt mỏi vì phải làm việc này cho từng ứng dụng một, thậm chí ngoài ra còn là về vấn đề bảo mật, chúng ta càng bắt users phải nhập nhiều mật khẩu bao nhiêu, chúng ta càng làm họ dễ mất mật khẩu. Tôi đã từng thấy những người họ sử dụng 1 hoặc 2 mật khẩu và áp dụng nó từ tài khoản zing, gmail cho đến flickr.

Với phía là doanh nghiệp, việc có một hệ thống quản lý danh sách users, hệ thống này là trung gian, nằm chính giữa tất cả các ứng dụng sẽ cực kỳ hữu ích.


# II. Các đối tượng tham gia
- **Identity Provider**: Chứa thông tin của users, bên cạnh đó cung cấp giao thức để users có thể đăng nhập vào các ứng dụng (service provider) mà không cần đăng ký lại.
- **Service Provider***: Ở trong bài viết này, nó được xem như là ứng dụng, để truy cập vào ứng dụng này, chắn chắn users cần đăng nhập. Và với sự hỗ trợ của `Identity Provider`, nguồn users của ứng dụng sẽ đến từ `Identify Provider`.
- **User-Agent**: Trình duyệt web


# III. Nguyên lý

Sequence Diagram dưới đây miêu tả những từng bước một bắt đầu từ việc `users` vào `service provider`, hay còn gọi cách khác là  **SP-Initiated**.
Trong bài viết này, tôi không đề cập đến sequence diagram bắt đầu từ `Identity Provider` **(IdP-Initiated)**.

{% include image.html url="/image/posts/2021-07-31-sso-su-dung-saml-cach-hoat-dong/1.png" description="SP-Initiated Sequence Diagram." %}


# IV. Nguồn và Trích dẫn
- IBM 2021, 'SAML 2.0 Web Browser Single-Sign-On',  [https://www.ibm.com/docs/en/was-liberty/base?topic=authentication-saml-20-web-browser-single-sign](https://www.ibm.com/docs/en/was-liberty/base?topic=authentication-saml-20-web-browser-single-sign)
- VMware End-User Computing 2019, SAML 2.0: Technical Overview, [https://www.youtube.com/watch?v=SvppXbpv-5k](https://www.youtube.com/watch?v=SvppXbpv-5k)
