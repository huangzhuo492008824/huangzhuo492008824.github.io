---
author: huangzhuo
comments: true
date: 2017-05-25 07:38:27+00:00
layout: post
slug: matplotlib-runtimeerror-python-is-not-installed-as-a-framework-%e9%94%99%e8%af%af%e8%a7%a3%e5%86%b3%e6%96%b9%e6%a1%88
title: 'matplotlib RuntimeError: Python is not installed as a framework 错误解决方案'
wordpress_id: 317
categories:
- python
tags:
- framework
- python
- RuntimeError
---

在virtualenv环境下使用matplotlib绘图时遇到了这样的问题：

>>> import matplotlib.pyplot as plt
Traceback (most recent call last):
File "", line 1, in 
...

in 
from matplotlib.backends import _macosx
RuntimeError: Python is not installed as a framework. The Mac OS X backend will not be able to function correctly if Python is not installed as a framework. See the Python documentation for more information on installing Python as a framework on Mac OS X. Please either reinstall Python as a framework, or try one of the other backends. If you are Working with Matplotlib in a virtual enviroment see 'Working with Matplotlib in Virtual environments' in the Matplotlib FAQ

 

似乎是因为虚拟环境与默认环境的安装配置不同造成的。

搜索错误信息之后，在STO上找到了解决方案：

 

1、pip安装matplotlib之后，会在根目录下产生一个.matplotlib的目录:

➜ bin ll ~/.matplotlib
total 280
-rw-r--r-- 1 me staff 78K 10 4 2015 fontList.cache
-rw-r--r-- 1 me staff 59K 1 17 15:56 fontList.py3k.cache
drwxr-xr-x 2 me staff 68B 10 4 2015 tex.cache

 

2、在这个目录下创建一个名为matplotlibrc的文件，内容是：

backend: TkAgg

然后保存退出，重启Python交互界面或重新运行脚本，import正常执行。

 

STO答案地址：http://stackoverflow.com/questions/21784641/installation-issue-with-matplotlib-python

 
