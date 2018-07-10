---
author: huangzhuo
comments: true
date: 2016-11-16 08:18:18+00:00
layout: post
slug: mysql%e5%91%bd%e4%bb%a4%e8%a1%8c%e6%95%b0%e6%8d%ae%e5%ba%93%e7%9a%84%e5%af%bc%e5%87%ba%e5%92%8c%e5%af%bc%e5%85%a5
title: mysql命令行数据库的导出和导入
wordpress_id: 276
categories:
- mac
- python
tags:
- mac
- mysql
- 数据库导出
---
{% include JB/setup %}

MAC下用brew安装的mysql，创建my.cnf文件，用以前的linux下的配置总是各种报错：

```

... ERROR! The server quit without updating PID file (/usr/local/var/mysql/higgsdeMacBook-Pro.local.pid).

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



