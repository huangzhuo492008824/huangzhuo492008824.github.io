---
author: huangzhuo
comments: true
date: 2017-06-22 07:49:32+00:00
layout: post
slug: web%e7%ab%99%e7%82%b9%e7%9b%b8%e5%85%b3%e8%a7%a3%e5%86%b3%e6%96%b9%e6%a1%88
title: web站点相关解决方案
wordpress_id: 327
categories:
- django
- python
tags:
- django rest framework
- python
---
{% include JB/setup %}

邮箱或手机验证码存储解决方案：
1. 使用web框架自带的缓存系统，比如django中自带的cache

```

from django.core import cache
cache.set('key', 'value', 10)  #键,值和过期时间
cache.get('key', 'not fount or has expired')

```

2. 使用redis存储:

```

redis_db = RedisDB()
redis_db.set(phone=username, val=code, ex=60*10)

```


