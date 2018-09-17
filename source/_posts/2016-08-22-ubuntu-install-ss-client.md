---
author: huangzhuo
comments: true
date: 2016-08-22 15:06:35+00:00
layout: post
slug: ubuntu%e5%ae%89%e8%a3%85shadowsocks%e5%ae%a2%e6%88%b7%e7%ab%af
title: ubuntu安装ss客户端
wordpress_id: 220
categories:
- linux
tags:
- shadowsocks
- ubuntu
---
##### 文章目录

  * 第一种
    * ubuntu安装shadowsocks
    * 启动shadowsocks
  * 第二种
  * 配置浏览器
    * 安装插件
    * 设置代理地址
    * 设置自动切换
  * 开机后台自动运行ss

之前介绍过用[搬瓦工的vps](http://aitanlu.com/vps-bandwagonhost-openvpn-shadowsocks-server.html)可以轻松的搭建shadowsocks服务，然后在windows上和安卓手机平板等上轻松科学上网，只要下载对应的程序即可，当来到ubuntu上怎么配置shadowsocks来科学上网呢？有两种方法可行

1.安装shadowsocks命令行程序，配置命令。
2.安装shadowsocks GUI图形界面程序，配置。

个人推荐第一种，配置好后基本不用管。但使用的前提是 你的服务端已经搭建好或者你有别人提供的SS 服务（我也不知道该不该写这文章...）
## 第一种
### ubuntu安装shadowsocks
用PIP安装很简单，
``` shell
sudo apt-get update  
sudo apt-get install python-pip  
sudo apt-get install python-setuptools m2crypto
```

接着安装shadowsocks

``` shell
pip install shadowsocks
```

如果是ubuntu16.04 直接 (16.04 里可以直接用apt 而不用 apt-get 这是一项改进）

``` shell
sudo apt install shadowsocks
```

当然你在安装时候肯定有提示需要安装一些依赖比如python-setuptools m2crypto ，依照提示安装然后再安装就好。也可以网上搜索有很多教程的。

### 启动shadowsocks
安装好后，在本地我们要用到sslocal ，终端输入sslocal --help 可以查看帮助，像这样
![sslocal](https://aitanlu.com/wp-content/uploads/2016/04/sslocal.png)

通过帮助提示我们知道各个参数怎么配置，比如 sslocal -c 后面加上我们的json配置文件，或者像下面这样直接命令参数写上运行。

比如 sslocal -s 11.22.33.44 -p 50003 -k "123456" -l 1080 -t 600 -m aes-256-cfb

-s表示服务IP, -p指的是服务端的端口，-l是本地端口默认是1080, -k 是密码（要加""）, -t超时默认300,-m是加密方法默认aes-256-cfb，

**为了方便我推荐直接用sslcoal -c 配置文件路径 这样的方式，简单好用。**

我们可以在/home/mudao/ 下新建个文件shadowsocks.json  (mudao是我在我电脑上的用户名，这里路径你自己看你的)。内容是这样：
``` shell
"server":"11.22.33.44",  
"server_port":50003,  
"local_port":1080,  
"password":"123456",  
"timeout":600,  
"method":"aes-256-cfb"  
```

server  你服务端的IP  

servier_port  你服务端的端口  

local_port  本地端口，一般默认1080  

passwd  ss服务端设置的密码  

timeout  超时设置 和服务端一样  

method  加密方法 和服务端一样

确定上面的配置文件没有问题，然后我们就可以在终端输入 sslocal -c /home/mudao/shadowsocks.json 回车运行。如果没有问题的话，下面会是这样...

![sslocal](https://aitanlu.com/wp-content/uploads/2016/04/sslocal-1.png)（如果继续请不要关闭这个终端）

如果你选择这一种请跳过第二种。你可以去系统的代理设置按照说明设置代理，但一般是全局的，然而我们访问baidu,taobao等着些网站如果用代理就有点绕了，而且还会浪费服务器流量。我们最好配置我们的浏览器让它可以自动切换，该用代理用代理该直接连接自动直接连接。所以请看配置浏览器。

## 配置浏览器
假如你上面任选一种方式已经开始运行sslocal了，火狐那个代理插件老是订阅不了gfwlist所以配置自动模式的话不好使。这里用的是chrome，你可以在Ubuntu软件中心下载得到。
### 安装插件
我们需要给chrome安装SwitchyOmega插件，但是没有代理之前是不能从谷歌商店安装这个插件的，但是我们可以从Github上直接下载最新版 [https://github.com/FelisCatus/SwitchyOmega/releases/](https://github.com/FelisCatus/SwitchyOmega/releases/) （这个是chrome的）然后浏览器地址打开chrome://extensions/，将下载的插件托进去安装。

### 设置代理地址
安装好插件会自动跳到设置选项，有提示你可以跳过。左边新建情景模式-选择代理服务器-比如命名为SS（叫什么无所谓）其他默认之后创建，之后在代理协议选择SOCKS5，地址为127.0.0.1,端口默认1080 。然后保存即应用选项。
![shadowsocks-0](https://aitanlu.com/wp-content/uploads/2016/04/shadowsocks-0.png)
![shadowsocks-1](https://aitanlu.com/wp-content/uploads/2016/04/shadowsocks-1.png)
### 设置自动切换
接着点击自动切换 ( Auto switch）上面的不用管，在按照规则列表匹配请求后面选择刚才新建的SS，默认情景模式选择直接连接。点击应用选项保存。再往下规则列表设置选择AutoProxy 然后将**[这个地址](https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt)**填进去，点击下面的立即更新情景模式，会有提示更新成功！
![shadowsocks-2](https://aitanlu.com/wp-content/uploads/2016/04/shadowsocks-2.png)sorry编辑图片时候少了一步，就是填好规则列表地址后先点击立即更新情景模式 后再应用选项保存
https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt

点击浏览器右上角的SwitchyOmega图标，下面选择自动切换，然后打开google.com试试，其他的就不在这贴图了。

![shadowsocks-3](https://aitanlu.com/wp-content/uploads/2016/04/shadowsocks-3.png)
