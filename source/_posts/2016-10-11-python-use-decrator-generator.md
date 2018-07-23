---
author: huangzhuo
comments: true
date: 2016-10-11 15:34:00+00:00
layout: post
slug: python%e4%b8%ad%e8%a3%85%e9%a5%b0%e5%99%a8%ef%bc%8c%e8%bf%ad%e4%bb%a3%e5%99%a8%e5%92%8c%e7%94%9f%e6%88%90%e5%99%a8
title: Python中装饰器，迭代器和生成器
wordpress_id: 265
categories:
- 其它
---
 

Python中的装饰器被用于有切面（AOP）需求的场景，如插入日志、性能测试、事务处理等
测试函数的执行时间：

```
def test_runtime(func):
    def _deco():
        start = time.time()    
        func()  
        end = time.time()       
        print 'time:', end-start
    return _deco 

@test_runtime
def gen():
    for i in range(100000000):
        pass
    print 'AAAAAAAAAAAAAAAA'

gen()

```


