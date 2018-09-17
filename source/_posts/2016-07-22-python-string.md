---
date: 2016-07-22 09:54:44+00:00
title: Python字符串的问题
categories:
- 技术
tags:
- python
---
* 普通字符串可以用多种方式编码成Unicode字符串，具体要看你究竟选择了哪种编码：

``` python 
unicodestring = u"Hello world" 
#### 将Unicode转化为普通Python字符串："encode" 
utf8string = unicodestring.encode("utf-8") 
asciistring = unicodestring.encode("ascii") 
isostring = unicodestring.encode("ISO-8859-1") 
utf16string = unicodestring.encode("utf-16") 
```

### 将普通Python字符串转化为Unicode："decode" 
``` python
plainstring1 = unicode(utf8string, "utf-8") 
plainstring2 = unicode(asciistring, "ascii") 
plainstring3 = unicode(isostring, "ISO-8859-1") 
plainstring4 = unicode(utf16string, "utf-16") 
```
