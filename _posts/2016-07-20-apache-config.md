---
author: huangzhuo
comments: true
date: 2016-07-20 03:04:19+00:00
layout: post
slug: apache%e9%85%8d%e7%bd%ae%e4%bc%98%e5%8c%96
title: Apache配置优化
wordpress_id: 116
categories:
- 技术
tags:
- apache
- redhat
---
{% include JB/setup %}

过滤配置文件中的注释信息：


```

grep -v ‘^#\|^$\|#’ /etc/httpd/conf/httpd.conf

```




CentOS6.5下配置apache启动方式为worker：


```

mv /usr/sbin/httpd /usr/sbin/httpd.prefork

mv /usr/sbin/httpd.worker /usr/sbin/httpd

```



配置参数解读：

ServerTokens OS   当服务器响应主机头（header）信息时显示Apache的版本和

操作系统名称
ServerRoot “/etc/httpd”   设置服务器的根目录
PidFile run/httpd.pid     PID存放位置
Timeout 60                若60秒后没有收到或送出任何数据就切断该连接
KeepAlive Off             是否开启保持链接状态
MaxKeepAliveRequests 100  在使用保持连接功能时，设置客户一次请求连接能

响应文件的最大上限
KeepAliveTimeout 15       在使用保持连接功能时，两个相邻的连接的时间间

隔超过15秒，就切断连接
<IfModule prefork.c>      设置使用Prefork MPM运行方式的参数，此运行方式

是Red hat默认的方式
StartServers       8      设置服务器启动时运行的进程数
MinSpareServers    5      最小空闲进程数
MaxSpareServers   20      最大空闲进程数
ServerLimit      256      最大的进程数
MaxClients       256      最大的请求并发MaxClients=ServerLimit*进程的线

程数
MaxRequestsPerChild  4000 限制每个子进程在结束处理请求之前能处理的连接请求为1000

<IfModule worker.c>
ServerLimit 64
ThreadLimit 200
StartServers 5
MaxClients 2500
MinSpareThreads 50
maxSpareThreads 200
ThreadsPerChild 100
MaxRequestsPerChild 1000
</IfModule>

ServerLimit 16
//服务器允许配置的进程数上限。这个指令和ThreadLimit结合使用设置了MaxClients最大允许配置的数值。任何在重启期间对这个指令的改变都将被忽略，但对MaxClients的修改却会生效。
ThreadLimit 64
//每个子进程可配置的线程数上限。这个指令设置了每个子进程可配置的线程数ThreadsPerChild上限。任何在重启期间对这个指令的改变都将被忽略，但对ThreadsPerChild的修改却会生效。默认值是”64″.
StartServers 3
//服务器启动时建立的子进程数，默认值是”3″。
MinSpareThreads 75
//最小空闲线程数,默认值是”75″。这个MPM将基于整个服务器监视空闲线程数。如果服务器中总的空闲线程数太少，子进程将产生新的空闲线程。
MaxSpareThreads 250
//设置最大空闲线程数。默认值是”250″。这个MPM将基于整个服务器监视空闲线程数。如果服务器中总的空闲线程数太多，子进程将杀死多余的空闲线 程。MaxSpareThreads的取值范围是有限制的。Apache将按照如下限制自动修正你设置的值：worker要求其大于等于 MinSpareThreads加上ThreadsPerChild的和
MaxClients 400
//允许同时伺服的最大接入请求数量(最大线程数量)。任何超过MaxClients限制的请求都将进入等候队列。默认值是”400″ ,16(ServerLimit)乘以25(ThreadsPerChild)的结果。因此要增加MaxClients的时候，你必须同时增加 ServerLimit的值。
ThreadsPerChild 25
//每个子进程建立的常驻的执行线程数。默认值是25。子进程在启动时建立这些线程后就不再建立新的线程了。
MaxRequestsPerChild 0
//设置每个子进程在其生存期内允许伺服的最大请求数量。到达MaxRequestsPerChild的限制后，子进程将会结束。如果MaxRequestsPerChild为”0″，子进程将永远不会结束。
将MaxRequestsPerChild设置成非零值有两个好处：
1.可以防止(偶然的)内存泄漏无限进行，从而耗尽内存。
2.给进程一个有限寿命，从而有助于当服务器负载减轻的时候减少活动进程的数量。


