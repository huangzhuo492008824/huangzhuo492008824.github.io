---
author: huangzhuo
comments: true
date: 2018-06-14 9:49:32+00:00
layout: post
slug: django python migrate
title: django migrate
---

### django migrate
```python
# 删除本地migrate文件
rm apps/*/migrations/*.py
python manage.py migrate recruitment --fake-initial
python manage.py makemigrations recruitment
python manage.py migrate recruitment

```

* –fake-inital 会在数据库中的 migrations表中记录当前这个app 执行到 0001_initial.py ，但是它不会真的执行该文件中的 代码。 这样就做到了，既不对现有的数据库改动，而又可以重置 migraion 文件