---
author: huangzhuo
comments: true
date: 2016-05-26 14:41:03+00:00
layout: post
slug: centos6-5%e9%85%8d%e7%bd%ae%e6%9c%ac%e5%9c%b0openstack%e6%ba%90
title: CentOS6.5配置本地openstack源
wordpress_id: 45
categories:
- 云计算
- 技术
tags:
- centos
- linux
- openstack
- 云计算
- 镜像
---
{% include JB/setup %}

**6.5搭建本地OpenStack软件源**

1、把相关软件包全部下载到本地机器

```

wget -np -nH –cut-dirs=1 -r -c -L –exclude-directories=repodata –accept=rpm,gz,xml http://repos.Fedorapeople.org/repos/openstack/openstack-icehouse/epel-6/ -P /opt/epel6

```



如果不行：

```
 wget -np -nH --cut-dirs=1 -r -c -L --exclude-directories=repodata --accept=rpm,gz,xml https://repos.Fedorapeople.org/repos/openstack/openstack-icehouse/epel-6/ -P /opt/epel6 --no-check-certificate
```






注意：




    不要将下载的文件放在/root目录下，否则httpd不能提供服务


wget参数介绍
-r,–recursive 下载整个网站、目录
-nH, –no-host-directories 不创建主机目录
-P, –directory-prefix=PREFIX 将文件保存到目录PREFIX/…
–cut-dirs=NUMBER 忽略 NUMBER层远程目录
-k, –convert-links 转换非相对链接为相对链接
-I, –include-directories=LIST 允许目录的列表
-X, –exclude-directories=LIST 不被包含目录的列表
-np, –no-parent 不要追溯到父目录
-A, –accept=LIST 分号分隔的被接受扩展名的列表
-R, –reject=LIST 分号分隔的不被接受的扩展名的列表
-c, –continue 接着下载没下载完的文件
-L, –relative 仅仅跟踪相对链接

2、创建repodata信息

```

createrepo -p -d -o /opt/epel6 /opt/epel6

```



3、配置http服务器，将根目录指到/opt/epel6

```

yum install -y httpd
rm -rf /var/www/html
ln -s /opt/epel6 /var/www/html
service httpd start


```



4. 创建rdo-release.repo文件

```

[openstack-icehouse]
name=OpenStack Icehouse Repository
baseurl=http://10.0.0.137/epel6/
enabled=1
gpgcheck=0

```



5、把生成的rdo-release.repo文件传到客户端的/etc/yum.repos.d/目录下，即可


`使用wget下载https链接：
```





`# wget -r -np -nd --accept=gz --no-check-certificate https:
```
`//www.xxx.com/dir/ --http-user=username --http-password=password
```





`下载
```
`'dir'
```
`目录下的所有gz文件
```





`-np 没有父目录
```





`-nd 不要构建本地目录结构
```





`--accept=gz 只下载gz文件
```








`HTTPS (SSL/TLS) Options（HTTPS (SSL) 参数选项）
```





`--certificate=file
```





`可选的客户段端证书
```





`--
```
`private
```
`-key=file    
```





`对此证书可选的“密钥文档”
```





`--
```
`private
```
`-key-type=type
```





`对此证书可选的“密钥类型“
```





`--egd-file=file
```





`EGD socket 文档名
```





`--ca-directory=directory    
```





`CA 散列表所在的目录
```





`--ca-certificate=file    
```





`包含 CA 的文档
```





`--certificate-type=[ PEM（默认），DER ]    
```





`Client-Cert 类型：PEM，DER
```





`--no-check-certificate    
```





`不用检查服务器的证书
```





`--secure-protocol=[ auto，SSLv2，SSLv3，TLSv1 ]    
```





`选择 SSL 协议：auto，SSLv2，SSLv3，TLSv1
```








`FTP Options（FTP参数选项）
```





`--ftp-user    
```





`登录ftp的用户名（注意：最好方法是在.netrc或.wgetrc文件中定义）
```





`--ftp-password
```





`登录ftp的密码（注意：最好方法是在.netrc或.wgetrc文件中定义）
```





`--no-remove-listing    
```





`不删除“.listing” 文档
```





`--no-glob    
```





`关闭所有通配符的ftp文档名
```





`--no-passive-ftp    
```





`禁用“被动”传输模式
```





`--retr-symlinks    
```





`在递归模式中，下载链接所指示的文档（排除连接目录的）
```








`1
```
`. 下载单个文件
```





`wget url + filename
```





`下载过程中可以看到四项信息
```





`已经下载的比例，已经下载的大小，当前的下载速度，剩余的时间
```





`2
```
`. 使用一个大写O做参数表示另存为
```





`wget -O save_name url
```





`这种方法适用于对应链接中没有显式文件名的情况。
```





