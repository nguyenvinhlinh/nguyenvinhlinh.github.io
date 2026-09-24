---
layout: post
title: Cách thay đổi thứ tự record entry với database postgresql
date: 2026-09-24 19:34:27
update:
location: Saigon
tags:
- SQL
- Postgresql
- Reorder
categories: SQL
seo_description: Drag and drop là trên UI, còn dưới database cách update nhanh thứ tự record là câu chuyện khác
seo_image: /image/posts/2026-09-24-Cach-thay-doi-thu-tu-record-entry-voi-database-postgesql/seo.avif
comments: true
---

Tôi sẽ mở đầu bài viết này từ vấn đề tôi đã gặp phải!

Trong dự án **Dolphin Shopkit**, mô hình dữ liệu bao gồm `Collection (Bộ sưu tập)` và
`Product (Sản phẩm)`. Đây là mối quan hệ many-many, Một bộ sưu tập có nhiều sản phẩm, một sản phẩm
thuộc nhiều bộ sưu tập.

Nhu cầu của tôi là: **thay đổi thứ tự hiển thị các sản phẩm này trong bộ sưu tập**. Tâm sự một chút thì
đây là lần đầu tiên tôi làm tính năng kiểu như thế này! Và tôi tin là trong tương lai tôi sẽ còn gặp lại nó.

Bài post như là cách để tôi tra cứu trong tương lai khi cần thiết.

Để dễ hình dung, đây là database schema!

{% include image.html url="/image/posts/2026-09-24-Cach-thay-doi-thu-tu-record-entry-voi-database-postgesql/1.avif" description="Product & Product Variant schema" %}

Hãy chú ý cột `product_display_order` trong bảng `collections_products`.

---
Cách làm sẽ là như sau, tôi sẽ chỉ phương hướng, chút nữa sẽ là mã nguồn để tham khảo.
- Phía UI sẽ có các thao tác `drag-n-drop` (kéo thả), client sẽ gửi lên server danh sách `collection_product_id_list`
với thứ tự mới.
  - ví dụ: `collection_product_id_list: 1004, 1003, 1002, 1001, 1000`.
- Dưới database, sẽ chạy sql query cập nhật tất cả các `collections_products` entry record với giá trị cột `product_display_order`
mới.

| collection_product_id | product_display_order(Cũ) | product_display_order(Mới) |
|-----------------------|---------------------------|----------------------------|
| 1000                  | 1                         | 5                          |
| 1001                  | 2                         | 4                          |
| 1002                  | 3                         | 3                          |
| 1003                  | 4                         | 2                          |
| 1004                  | 5                         | 1                          |

Keyword để tra cứu ở đây là `ORDINALITY (Postgresql)`. Mục tiêu là từ danh sách `collection_product_id` với trật tự mới,
ta sẽ thêm cột dữ liệu tuần tự `product_display_order`.

```sql
SELECT * FROM unnest(array[1004, 1003, 1002, 1001, 1000]::bigint[])
WITH ORDINALITY AS t(collection_product_id, product_display_order)
```

| collection_product_id | product_display_order |
|-----------------------|-----------------------|
| 1004                  | 1                     |
| 1003                  | 2                     |
| 1002                  | 3                     |
| 1003                  | 4                     |
| 1004                  | 5                     |

Tiếp theo ta sẽ update bảng `collections_products`, dựa vào dữ liệu ở bước trên.

```sql
UPDATE collections_products cp
SET product_display_order = x.product_display_order
FROM (SELECT * FROM unnest(array[1004, 1003, 1002, 1001, 1000]::bigint[])
      WITH ORDINALITY AS t(collection_product_id, product_display_order)) as x
WHERE cp.id = x.collection_product_id;
```

Bạn thấy đó, kết quả là chỉ cần duy nhất một câu SQL là giải quyết được bài toán thay đổi thứ tự.

