---
layout: post
title: "How to generate UUID in Libreoffice Calculator/Excel?"
date: 2025-07-10 10:03:22
update:
location: Saigon
tags:
- libreoffice
- uuid
categories: etc
seo_description: Generating UUID for LibreOffice
seo_image: /image/posts/2025-07-10-How-to-generate-uuid-in-libreoffice-calculator/seo.png
comments: true
---

{% include image.html url="/image/posts/2025-07-10-How-to-generate-uuid-in-libreoffice-calculator/1.png" description="LibreOffice Calc & UUID formula" %}

In this post, I would like to make a note about generating UUID in Libreoffice Calc/Excel.

```
=LOWER(CONCATENATE(DEC2HEX(RANDBETWEEN(0,4294967295),8),"-",DEC2HEX(RANDBETWEEN(0,65535),4),"-",DEC2HEX(RANDBETWEEN(0,65535),4),"-",DEC2HEX(RANDBETWEEN(0,65535),4),"-",DEC2HEX(RANDBETWEEN(0,4294967295),8),DEC2HEX(RANDBETWEEN(0,65535),4)))
```

# References
- How to generate a column of unique IDs (UUIDs) in LibreOffice Calc?, 2022, Jan 11, mYnDstrEAm, [https://superuser.com/q/1698721](https://superuser.com/q/1698721)
- How to create a GUID in Excel? 2013, Feb 20, Konrad Viltersten, StackOverflow, [https://stackoverflow.com/a/41026697](https://stackoverflow.com/a/41026697)
