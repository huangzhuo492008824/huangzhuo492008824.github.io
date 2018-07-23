---
author: huangzhuo
comments: true
date: 2016-08-09 08:53:37+00:00
layout: post
slug: python%e4%b8%ad%e5%af%86%e7%a0%81%e7%9a%84%e4%bf%9d%e5%ad%98
title: python中密码的保存和token的生成验证itsdangerous模块
wordpress_id: 147
categories:
- python
tags:
- itsdangerous
- python
- token
- 数字
- 签名
- 过期
---
 

密码的保存：

```
import hashlib

hashlib.sha1(config.SECRET_KEY+password).hexdigest()

```

token的生成和保存：

```
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer, BadSignature, SignatureExpired

class QXToken(object):
"""
生成/验证　用户token
"""
    def __init__(self, name):
        self.name = name

    def generate_auth_token(self, expiration=3600):
        s = Serializer(config.SECRET_KEY, expires_in=expiration)
        return s.dumps({'name': self.name})

    def verify_auth_token(self, token):
        s = Serializer(config.SECRET_KEY)
        try:
            data = s.loads(token)
            print 'data:', data
        except SignatureExpired:
            return 0 # valid token, but expired
        except BadSignature:
            return -1 # invalid token
        return data['name'] == self.name

#生成token
qxtoken = QXToken('name')
token = qxtoken.generate_auth_token()

#验证token
q = QXToken('name')
res = q.verify_auth_token()

```

