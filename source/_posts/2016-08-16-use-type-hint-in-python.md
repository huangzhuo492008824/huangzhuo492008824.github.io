---
author: huangzhuo
comments: true
date: 2016-08-16 09:26:14+00:00
layout: post
slug: '%e5%88%a9%e7%94%a8type-hint%e6%8f%90%e5%8d%87python%e7%a8%8b%e5%ba%8f%e5%bc%80%e5%8f%91%e6%95%88%e7%8e%87'
title: 利用Type Hint提升Python程序开发效率
wordpress_id: 178
categories:
- python
tags:
- python
---
 


					
 
 
  

Type Hint（或者叫做PEP-484）提供了一种针对Python程序的类型标注标准。


  

为什么使用Type Hint？对于动态语言而言，常常出现的情况是当你写了一段代码后，隔段时间你可能忘记这个方法的原型是什么样子的了，你也不清楚具体应该传入什么类型的参数，这样往往需要你去阅读代码才能定义每个类型具体是什么。或者当你使用一个文档并不是特别完全的第三方库，你不知道这个库应该如何使用，这都会很痛苦。


  

现在，借助Type Hint，你可以实现：


  


   
  * 实现类型检查，防止运行时出现的类型不符合情况。

   
  * 作为文档附加属性，方便开发者调用时传入传出的参数类型。

   
  * 提升IDE的检查机制，在智能提示时更快给出提示和类型检查结果。

   
  

实现这个过程中，你需要使用`Python 3.5+
```
中提供的新模块[`typing
```
](https://docs.python.org/3.5/library/typing.html)。值得注意的是，这个改动并不会影响程序运行，仅仅是为了方便类型检查器实现的。


  

## Type Hint类型检查器


  

目前，比如`JetBrains
```
家的`PyCharm
```
已经支持Type Hint语法检查功能，如果你使用了这个IDE，可以通过IDE功能进行实现。如果你像我一样，使用了SublimeText编辑器，那么第三方工具[`mypy
```
](https://github.com/python/mypy)可以帮助到你。`AnacondaST3
```
最近要发布的2.0版本也内置了`mypy
```
功能的支持，具体的进度可以看一下[这个issue](https://github.com/DamnWidget/anaconda/issues/439)。一些其它的Python工具(比如[代码提示工具jedi 0.10+](https://github.com/davidhalter/jedi/pull/661))也支持了Type Hint功能。


  

## 从简单的例子开始


  

从简单的例子开始，我们先从一个简单的程序开始，运行环境为`Python 3.5.2
```
，使用`mypy
```
工具进行检查。


  

首先通过`pip install mypy-lang
```
命令安装`mypy
```
工具。注意是`mypy-lang
```
，之所以是这样，是因为在`pypi
```
里`mypy
```
这个名字已经被占用掉了。


  

接下来，通过`mypy
```
检查下面这个文件


  
```

```language-python hljs 
# fib.py
from typing import Iterator


def fib(n: int) -> Iterator[int]:
    a, b = 0, 1
    while a < n:
        yield a
        a, b = b, a + b

i = fib(3.2)
print(next(i))
print(next(i))

```

```
 
  

在命令行中执行命令`mypy fib.py
```
，获取返回结果：


  
```

```language-python hljs 
➜ mypy fib.py
fib.py:11: error: Argument 1 to "fib" has incompatible type "float"; expected "int"

```

```
 
  

但是在实际的应用过程中，这个功能在Python里是可以正常运行的：


  
```

```language-python hljs 
➜  mypy python fib.py
0
1

```

```
 
  

可以看到，mypy工具提示了我们的代码中存在一处类型不匹配的问题，但是如果不进行检查，代码有可能执行出不可预知的结果。


  

在这个例子里面，我们使用了两种类型，一种是Python基础数据类型，比如`str
```
、`int
```
等等，这些类型数据是可以直接使用的；另外一种是来自于`typing
```
中引入的`Iterator
```
，用来表示迭代器类型。另外一个值得注意的是，`typing
```
中部分类型也会随时添加，一般我们以演示版本为准。


  

## 从简单到复杂，类型组合怎么办？


  

实际上，在我们使用过程中还有可能传递一些更加复杂的参数类型，比如list类型，tuple类型等等，这类型的数据如何声明呢？我们可以先看一个例子：


  
```

```language-python hljs 
def foo(strings, string_list, count, total):

```

```
 
  

这个函数的参数我们从字面可以看出来分别是`str
```
，元素为`str
```
的`list
```
类型和两个整数参数。我们假定一个返回值为`((int, int), str)
```
，那么这个类型检查可以这样定义：


  
```

```language-python hljs 
from typing import List, Tuple

Result = Tuple[Tuple[int, int], str]

def foo(strings: str, lines: List[str],  line_number: int, total_lines: int) -> Result:

```

```
 
  

其它的一些类型提示、协程等等的支持都可以在官方的[`typing
```
模块文档](https://docs.python.org/3.5/library/typing.html)中进行查看。


  

## 关于生产的一些闲扯


  

我们现在也在进行一些`mypy
```
工具在生产环境中的具体使用测试，但是我们也发现了一些存在的问题，比如`Python
```
本身的动态语言特性给类型标注就带来了一些麻烦。另外，变量复用导致的类型变换有可能会提示采用新的变量实现。这对于一个已经存在的线上项目来说相对成本较高，我们后续也会在一些新项目中采用这种方式。另外`mypy
```
还是一个比较新的项目，本身是拥有一些bug。另外一个是在某些`mypy
```
的非类型错误提示其实非常的模糊，导致很多错误有时需要进行人工排查。


  

不管怎样，即便在`mypy
```
存在一些缺陷，但是仍旧是未来非常有潜力的工具，提前了解和应用也能有效的提升程序的强壮性。


  


  

来自：https://ipfans.github.io/2016/07/type-hint-improve-python-programming/


  


 

				
