---
author: huangzhuo
comments: true
date: 2017-01-23 08:27:21+00:00
layout: post
slug: python%e4%b8%ad%e7%9a%84%e4%b8%80%e4%ba%9b%e9%ad%94%e6%b3%95
title: Python中的一些魔法
wordpress_id: 303
categories:
- python
tags:
- Magic
- python
---

1. 将多个序列串放在一起遍历：
``` python
>>> from itertools import chain  
>>> a = [1, 2, 3, 4]  
>>> b = ['a', 'b', 'c']  
>>> for x in chain(a, b):  
...     print(x)  
...   

```

2. python表示昨天的日期：
``` python
#-*-coding:utf-8-*-  
import datetime

def getYesterday():   #
   today=datetime.date.today()  
   oneday=datetime.timedelta(days=1)  
   yesterday=today-oneday   
   return yesterday
```

3. 打印代码出错信息：
``` python
import traceback
traceback.format_exc()
```
traceback.print_exc()跟traceback.format_exc()有什么区别呢？
format_exc()返回字符串，print_exc()则直接给打印出来。
