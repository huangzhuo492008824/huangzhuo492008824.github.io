---
author: huangzhuo
comments: true
date: 2016-12-21 08:37:53+00:00
layout: post
slug: django%e4%b8%adurl%e8%b7%af%e5%be%84%e7%9a%84%e9%97%ae%e9%a2%98
title: Django中url路径的问题
wordpress_id: 284
categories:
- django
- python
tags:
- django
- python
---
 

Django url路径的问题：

```

url(r'courses$', views.CourseListView.as_view()), 
url(r'trainers/(?P[\d]+)/courses$', views.TrainerCourseListView.as_view()), 

```

匹配第二条url的时候会匹配到第一条的url，然后直接返回第一条url对应视图的数据

解决方法：
1. 第二条调整到第一条之前；
2. 第二条修改courses为course；

