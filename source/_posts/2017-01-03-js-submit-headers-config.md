---
author: huangzhuo
comments: true
date: 2017-01-03 10:54:21+00:00
layout: post
slug: js%e6%8f%90%e4%ba%a4%e6%95%b0%e6%8d%ae%e7%9a%84headers%e8%ae%be%e7%bd%ae
title: js提交数据的headers设置
wordpress_id: 299
categories:
- django
- python
tags:
- python
- 前端js
---

JS通过ajax提交post数据有两种方式：Request Payload 和 Form Data，具体的区分可以通过设置请求头的Content-Type来确定：

需要Form Data方式提交数据可以设置headers = {'Content-Type':'application/x-www-form-urlencoded'}

需要Request Payload方式提交数据可以设置headers = {'contentType':'text/plain;charset=UTF-8'}
