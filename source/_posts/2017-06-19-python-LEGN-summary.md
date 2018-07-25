---
date: 2017-06-19 12:49:12+00:00
tags: [python,legn]
title: Python LEGN作用域总结
categories:
- python
---

LEGB规则

Python2.2开始引入嵌套函数，嵌套函数为python提供了闭包实现。

```


a = 1
def foo():
   a = 2
   def bar():
        print a  //[1]
    return bar
 
func = foo()
func()

```

函数bar和a=2捆包在一起组成一个闭包，因此这里a=2即使脱离了foo所在的local作用域，但调用func的时候（其实就是调用bar）查找名字a的顺序是LEGB规则，这里的E就是enclosing的缩写，代表的“直接外围作用域”这个概念。查找a时，在bar对应的local作用域中没有时，然后在它外围的作用域中查找a。LEGB规定了查找一个名称的顺序为：local–>enclosing–>global–>builtin。
