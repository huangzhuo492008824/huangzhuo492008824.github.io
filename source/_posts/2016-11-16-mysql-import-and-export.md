---
date: 2016-11-16 08:18:18+00:00
title: mysql命令行数据库的导出和导入
categories:
- python
tags:
- mac
- mysql
- 数据库导出
---
 
MAC下用brew安装的mysql，创建my.cnf文件，用以前的linux下的配置总是各种报错：
```
ERROR! The server quit without updating PID file (/usr/local/var/mysql/higgsdeMacBook-Pro.local.pid).
```

解决方法：
  用mac下默认的配置文件作为my.cnf的内容，然后修改才会生效：

```
cp /usr/local/opt/mysql/support-files/my-default.cnf /etc/my.cnf
```

MySQL数据库的导出和导入：
导出：
```
mysqldump -u root -p news > news.sql
```

导入：
```
mysql -u root -p voice<voice.sql
```
