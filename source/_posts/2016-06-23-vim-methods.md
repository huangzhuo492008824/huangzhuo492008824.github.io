---
author: huangzhuo
comments: true
date: 2016-06-23 11:58:59+00:00
layout: post
slug: vim%e5%ae%9e%e7%94%a8%e6%8a%80%e5%b7%a7
title: Vim实用技巧
wordpress_id: 102
categories:
- 技术
tags:
- centos
- centos7
- linux
- python
---
 

#### 指定开始行到结尾行缩进：
``` vim
：2,7>    指定第2到第7行右缩进一个单位
```

vim拷贝指定行到目的行：
``` vim
：30,50 co 20     #copy 30行到50行内容到20行;
```

注释多行:
``` vim
Ctl +v 方向键向下指定行 shift + i  注释符  esc
```

uwsgi依赖与lxml ,  必须先装lxml再装uwsgi

否则会报错
