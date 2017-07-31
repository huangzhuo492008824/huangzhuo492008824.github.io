---
author: huangzhuo
comments: true
date: 2016-09-07 01:26:12+00:00
layout: post
slug: python-format%e7%94%a8%e6%b3%95
title: python format用法
wordpress_id: 236
categories:
- python
tags:
- python
---
{% include JB/setup %}









**阅读目录**






 	
  * 语法

 	
  * 通过位置

 	
  * 通过关键字

 	
  * 通过对象属性

 	
  * 通过下标

 	
  * 填充和对齐

 	
  * 精度和类型f

 	
  * 进制转化

 	
  * 千位分隔符





python自2.6后，新增了一种格式化**字符串**函数str.format()，威力十足，可以替换掉原来的%

**注**：以下操作版本是python2.7


## 映射示例







### 语法


通过{} 和 :  替换 %





### 通过位置






```
>>> '{0} is {1}'.format('jihite', '4 years old')
'jihite is 4 years old'
>>> '{0} is {1} {0}'.format('jihite', '4 years old')
'jihite is 4 years old jihite'
```




通过format函数可以接受不限参数个数、不限顺序





### 通过关键字






```
>>> '{name}:{age}'.format(age=4,name='jihite')
'jihite:4'
>>> '{name}:{age}'.format(age=4,name='jihite',locate='Beijing')
'jihite:4'
```




format括号内用=给变量赋值





### 通过对象属性









```
>>> class Person:
...     def __init__(self, name, age):
...         self.name,self.age = name, age
...     def __func__(self):
...         return "This guy is {self.name}, is {self.age} old".format(self=self)
... 
>>> s =Person('jihite', 4)
>>> s.__func__()
'This guy is jihite, is 4 old'
```









### 通过下标






```
>>> '{0[0]} is {0[1]} years old!'.format(['jihite', 4])
'jihite is 4 years old!'
>>> '{0} is {1} years old!'.format('jihite', 4)
'jihite is 4 years old!'
```




其实就是通过位置


## 格式限定符


通过{} : 符号





### 填充和对齐


^<>分别表示居中、左对齐、右对齐，后面带宽度







```
>>> '{:>10}'.format('jihite')
'    jihite'
>>> '{:<10}'.format('jihite')
'jihite    '
>>> '{:^10}'.format('jihite')
'  jihite  '
```









### 精度和类型f


精度常和f一起使用




```
>>> '{:.2f}'.format(3.1415)
'3.14'
>>> '{:.4f}'.format(3.1)
'3.1000'
```









### 进制转化









```
>>> '{:b}'.format(10)
'1010'
>>> '{:o}'.format(10)
'12'
>>> '{:d}'.format(10)
'10'
>>> '{:x}'.format(10)
'a'
```




其中b o d x分别表示二、八、十、十六进制





### 千位分隔符









```
>>> '{:,}'.format(1000000)
'1,000,000'
```

>>> '{:,}'.format(100000.23433)
'100,000.23433'

```
>>> '{:,}'.format('abcedef')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: Cannot specify ',' with 's'.
```




这种情况只针对数字


