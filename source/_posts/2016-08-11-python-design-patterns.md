---
date: 2016-08-11 06:41:04+00:00
title: Python中的几种设计模式
categories:
- 技术
tags:
- python
---
 
1. 单例模式：
法一：通过类的__new__()方法，但是个人感觉没有装饰器方便

``` python
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

2. 用装饰器来实现
``` python
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
