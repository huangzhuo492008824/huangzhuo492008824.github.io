---
author: huangzhuo
comments: true
date: 2017-04-18 02:52:32+00:00
layout: post
slug: casperjs%e4%bc%a0%e5%8f%82
title: casperjs传参
wordpress_id: 311
categories:
- 爬虫
tags:
- casperjs
- 爬虫
---

casperjs传递动态参数：

```

var casper = require('casper').create({
    pageSettings: {
     javascriptEnabled: true ,
     loadImages: true,
     loadPlugins: true,
     userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36'
    },
    // logLevel: "debug",//日志等级
    // verbose: true,  // 记录日志到控制台
     viewportSize: {width: 1024, height: 768}
});

var args2 = casper.cli.args;

var NET_SessionId = args2[0];
var EhireGuid = args2[1];
var AccessKey = args2[2];
var HRUSERINFO = args2[3];

```


