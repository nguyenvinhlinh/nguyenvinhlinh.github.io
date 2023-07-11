---
layout: post
title: Excel file, replace special character single quotes which besides numbers
date: 2015-11-27 15:19:47 +0700
categories: etc
tag: spreadsheet, gem, ruby, exel
---

I have work with spreadsheet gem on ruby, Sometime I do realize that in the
LibreOffice, the content is something like `'24%`, the character single quote
refers to a string. However, I want a number instead. A possible way to convert
them without programming is *Find and Replace*. However it does not easy as I
say because the character `'` is a special character in LibreOffice, you have to
use regular expression to work with this.

There is a solution to convert string to number in such case is using replace
function name `Find and Replace C-h` in LibreOffice. In the `Search for` text,
type `^.`; in the `Replace with`, type `$`. In the other options, please tick on
`Regular expressions`. Finally, you can choose replace or replace all.
