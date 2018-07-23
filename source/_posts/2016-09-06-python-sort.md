---
author: huangzhuo
comments: true
date: 2016-09-06 14:55:08+00:00
layout: post
slug: python%e4%b8%8b%e6%8e%92%e5%ba%8f%e6%80%bb%e7%bb%93
title: python下排序总结
wordpress_id: 234
categories:
- python
tags:
- python
---
 

对字典组成的列表进行排序：

```

my_list = [{'a':1, 'b':'ccc'}, {'a':-1, 'b':'zzz'}]
my_list.sort(key=lambda x: x['a'], reverse=False)
print my_list
In [9]:  [{'a': -1, 'b': 'zzz'}, {'a': 1, 'b': 'ccc'}]

```


python标准库中的有序字典可以对字典进行排序：
class collections.OrderedDict([items])

   注意顺序以添加顺序为准，和修改的顺序无关。

   特殊方法：OrderedDict.popitem(last=True) 。last为True是LIFO,即为堆栈，反之是FIFO，即为队列。还支持排序： reversed() .
