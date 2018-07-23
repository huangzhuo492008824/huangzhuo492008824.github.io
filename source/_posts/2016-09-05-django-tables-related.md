---
author: huangzhuo
comments: true
date: 2016-09-05 11:28:32+00:00
layout: post
slug: django%e4%b8%ad%e7%9a%84%e5%a4%9a%e5%ad%97%e6%ae%b5%e5%a4%96%e9%94%ae%e5%85%b3%e8%81%94%e5%90%8c%e4%b8%80%e5%bc%a0%e8%a1%a8
title: django中的多字段外键关联同一张表
wordpress_id: 231
categories:
- django
- python
tags:
- django
- python
---
 

django中的多字段外键关联同一张表时会报一个错误：

```

SystemCheckError: System check identified some issues:  
account.Fans.fans: (fields.E304) Reverse accessor for 'Fans.fans' clashes with reverse accessor for 'Fans.user'.
        HINT: Add or change a related_name argument to the definition for 'Fans.fans' or 'Fans.user'.
account.Fans.user: (fields.E304) Reverse accessor for 'Fans.user' clashes with reverse accessor for 'Fans.fans'.
        HINT: Add or change a related_name argument to the definition for 'Fans.user' or 'Fans.fans'.

```

解决方法：将同一个表中的releated_name，全部修改，指定不一样的releated_name

```

@python_2_unicode_compatible
class Fans(BaseModel):
    user = models.ForeignKey(User, verbose_name=u"用户ID", related_name=u'用户ID')
    fans = models.ForeignKey(User, verbose_name=u"粉丝ID", related_name=u'粉丝ID')

    def __str__(self):
        return str(self.user.id)

    class Meta:
        db_table = 'fans'
        verbose_name = u"粉丝表"
        verbose_name_plural = u"粉丝表"

```