`3
```
`. 指定下载速率
```





`wget --limit-rate
```





`wget -limit-rate=200k url + filename
```





`4
```
`. 断点下载
```





`wget -c完成未完成的下载
```





`下载一半时可以停下来，ctrl+c停顿，继续下载可以加入一个-c参数。
```





`注意：如果不加入-c，那么下载的文件会多出一个.
```
`1
```
`的后缀。
```





`5
```
`. 后台下载
```





`加上一个-b参数
```





`wget -b url/filename为后台下载，下载经过写入到wget-log文件中。
```





`用tail -f wget-log查看下载日志
```





`6
```
`. 模拟在浏览器下下载
```





`有的网站不允许客户在非浏览器环境下下载。使用--user-agent来设置
```





`wget --user-agent=
```
`"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092416 Firefox/3.0.3"
```
 `URL-TO-DOWNLOAD
```





`7
```
`. 测试下载链接
```





`方法:使用--spider
```





`试图做计划下载时候，需要先检查一下下载链接是否有效。
```





`wget --spider DOWNLOAD-URL
```





`如果返回OK，则表示下载链接是正确的
```





`8
```
`、增加尝试次数
```





`方法：--tries=
```
`1000
```





`如果网速有问题，下载大文件的时候可能会发生错误，
```





`默认wget尝试
```
`20
```
`次链接。
```





`如果尝试
```
`75
```
`次，可以
```





`wget --tires=
```
`75
```
 `DOWNLOAD-URL
```





`9
```
`、下载多个文件使用wget -i
```





`将多个下载链接写入到一个download-file-list.txt文件中，而后用
```





`wget -i download-file-list.txt
```





`10
```
`、下载整站
```





`方法：用--mirror参数
```





`当你要下载一个完整站点并实现本地浏览的时候，
```





`wget --mirror -p --convert-links -P ./LOCAL-DIR WEBSITE-URL
```





`参数讲解：
```





`--mirror：设置这个参数用来建立本地镜像
```





`-p：下载所有html文件适合显示的元素
```





`--convert-links：下载完成后，将文档链接都转换成本地的
```





`-P ./LOCAL-DIR：保存所有的文件和目录到指定文件夹下
```





`11
```
`、下载时候禁止下载指定类型的文件
```





`例如下载站点时候，不打算下载gif动画图片。
```





`wget --reject=gif WEBSITE-TO-BE-DOWNLOADED
```





`12
```
`、记录下载日志
```





`方法：使用小写字母o
```





`wget -o xx.html.log -O xx.html 
```
`"http://ip138.com/ips.asp?ip=58.251.193.137&action=2"
```





`检查一下日志：
```





`[root
```
`@localhost
```
 `opt]# cat xx.html.log
```





`--
```
`2010
```
`-
```
`07
```
`-
```
`12
```
 `11
```
`:
```
`57
```
`:
```
`22
```
`-- http:
```
`//ip138.com/ips.asp?ip=58.251.193.137&action=2
```





`正在解析主机 ip138.com... 
```
`221.5
```
`.
```
`47.136
```





`Connecting to ip138.com|
```
`221.5
```
`.
```
`47.136
```
`|:
```
`80
```
`... 已连接。
```





`已发出 HTTP 请求，正在等待回应... 
```
`200
```
 `OK
```





`长度：
```
`7817
```
 `(
```
`7
```
`.6K) [text/html]
```





`Saving to: `xx.html'
```





`0K ....... 
```
`100
```
`% 
```
`65
```
`.5K=
```
`0
```
`.1s
```





`2010
```
`-
```
`07
```
`-
```
`12
```
 `11
```
`:
```
`57
```
`:
```
`22
```
 `(
```
`65.5
```
 `KB/s) - `xx.html' saved [
```
`7817
```
`/
```
`7817
```
`]
```





`13
```
`、是第
```
`9
```
`条的增强版。可以限制下载容量
```





`wget -Q5m -i FILE-WHICH-HAS-URLS
```





`当下载的文件达到
```
`5
```
`兆的时候，停止下载。
```





`注意：如果不是对一个文件下载链接清单，对单个文件，这个限制不会生效的。
```





`14
```
`、和第
```
`11
```
`条正好相反，
```





`这条技巧是讲述如何仅仅下载指定类型的文件
```





`从一个网站中下载所有的pdf文件
```





`wget -r -A.pdf http:
```
`//url-to-webpage-with-pdfs/
```





`15
```
`、使用wget完成ftp下载
```





`匿名ftp下载类似于http下载
```





`wget ftp-url即可。
```





`如果是需要输入用户名和密码，则是
```





`wget --ftp-user=USERNAME --ftp-password=PASSWORD DOWNLOAD-URL
```

