---
date: 2016-10-11 15:34:00+00:00
title: Python中装饰器，迭代器和生成器
categories:
- 其它
tags: [python]
---
 

Python中的装饰器被用于有切面（AOP）需求的场景，如插入日志、性能测试、事务处理等
测试函数的执行时间：

``` python
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


