---
layout: post
title: "Tích hợp QR Scanner vào Phoenix"
date: 2025-09-22 13:21:03
update:
location: Saigon
tags:
- elixir
- phoenix
- liveview
categories: Phoenix
seo_description: Tích hợp quét QR Code khá là phiền, tuy nhiên qua bài viết này, tôi hi vọng có thể giảm độ mệt của bạn
seo_image: /image/posts/2025-09-22-Tich-hop-QR-Scanner-vao-Phoenix/seo.png
comments: true
---

Trước khi bắt đầu, tôi muốn giới thiệu [html5-qrcode](https://github.com/mebjas/html5-qrcode). Đây là một repo siêu tốt giúp chúng ta
scan QR Code. Trong bài post này, tôi sẽ hướng dẫn cách tích hợp `html5-qrcode` vào [Phoenix Web Framework](https://www.phoenixframework.org/) & [Liveview](https://hexdocs.pm/phoenix_live_view/welcome.html).


<video src="/image/posts/2025-09-22-Tich-hop-QR-Scanner-vao-Phoenix/1.webm" width="800" controls></video>



Cảm ơn [chatGPT](https://chatgpt.com/) đã giúp tôi hiểu thêm về `LiveView`, `Hook`, `JS module`, tôi chủ yếu là làm về backend, JS hay frontend chưa bao giờ
là thế mạnh của tôi. Thời điểm cuối cùng tôi làm việc nhiều với Javascript, [JQuery](https://jquery.com/) vẫn là thứ gì đó rất phổ biển, không như bây giờ, Javascript được
sử dụng chung với một **Frontend Web Framework** ví dụ như `Angular`, `React` hay `VueJS`.

Bài post này sẽ định hướng như sau:

- Cách cài đặt `html5-qrcode`.
- Cách tích hợp `html5-qrcode` vào từng page mà chúng ta cần.

# 1. Cài đặt `html5-qrcode`
Hiện tại là 22/9/2025, phiên bản `html5-qrcode` gần đây nhất là `2.3.8`. Bạn vào [link](https://github.com/mebjas/html5-qrcode/releases/tag/v2.3.8)
này và download `html5-qrcode.min.js`

Sau khi download xong, hãy copy vào `priv/static/assets/vendor/` trong Phoenix Project.

Trước khi đi xa hơn, tôi muốn chú thích một chút:

- Ngay sau khi web browser load file `html5-qrcode.min.js`, nội dung liên quan sẽ nằm trong variable `window.Html5Qrcode`, thực chất
nó là một function.
- `html5-qrcode` sử dụng theo cách này, hoàn toàn không liên quan đến `npm`, thuần túy hết như jQuery. Mọi thứ cần thiết đã ở trong
`html5-qrcode.min.js`. Tôi chỉ cần load lên và chạy.


Quay lại bước cài đặt, sau khi chúng ta copy xong, bây giờ sẽ cần phải chèn vào file root_layout `root.html.heex`

``` html
#File lib/ntt_web/components/layouts/root.html.heex

- - - - -
<script src={~p"/assets/vendor/html5-qrcode.min.js"}></script>
- - - - -
```

Để kiểm tra, bạn có thể vào console và gõ thử `window.Html5Qrcode` hay `Html5Qrcode`

# 2. Tích hợp vào từng LiveView page

Cái này chủ yếu sẽ là làm việc với file `html.heex` và liveview hook [(xem chi tiết)](https://hexdocs.pm/phoenix_live_view/js-interop.html).

Định nghĩa một chút về hook (cái móc), khi có **sự kiện** gì đó xảy ra, một hoặc nhiều hook có liên quan sẽ bị kích hoạt.

Cụ thể hơn, sự kiện tôi muốn sử dụng ở đây là khi LiveView được `mounted`, thì tôi sẽ chuẩn bị `Html5Qrcode` và những thứ liên quan. Cái
chỗ này, nó giống với việc trong một page html, ở bên dưới bạn sử dụng `<script>`.

Bên cạnh đó, về phía giao diện chúng ta sẽ có:

- Có field `input type=text` chứa giá trị qr code.
- Có nút ấn để mở ra giao diện quét QR Code
- Khi quét ra giá trị của QR Code, cập nhật giá trị cho field `input` của qr_code. Sau đó đóng giao diện quét QR Code.

## 2.1 Tạo module `Hooks`
Trong bài post này, tôi lấy ví dụ là tôi muốn sử dụng `html5-qrcode` cho page tạo mới sản phẩm cho sàn thương mại điện tử. Tôi đặt tên nó là `product_new`

Trong `assets/js` tạo thư mục mới tên là `hooks/product_new`,

```
assets
|--js
|----hooks
|------product_new
```

Trong `assets/js/hooks/product_new`, tạo file: `qr_code_scanner.js` với nội dung như sau:

``` js
File: assets/js/hooks/product_new/qr_code_scanner.js

let scanner;
const config = {
  fps: 4,
  qrbox: 250
}
let isOpen = false;

function qrCodeSuccessFunction(decodedText, result) {
  qrCodeInput = document.querySelector("#product_qr_code");
  qrCodeInput.value = decodedText;
  isOpen = false;
  scanner.stop().then(
    () => {
      scanner.clear();
    }
  );
}

function qrCodeErrorFunction(errorMessage, error) {
  console.warn("[asset_new][qr_code_scanner][qrCodeErrorFunction/2]", errorMessage);
}

const ProductNewQRCodeScanner = {
  mounted() {
    const scannerButton = this.el;
    if (scanner === null || scanner === undefined) {
      scanner = new Html5Qrcode("qr-reader");
    }

    scannerButton.addEventListener("click", () => {
      if (isOpen === false) {
        isOpen = true;
        scanner.start({ facingMode: "environment" }, config, qrCodeSuccessFunction, qrCodeErrorFunction);
      } else {
        isOpen = false;
        scanner.stop().then(
          () => {
            scanner.clear();
          }
        );
      }
    })
  }
}

export default ProductNewQRCodeScanner
```

Bạn chú ý nhất là cái `function mounted()`, nó được kích hoạt khi mà LiveView mount xong cái `<tag>` chứa `phx-hook`. Có rất nhiều các hooks, xem chi tiết ở đây [Client hooks via phx-hook](https://hexdocs.pm/phoenix_live_view/js-interop.html#client-hooks-via-phx-hook)

Tiếp theo, tạo file mới `assets/js/hooks/index.js` có nội dung như sau

``` js
File: assets/js/hooks/index.js

import ProductNewQRCodeScanner from "./asset_new/qr_code_scanner.js"

export default {
  ProductNewQRCodeScanner
}

```

Sau đó, trong file `assets/js/app.js`, ta cần thay đổi nội dung như sau để khi khởi tạo `LiveSocket`, nó sẽ có thêm thông tin về `hooks`

``` js
File: assets/js/app.js

import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import Hooks from "./hooks"  // <------- THIS LINE


const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
const liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: Hooks              // <------- THIS LINE
})
```


Tóm tắt lại nhé, nãy giờ chúng ta đã làm là lên kịch bản cho **hành động sẽ xảy ra khi hook được kích hoạt**.

## 2.2 Kích hoạt Hook

Bây giờ, chúng ta sẽ đến phần kích hoạt hook! Cách kích hoạt hook 100% dựa vào `phx-hook` [(link)](https://hexdocs.pm/phoenix_live_view/js-interop.html#client-hooks-via-phx-hook). Dưới đây là ví dụ:

``` html
File: product_live/new.html.heex

<label class="input w-full pr-0">
    <span class="iconify lucide--qr-code text-base-content/60 size-4"></span>
    <input class="grow" type="text" placeholder="QR Code: XXX-XXX-XXX"
           id={f[:qr_code].id} name={f[:qr_code].name} value={f[:qr_code].value} />       <!-- [1] Chú Ý Dòng Này -->
    <button type="button" class="btn btn-outline btn-accent"
            id="product-new-qr-code-scanner-button" phx-hook="ProductNewQRCodeScanner">   <!-- [2] Chú Ý Dòng Này -->
      Scan
    </button>

</label>
<div id="qr-reader" class="w-full" ></div>                                                <!-- [3] Chú Ý Dòng Này -->
```

Giải thích về các chú ý:

- [1] đây là `<input>`, khi mà quét QR Code thành công, giá trị của qr code sẽ hiển thị ở đây. Nó liên quan mật thiết đến đoạn code sau

```js
File: assets/js/hooks/product_new/qr_code_scanner.js

function qrCodeSuccessFunction(decodedText, result) {
  qrCodeInput = document.querySelector("#product_qr_code");  // #product_qr_code chính là `id` của <input>
  qrCodeInput.value = decodedText;
  isOpen = false;
  scanner.stop().then(
    () => {
      scanner.clear();
    }
  );
}

```

- [2] `phx-hook="ProductNewQRCodeScanner"` nó liên quan đến `assets/js/hooks/index.js`. Sai hook name sẽ không thể chạy.
Bên cạnh đó, cái `<button>` chứa `phx-hook` được truyền vào bên trong JS class `ProductNewQRCodeScanner` dưới tên `this.el`.

Phàn nàn một chút, tôi siêu ghét `this`. **Fuck `this` shit!**

Ma thuật đen đáng căm ghét này là một trong nhiều lý do tôi ko ưng Javascript, Mà lại dành nhiều tình yêu cho Elixir.

Tuy nhiên, tôi tôn trọng nó, đầy là một phần đầy tính di sản của object oriented.

- [3] `id="qr-reader"` đoạn code này liên quan đến chỗ hiển thị màn hình QR Code Scanner. Nó liên quan đến đoạn code sau


```js
# File: assets/js/hooks/product_new/qr_code_scanner.js

const ProductNewQRCodeScanner = {
  mounted() {
    const scannerButton = this.el;
    if (scanner === null || scanner === undefined) {
      scanner = new Html5Qrcode("qr-reader");    /‌/ qr-reader chính là `id` của <div>
    }
  }
}
```

Kết thúc bài viết rồi, ahihi!
