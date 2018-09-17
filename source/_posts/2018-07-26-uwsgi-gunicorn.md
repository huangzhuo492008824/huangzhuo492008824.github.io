---
date: 2018-07-26 9:49:32+00:00
categories: python
title: uwsgi和gunicorn
tags: [python, uwsgi, gunicorn]
---

### WSGI 、uwsgi 与 uWSGI 的区别
* WSGI：只是一种规范，描述web server如何与web application通信的规范，运行在WSGI协议之上的框架有Bottle, Flask, Django ；

* uwsgi：是uWSGI服务器的独有通信协议，据说该协议是fcgi协议的10倍快；

* uWSGI：是一个web服务器，实现了WSGI协议、uwsgi协议、http协议等；

### WSGI规范
WSGI 其实是定义了一种server与application解耦的规范；

WSGI server： uWSGI、gunicorn ；

WSGI app：bottle、flask、django、tornado
![wsgi](/uploads/uwsgi-gunicorn/uwsgi.png)

### uWSGI支持的并发模型
- Multiprocess
- Multithreaded
- gevent
- greenlet + uWSGI async
- uWSGI native async api
- Coro::AnyEvent
- Ruby fibers + uWSGI async
- Ruby threads
- uGreen + uWSGI async
### uWSGI常用参数配置
socket ： 地址和端口号；
http：开启一个http服务和socket服务；
processes ： 开启的进程数量；
workers ： 开启的进程数量，等同于processes；
chdir ： 指定运行目录
wsgi-file ： 载入wsgi-file（load .wsgi file）
threads ： 运行线程数；
http-websockets：websocket支持；
master ： 允许主进程存在；
module： 指定需要加载的WSGI模块；              
callable：  指定哪个变量将被调用，默认是名字为“application”的变量；
daemonize ： 使进程在后台运行，并将日志打到指定的日志文件；
pidfile ： 指定pid文件的位置，记录主进程的pid号；
disable-logging ： 不记录请求信息的日志。只记录错误以及uWSGI内部消息到日志中；

### uWSGI基本命令
启动： uwsgi -i uwsgi.ini

重启：uwsgi --reload uwsgi.pid

停止：uwsgi --stop uwsgi.pid

更多：uwsgi --help

### uwsgi与gunicorn性能对比 (先挖个坑，明天再补)

