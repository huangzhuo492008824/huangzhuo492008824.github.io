---
author: huangzhuo
comments: true
date: 2016-08-11 06:41:04+00:00
layout: post
slug: python%e4%b8%ad%e7%9a%84%e5%87%a0%e7%a7%8d%e8%ae%be%e8%ae%a1%e6%a8%a1%e5%bc%8f
title: Python中的几种设计模式
wordpress_id: 152
categories:
- 技术
tags:
- python
---
 

1.单例模式：
法一：通过类的__new__()方法，但是个人感觉没有装饰器方便

```

class Singleton(object):
    __instance = None
    
    def __init__(self):
        pass

    def __new__(cls, *args, **kwd):
        if Singleton.__instance is None:
            Singleton.__instance = object.__new__(cls, *args, **kwd)
        return Singleton.__instance

class MyClass(Singleton):
    aa = 88

instance1 = MyClass()
instance2 = MyClass()
print id(instance1)
print id(instance2)

139984856635600
139984856635600


```



法二：用装饰器来实现

```

def singleton(cls, *args, **kw):
    instances = {}
    def _singleton():
        if cls not in instances:
            instances[cls] = cls(*args, **kw)
        return instances[cls]
    return _singleton

@singleton
class MyClass1(object):
    aa = 56
instance1 = MyClass1()
instance2 = MyClass1()
print id(instance1)
#139764123790288
print id(instance2)
#139764123790288

```

