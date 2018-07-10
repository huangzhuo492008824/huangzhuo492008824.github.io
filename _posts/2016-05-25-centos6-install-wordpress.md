---
author: huangzhuo
comments: true
date: 2016-05-25 01:24:52+00:00
layout: post
slug: centos6-6%e5%ae%89%e8%a3%85%e9%85%8d%e7%bd%aewordpress
title: CentOS6.6安装配置wordpress
wordpress_id: 27
categories:
- 技术
tags:
- linux
---
{% include JB/setup %}

1.安装配置php环境：

yum install mysql-server php php-mysql httpd -y

a. 启动mysql，创建数据库和用户：

mysql

create database db_name;

grant all on db_name.* to username@localhost identified by 'passwd';

2. 下载安装wordpress：

a. 访问本机ip地址，显示apache界面表示正常，不正常可以查看一下防火墙配置；

b. 官网下载wordpress安装包，解压以后放到站点目录；

c.修改/etc/httpd/conf/httpd.conf 中

DocumentRoot "/var/html/wordpress"

DirectoryIndex ?index.html index.html.var index.php

d. 进入wordpress目录修改php配置：

cp wp-config-sample.php wp-config.php
vim wp-config.php 配置mysql数据库；

修改wordpress目录权限：chown apache. * -R

配置以后重启apache：/etc/init.d/httpd restart

c. 访问本机站点，按照提示安装wordpress ;
