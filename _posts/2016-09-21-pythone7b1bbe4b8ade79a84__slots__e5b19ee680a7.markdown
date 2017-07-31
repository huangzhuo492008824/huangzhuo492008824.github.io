---
author: huangzhuo
comments: true
date: 2016-09-21 14:45:52+00:00
layout: post
slug: python%e7%b1%bb%e4%b8%ad%e7%9a%84__slots__%e5%b1%9e%e6%80%a7
title: python类中的__slots__属性
wordpress_id: 249
categories:
- python
tags:
- python
- 面向对象
---
{% include JB/setup %}

## 一句话说明


`__slots__
```
 是用来限制实例的属性的， `__slots__
```
 可以规定实例是否应该有 `__dict__
```
 属性； `__slots__
```
 不能限制类的属性。


## 只有__slots__列表内的这些变量名可赋值为实例属性。




```
class A:
    __slots__=['name']
    def __init__(self):
        self.name='js'
        self.age=22
a=A()

```

运行结果：

```
Traceback (most recent call last):
  File "a.py", line 6, in 
    a=A()
  File "a.py", line 5, in __init__
    self.age=22
AttributeError: 'A' object has no attribute 'age'
```



## __slots__只是限制实例，对类对象没有影响




```
class A:
  __slots__=['name','city']
  age=22
  def __init__(self):
    self.name='js'
a=A()
print('A __slots__: ', A.__slots__)
print('a __slots__: ', a.__slots__)
print('A __dict__: ', A.__dict__)
print('a __dict__: ', a.__dict__)

```

运行结果如下：

```
A __slots__:  ['name', 'city']
a __slots__:  ['name', 'city']
#事实上，所有定义在__slots__中的属性都会放置在类的__dict__当中，即使没有使用的属性(city)也是如此。
#而当实例需要取对象时，总是会先到类的__dict__中进行检查，如果类的__dict__中的属性是一个对象且该对象对属性的读取做了一些限制，那么就会直接影响到实例是否能够调用该属性。__slots__的工作原理是如此，后面介绍的描述符类亦是如此。
#在类的__dict__中，也会存入__slots__属性。
A __dict__:  {'age': 22, '__init__': , 'name': <member 'name' of 'A' objects>, 'city': <member 'city' of 'A' objects>, '__slots__': ['name', 'city'], '__module__': '__main__', '__doc__': None}
#当我们试图调用a.__dict__时，出现错误，因为该属性没有出现在__slots__中，所以禁止赋值或者访问。
Traceback (most recent call last):
  File "a.py", line 10, in 
    print('a __dict__: ', a.__dict__)
AttributeError: 'A' object has no attribute '__dict__'
```



## 可以同时存在__slots__和__dict__吗？






可以，如果把 `__dict__
```
 属性存入 `__slots__
```
 中，那么就允许使用 `__dict__
```
属性了。

这时，如果所有 `__slots__
```
 中定义的属性存在 `__slots__
```
 中，如果没有定义的属性，那么存在 `__dict__
```
 中，从而实现属性的分别管理。

dir函数获取所有定义在 `__slots__
```
 和 `__dict__
```
 中的属性。或者通过list(getattr(X, ' **dict** ', [])) + getattr(X, ' **slots** ', [])来得到所有的属性。





```
class A:
  __slots__=('name','city','__dict__')
  def __init__(self):
    self.name='js'
    self.age=22
a=A()
print('A __slots__: ', A.__slots__)
print('a __slots__: ', a.__slots__)
print('A __dict__: ', A.__dict__)
print('a __dict__: ', a.__dict__)

```

运行结果如下：

```
A __slots__: ('name', 'city', '__dict__')
a __slots__: ('name', 'city', '__dict__')
#连__dict__都会保存在类的__dict__中，且属性值是一个object。
A __dict__: {'city': <member 'city' of 'A' objects>, 'name': <member 'name' of 'A' objects>, '__module__': '__main__', '__doc__': None, '__init__': , '__slots__': ('name', 'city', '__dict__'), '__dict__': <attribute '__dict__' of 'A' objects>}
#由于现在age没有出现在__slots__中，且允许存在__dict__，所以属性age出现在实例本身的__dict__中。
a __dict__: {'age': 22}

```

如果子类中没有__slots__，但是超类中有

```
class Super:
__slots__=['name']
pass
class Sub(Super):
def __init__(self):
self.name='js'
self.age=22
a=Sub()
print('Sub __slots__: ', Sub.__slots__)
print('a __slots__: ', a.__slots__)
print('Sub __dict__: ', Sub.__dict__)
print('a __dict__: ', a.__dict__)

```

运行结果如下：

```
#顺利继承到了Super的__slots__属性
Sub __slots__:  ['name']
a __slots__:  ['name']
#此时Python用了大量的黑暗魔法，这时我们看到Sub的__dict__中居然出现了__dict__属性，且值为特殊的对象，相当于Sub.__slots__=Super.__slots__+['__dict__']，从而实现如果在__slots__中出现的属性存在__slots__中，没有出现的存在Sub的实例的__dict__中。
Sub __dict__:  {'__module__': '__main__', '__dict__': <attribute '__dict__' of 'Sub' objects>, '__weakref__': <attribute '__weakref__' of 'Sub' objects>, '__doc__': None, '__init__': }
#我们确实看到了age存在了子类的实例的__dict__中。
a __dict__:  {'age': 22}


```



## 如果子类和父类都有__slots__...



```
class Super:
    __slots__=['name','age']
class Sub(Super):
    __slots__=['city']
print('Sub __slots__: ', Sub.__slots__)
print('Sub __dict__: ', Sub.__dict__)

#父类中的__slots__没有对子类产生影响
Sub __slots__:  ['city']
#再次证明了上面的说法，如果一定需要父类的__slots__进行叠加，那么需要手动设置为__slots__=Super.__slots__ + ['city']，所以可以看出Python通过了大量的黑暗魔法，从而达到__slots__不具有常规的继承特性。
Sub __dict__:  {'__slots__': ['city'], '__module__': '__main__', 'city': <member 'city' of 'Sub' objects>, '__doc__': None}


```



## 如果一个子类继承自一个没有__slots__的超类...






如果一个子类继承自一个没有__slots **的超类，那么超类的** dict **属性总是可以访问的，使得子类中的一个** slots__无意义。

留给你自己验证一下吧。






## 总结





 	
  1. `__slots__
```
 用来设计成对实例的 `__dict__
```
 的限制，只有 `__dict__
```
 出现在 `__slots__
```
 中，实例才会有 `__dict__
```
 属性。
否则，只有出现在 `__slots__
```
 中的属性才可以被使用。

 	
  2. Python特意设计成 `__slots__
```
 没有常规的继承特性，所以只有超类具有 `__slots__
```
 且其 `__dict__
```
 属性没有出现在其中，这时子类的 `__slots__
```
 才有意义，且子类的 `__slots__
```
 不继承父类的 `__slots__
```
 。


