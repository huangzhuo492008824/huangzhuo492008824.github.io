---
date: 2018-3-28 11:49:32+00:00
categories: 爬虫
tags: [cookie, 爬虫]
title: 获取http only数据
---

###nightmare


A Conservative
Published
November 19, 2016
in JavaScript
爬虫的终极形态：nightmare
nightmare 是一个基于 electron 的自动化库（意思是说它自带浏览器），用于实现爬虫或自动化测试。相较于传统的爬虫框架（scrapy/pyspider），或者dom操作库（cheerio/jsdom），或者基于浏览器的自动化框架（selenium/phantomjs），他的优势在于提供了一个简洁有效 的编程模型。

###安装
``` shell
 npm install init -y 
 npm install --save-dev spectron
 npm install --save nightmare
 npm run dev
```
###获取cookie
``` javascript
option = {
openDevTools: {
      mode: 'bottom',       // 开发者工具位置：right, bottom, undocked, detach
},
  show: true,                 // 要不要显示浏览器
  dock: true,                 // 要不要在Dock上显示图标
  waitTimeout: 6000000,         // .wait() 方法超时时长，单位:ms
  executionTimeout: 86400000, // .evaluate() 方法超时时长，单位:ms

}
let Nightmare = require('nightmare');

const nightmare = Nightmare(option);

nightmare.goto('https://baidu.com/')
  .evaluate(() => {
    return document.title;
  })
  .wait('#MainMenuNew1_m3')
  //.cookies.get({ url: null })
  .cookies.get({
     domain: 'baidu.com'
  })
  .then((cookies) => {
    console.log(cookies);
    console.log('加载完成');
  })
  ```