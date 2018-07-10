---
author: huangzhuo
comments: true
date: 2017-04-14 10:32:48+00:00
layout: post
slug: casperjs%e6%88%aa%e5%8f%96%e9%aa%8c%e8%af%81%e7%a0%81%e5%9b%be%e7%89%87%e5%92%8c%e8%ae%be%e7%bd%aecookies%ef%bc%8cheaders%ef%bc%8c%e6%a8%a1%e6%8b%9f%e9%bc%a0%e6%a0%87%e7%82%b9%e5%87%bbselected
title: casperjs截取验证码图片和设置cookies，headers，模拟鼠标点击selected元素
wordpress_id: 308
categories:
- 爬虫
tags:
- casperjs
- cookie
- 截图
- 验证码
---
{% include JB/setup %}

casperjs设置headers：

```
var casper = require('casper').create({
    pageSettings: {
     loadImages: true,
     loadPlugins: true,
     // userAgent: 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.137 Safari/537.36 LBBROWSER'
     userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',
    }
     logLevel: "debug",//日志等级
     verbose: true  // 记录日志到控制台
});

var mouse = require("mouse").create(casper);

var url = 'http://baidu.com/';

casper.start(url);

// casper.thenClick('#verify-state');    //鼠标点击
casper.thenClick('#btnBeginValidate');
casper.thenClick('#btnVRefresh',function(response){
    this.echo((response.headers.get('Set-Cookie')).split(';')[0]);   #获取响应的Set-Cookie信息
});

casper.then(function () {

    // this.echo(this.)
    // this.querySelector('img[id="imgPhrase"]').setAttribute('style', "display: block");
    this.wait(1000, function () {
        img_guid = this.getElementAttribute('img[id="imgPhrase"]', 'src');  //获取元素属性值
        // img_name = img_guid + '.png';
        img_name = '2001.png';
        this.captureSelector(img_name, '.yz-main');   # 根据元素属性截取图片
});

```

casperjs设置cookies：

```
var webPage = require('webpage');
var page = webPage.create();

page.customHeaders = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',
    'Content-Type': 'application/x-www-form-urlencoded'
};

if (phantom.addCookie({
    'name': 'EhireGuid',
    'value': '5662e8a3df3c4062aa9edd9ee3e2e36f',
    'path': '/',   //必须
    'domain': 'baidu.com'   //必须
})) {console.log('cookie EhireGuid success')} else {
    console.log('cookie EhireGuid fail')       //一直返回失败，但是实际上是成功了，感觉这个是phantomjs的bug 有空提交一下bug
}

var selector = "#dropPutDateRange"; // use proper selector

casper.then(function(){
    // check selectd value
        var selected = this.evaluate(function(selector){
            var s = document.querySelector(selector);
            var o = s.children[s.selectedIndex];
            return {value: o.value, text: o.innerHTML};
        }, selector);

        this.echo("result: " + JSON.stringify(selected, undefined, 4));   //打印selected的值

        this.evaluate(function() {
            $('#dropPutDateRange ').val('value').change();   //改变selected的值
        });
});

casper.run();

```

