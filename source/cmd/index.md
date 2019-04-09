---
title: cmd
date: 2018-07-23 22:18:36
---
#### 常用linux命令
1. 杀死包含指定字符串的进程：
``` shell
ps aux | grep ping | awk '{print $2}' | xargs kill -9
```