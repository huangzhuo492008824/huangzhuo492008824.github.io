---
date: 2018-08-6 18:19:00+00:00
categories: python
title: python爬虫利器requests_html
tags: [python, 爬虫, requests_html]
---
### requests_html：
* python大神kenneth reitz小哥哥的又一爬虫神器(上次是requests)，官网给出的我这渣渣英语就不翻译了，内容如下：
- Full JavaScript support!
- CSS Selectors (a.k.a jQuery-style, thanks to PyQuery).
- XPath Selectors, for the faint at heart.
- Mocked user-agent (like a real web browser).
- Automatic following of redirects.
- Connection–pooling and cookie persistence.
- The Requests experience you know and love, with magical parsing abilities.

1. 安装：
``` shell
pip3 install requests-html
# requests-html必须3.6以上的python版本
```

2. 使用：
``` python
from requests_html import HTMLSession
session = HTMLSession()
r = session.get('https://python.org/')
# 获取页面所有链接
r.html.links
# 获取页面所有链接的绝对地址
r.html.absolute_links
# {'https://github.com/python/pythondotorg/issues', ...}

# Select an Element with a CSS Selector 
about = r.html.find('#about', first=True)

# Introspect an Element’s attributes (learn more):
>>> about.attrs
{'id': 'about', 'class': ('tier-1', 'element-1'), 'aria-haspopup': 'true'}

# Search for text on the page:
>>> r.html.search('Python is a {} language')[0]
programming

# JavaScript Support
>>> r = session.get('http://myhuangzhuo.com/')

>>> r.html.render()

>>> times = r.html.find('#busuanzi_value_site_pv', first=True)
In [7]: times.text
Out[7]: '270 次'

```
* requests_html 对css选择器操作和xpath比较强大，加载简单的带js的页面支持很好；
* js加载需要下载pyppeteer和相关浏览器支持，目前来看在截图和点击模拟用户行为操作方面没有phantomjs强大，功能有待发掘；


