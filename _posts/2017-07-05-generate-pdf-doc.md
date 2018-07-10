---
author: huangzhuo
comments: true
date: 2017-07-05 02:32:47+00:00
layout: post
slug: '%e7%94%9f%e6%88%90pdf%e6%96%87%e6%a1%a3'
title: 生成PDF文档
wordpress_id: 330
categories:
- 其它
tags:
- PDF
---
{% include JB/setup %}

主要使用pdfkit模块：
1.安装pdfkit：

```

$ pip install pdfkit
$ sudo apt-get install wkhtmltopdf

```



使用pdfkit的一些高级功能需要研究wkhtmltopdf的一些功能：
Warning! Version in debian/ubuntu repos have reduced functionality (because it compiled without the wkhtmltopdf QT patches), such as adding outlines, headers, footers, TOC etc. To use this options you should install static binary from wkhtmltopdf site or you can use this script.

使用高级功能需要执行以下脚本：

```

#!/bin/sh
sudo apt-get install -y openssl build-essential xorg libssl-dev
wget http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2
tar xvjf wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2
sudo chown root:root wkhtmltopdf-amd64

```


2.基本原理功能：
Pdfkit文档链接：https://pypi.python.org/pypi/pdfkit
Pdfkit可以渲染url，file，string 成pdf文档，也支持多个file生产一个pdf文档

Notices：
1. pdf正文部分字体调整： css部分：@font-face {	}中添加font-family等字体属性；
2. 页脚的添加： views.py中 print_entrust()函数中options{}字典里边添加footer-center等属性；

