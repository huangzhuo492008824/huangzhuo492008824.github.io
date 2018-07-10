---
author: huangzhuo
comments: true
date: 2016-05-26 14:34:57+00:00
layout: post
slug: centos6-5%e4%b8%8b%e6%b7%bb%e5%8a%a0epel%e6%ba%90
title: CentOS6.5下添加epel源
wordpress_id: 43
categories:
- 技术
tags:
- centos
- epel
- linux
- redhat
---
{% include JB/setup %}

0.安装yum优先级插件

```
yum install yum-priorities
```

1.epel简介: https://fedoraproject.org/wiki/EPEL/zh-cn

```
rpm -Uvh http://mirrors.ustc.edu.cn/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
```

以上URL请按实际情况修改



2.查看是否安装成功

```
rpm -q epel-release
```

3.导入key：

```
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6


```

4.修改/etc/yum.repos.d/epel.repo文件

在[epel]最后添加一条属性 priority=11

```
vi /etc/yum.repos.d/epel.repo
```

意思是yum先去官方源查，官方没有再去epel的源找



5.重建缓存

```
yum makecache
```

