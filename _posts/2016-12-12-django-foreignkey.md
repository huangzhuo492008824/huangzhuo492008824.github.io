---
author: huangzhuo
comments: true
date: 2016-12-12 12:01:00+00:00
layout: post
slug: django%e4%b8%ad%e4%b8%bb%e5%a4%96%e9%94%ae%e5%85%81%e8%ae%b8%e4%b8%ba%e7%a9%ba
title: django中主外键允许为空
wordpress_id: 280
categories:
- django
tags:
- django
- django rest framework
- python
---
{% include JB/setup %}

django model设计中必不可少一对多和多对多的关系：关系中有允许为空的情况，实用django rest framework时多对多的情况有所不同：

```
questions = models.ManyToManyField(Question, help_text=u'试卷关联的问题', blank=True)
```


```
project = models.ForeignKey(Project, related_name='courses', null=True)
多对多必须指定blank字段为True否则创建的时候会报错。
```


```



```

```


