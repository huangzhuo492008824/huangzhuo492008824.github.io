---
author: huangzhuo
comments: true
date: 2017-09-12 17:49:32+00:00
layout: post
slug: python for else
title: python for else
---
``` python
>>> for i in range(0,10):
        if i > 10:
            break;
    else:
        print "hello world";
输出：hello world
>>> for i in range(0,10):
        if i > 5:
            break;
    else:
        print "hello world";
 
没有输出
-------------------
```
即在for 循环中，如果没有从任何一个break中退出，则会执行和for对应的else
只要从break中退出了，则else部分不执行。
