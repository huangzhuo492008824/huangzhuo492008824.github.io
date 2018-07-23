---
author: huangzhuo
comments: true
date: 2016-05-26 13:32:03+00:00
layout: post
slug: ubuntu%e4%bf%ae%e6%94%b9etcfstab%e6%96%87%e4%bb%b6%e6%97%a0%e6%b3%95%e8%bf%9b%e5%85%a5%e7%b3%bb%e7%bb%9f
title: ubuntu修改/etc/fstab文件无法进入系统
wordpress_id: 34
categories:
- linux
tags:
- centos
- linux
- ubuntu
- 系统
---



ubuntu修改/etc/fstab文件无法进入系统：









重启进入第二个选项：




进入drop to root shell prompt



























#mount -o remount,rw /

然后vim /etc/fstab修改配置文件保存退出，重启即可。

redhat：

























在虚拟机刚开启时按e键，进入到界面，有如下条目

Enterprise linux (2.6.18-128.el5)

然后按e键，进入一个界面，如下条目

kernel /vmlinuz-2.6.18-128.el5 ro root=LABEL=/ rhgb quite
把光标移动这行后，再按一下e键，进入编辑这行；在行尾条一个空格 ，然后输入 [linux](http://linux.chinaitlab.com/) single

也就是类似如下的：

kernel /vmlinuz-2.6.18-128.el5 ro root=LABEL=/ rhgb quite linux quite
结束编辑，按回车返回；

接着我们要启动系统，按一下b键启动；

在启动过程中，因为/etc/fstab修改错误，导致磁盘检查报错。此时，输入root密码后，进入字符界面，

系统是只读的（执行vi /etc/fstab后，无法保存，报错说read only），要运行下面的命令；

#mount -o remount,rw /

然后，执行如下操作，改正/etc/fstab，保存退出，重启

#vi /etc/fstab
#reboot















































