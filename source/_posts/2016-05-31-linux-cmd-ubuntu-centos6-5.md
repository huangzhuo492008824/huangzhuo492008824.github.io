---
author: huangzhuo
comments: true
date: 2016-05-31 03:34:27+00:00
layout: post
slug: linux%e7%b3%bb%e7%bb%9f%e4%b8%8b%e5%b8%b8%e7%94%a8%e5%91%bd%e4%bb%a4%e6%80%bb%e7%bb%93-ubuntu-centos6-5
title: linux系统下常用命令总结 ubuntu CentOS6.5
wordpress_id: 61
categories:
- linux
tags:
- epel
- find
- 查找关键字
- 系统
---

#### python环境相http方式共享文件命令：



```

python -m SimpleHTTPServer

```





#### 根据端口杀死进程命令：




```

kill `lsof -i :9077 | awk '{print $2}' | grep -v PID`

```





#### 1.获取文本中含有某个字符串的上一行：



```
grep 'old mode 100644' -B 1 filename
```



含有摸个字符串的下一行用：



```
grep 'old mode 100644' -A 1 filename
```






#### 2.查看当前系统文件系统类型：



```
fdisk -l
df -T
parted /dev/sda print     ----列出本机目前的分区情况
```



ls查看文件以K、M、G为单位显示：ls -lh













#### 3.在LINUX中，两条命令可以用来访问WINDOWS共享：





 	
  1.  smbclient -U  用户名  //IP地址/共享名例如： smbclient  -U   share  //192.168.4.165/fg如果成功，会出现smb>提示符，好像是输入一个？，就可以看到能够使用的命令了。

 	
  2. mount  -o  username=用户名   //IP地址/共享名    /LINUX本地挂载点例如： mount   -o   username=share  //192.168.4.165/fg    /test如果成功，直接访问linux系统中的/test目录，就可以看到WINDOWS的共享内容linux 中将一个目录挂载到另一个目录：  mount --bind olddir newdir







####  4.find




名称 : find
用法 : find
使用说明 :将档案系统内符合 expression 的档案列出来。你可以指要档案的名称、类别、时间、大小、权限等不同资讯的组合，只有完全相符的才会被列出来。

find 根据下列规则判断 path 和 expression，在命令列上第一个 - ( ) , ! 之前的部份为 path，之后的是 expression。如果 path 是空字串则使用目前路径，如果 expression 是空字串则使用 -print 为预设 expression。

expression 中可使用的选项有二三十个之多，在此只介绍最常用的部份。

-mount, -xdev : 只检查和指定目录在同一个档案系统下的档案，避免列出其它档案系统中的档案
-amin n : 在过去 n 分钟内被读取过
-anewer file : 比档案 file 更晚被读取过的档案
-atime n : 在过去 n 天过读取过的档案
-cmin n : 在过去 n 分钟内被修改过
-cnewer file :比档案 file 更新的档案
-ctime n : 在过去 n 天过修改过的档案
-empty : 空的档案-gid n or -group name : gid 是 n 或是 group 名称是 name
-ipath p, -path p : 路径名称符合 p 的档案，ipath 会忽略大小写
-name name, -iname name : 档案名称符合 name 的档案。iname 会忽略大小写
-size n : 档案大小 是 n 单位，b 代表 512 位元组的区块，c 表示字元数，k 表示 kilo bytes，w 是二个位元组。-type c : 档案类型是 c 的档案。
d: 目录
c: 字型装置档案
b: 区块装置档案
p: 具名贮列
f: 一般档案
l: 符号连结
s: socket
-pid n : process id 是 n 的档案

你可以使用 ( ) 将运算式分隔，并使用下列运算。
exp1 -and exp2
! expr
-not expr
exp1 -or exp2
exp1, exp2
范例:
将目前目录及其子目录下所有延伸档名是 c 的档案列出来。
# find . -name "*.c"

将目前目录其其下子目录中所有一般档案列出
# find . -ftype f

将目前目录及其子目录下所有最近 20 分钟内更新过的档案列出
# find . -ctime -20

find . -name "*" -exec grep xxx {} ; -print |morexxx为你想要找的字符串

**查找当前目录下含有某字符的文件名并列出：**

**find . | xargs -ri "IBM" -l**











[CentOS6.5下添加epel源](http://huangzhuo.site/index.php/2016/05/26/22/34/57/)




