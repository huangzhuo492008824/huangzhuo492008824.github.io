---
author: huangzhuo
comments: true
date: 2017-07-06 08:02:37+00:00
layout: post
slug: docker%e5%ad%a6%e4%b9%a0%e6%80%bb%e7%bb%93
title: docker学习总结
wordpress_id: 332
categories:
- 其它
tags:
- docker
---

后台守护进程启动docker

```

docker run --name uc -p 8001:8001 -tdi python-jlb /bin/bash

```

进入后台运行的docker

```

docker attach docker-name

```


