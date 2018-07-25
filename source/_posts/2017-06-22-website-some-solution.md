---
date: 2017-06-22 07:49:32+00:00
title: web站点相关解决方案
categories: python
tags:
- django rest framework
- python
---


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


