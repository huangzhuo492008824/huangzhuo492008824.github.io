---
author: huangzhuo
comments: true
date: 2016-06-24 01:21:25+00:00
layout: post
slug: python%e4%b8%ad%e4%bd%bf%e7%94%a8args%e5%92%8ckwargs%e8%af%ad%e6%b3%95
title: Python中使用*args和**kwargs语法
wordpress_id: 107
categories:
- 技术
tags:
- python
---
 

可变参数 (Variable Argument) 的方法：使用*args和**kwargs语法。其中，*args是可变的positional arguments列表，**kwargs是可变的keyword arguments字典。并且，*args必须位于**kwargs之前，因为positional arguments必须位于keyword arguments之前。

```

def test_kwargs(first, *args, **kwargs):
   print 'Required argument: ', first
   for v in args:
      print 'Optional argument (*args): ', v
   for k, v in kwargs.items():
      print 'Optional argument %s (*kwargs): %s' % (k, v)

```


使用：

```

def test(a, *args, **kwargs):
    print '------args-------'
    for k in args:
        print k
    print '------kwargs----'
    for k, v in kwargs.items():
        print k, v
test(1, 2, 3, b=7, c=8)

#------args-------
#2
#3
#------kwargs----
#c 8
#b 7

```