---
Hey, nhưng nếu bạn nghĩ rằng bài viết này vậy là xong thì chưa đâu nhé! Sẽ còn vài điều quan trọng nữa, ít nhất là cho
tôi - người dùng `Phoenix Webframework`, `LiveView` và `SortableJS` để thay đổi vị trí `Product` trong `Collection`

<video controls autoplay muted style="width: 600px;" >
  <source src="/image/posts/2026-09-24-Cach-thay-doi-thu-tu-record-entry-voi-database-postgesql/2.webm" type="video/webm" />
</video>


### [1] Về phía frontend (HTML), đây là code sample, chú ý `phx-hook`

```html
<table>
  <thead>
    <tr>
      <th>#</th>
      <th>Name</th>
      <th>Action</th>
    </tr>
  </thead>
  <tbody id="collection_product_list" phx-hook="AdminCollectionSortableProductHook">
    <tr id={row_id} sortable-collection-product-id={collection_product.id}>
      <td>{collection_product.product_id}</td>
      <td>{collection_product.product_name}</td>
      <td>
        <div class="btn btn-square btn-outline btn-sm border-transparent">
          <span class="iconify lucide--grip-vertical size-4"></span>
        </div>
      </td>
    </tr>
  </tbody>
</table>
```

### [2] Về phía frontend (Javascript), tôi sử dụng `SortableJS` đây là code sample.

```javascript
import Sortable from 'sortablejs';
const AdminCollectionSortableProductHook = {
  mounted() {
    this.sortable = new Sortable(this.el, this.sortableOptions());
  },
  sortableOptions() {
    const hook = this;
    const element = this.el;
    return {
      dataIdAttr: "sortable-collection-product-id",
      handle: ".lucide--grip-vertical",
      onEnd: function(event) {
        const collectionProductIdList = hook.sortable.toArray();
        hook.pushEventTo(element, "reorder_collection_product_list", {
          collection_product_id_list: collectionProductIdList
        });
      }
    }
  },

  destroyed() {
    this.sortable.destroy();
  }

}

export default AdminCollectionSortableProductHook;
```

### [3] Phía LiveView khi `handle_event/3` - `reorder_collection_product_list`

```elixir
def handle_event("reorder_collection_product_list", %{"collection_product_id_list" => collection_product_id_list}, socket) do
  Collections.reorder_collection_product_list(collection_product_id_list)
  {:noreply, socket}
end
```

### [4] Phía Ecto (Database Libary) khi chạy sql query

```elixir
  def reorder_collection_product_list(collection_product_id_list) do
    mod_collection_product_id_list = collection_product_id_list
    |> Enum.map(&String.to_integer/1)
    query = """
     UPDATE collections_products cp
     SET product_display_order = x.product_display_order
     FROM (SELECT * FROM unnest($1::bigint[])
           WITH ORDINALITY AS t(collection_product_id, product_display_order)) as x
     WHERE cp.id = x.collection_product_id;
    """
    Ecto.Adapters.SQL.query(Repo, query, [mod_collection_product_id_list])
  end

```


Credit: để giải quyết bài toán này, tôi đã dùng ChatGPT để hỗ trợ. Nếu không có ChatGPT, khả năng cao
là tôi sẽ mở `database session`, sau đó `update từng dòng một`, rồi `commit session`. Phương pháp sẽ
không thể nào gọn gàng như hiện tại nếu thiếu `ORDINALITY`.

Nhân tiện, từ khi tôi triển khai tính năng này đến thời điểm viết bài cũng cả tháng rồi, tuy nhiên, rất
khó nhớ. Tôi viết blog cũng vì lý do này, mỗi lần viết là lại thêm một lần nhớ, `ORDINALITY` này rất
thú vị, để quên thì thật đáng tiếc.

## Reference List
- SortableJS, [https://sortablejs.github.io/Sortable/](https://sortablejs.github.io/Sortable/)
- Postgresql, Table functions, [https://www.postgresql.org/docs/current/queries-table-expressions.html](https://www.postgresql.org/docs/current/queries-table-expressions.html) 🥲
