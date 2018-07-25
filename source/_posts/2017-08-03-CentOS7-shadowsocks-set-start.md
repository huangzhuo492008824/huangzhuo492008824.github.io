---
date: 2017-08-3 9:49:32+00:00
categories: linux
tags: [centos7, ss]
title: CentOS7设置ss开机启动
---
### CentOS7设置ss开机启动###
- 配置自启动
新建启动脚本文件/etc/systemd/system/shadowsocks.service，内容如下：
```
[Unit]
Description=Shadowsocks

[Service]
TimeoutStartSec=0
ExecStart=/usr/bin/ssserver -c /etc/shadowsocks.json

[Install]
WantedBy=multi-user.target
```

- 执行以下命令启动 shadowsocks 服务：
```
$ systemctl enable shadowsocks
$ systemctl start shadowsocks
```
- 为了检查 shadowsocks 服务是否已成功启动，可以执行以下命令查看服务的状态：
```
[root@kevin ~]# systemctl status ssserver -l
* ssserver.service - Ssserver
   Loaded: loaded (/etc/systemd/system/ssserver.service; enabled; vendor preset: disabled)
   Active: active (running) since Thu 2017-08-03 05:56:09 UTC; 23s ago
 Main PID: 691 (ssserver)
   CGroup: /system.slice/ssserver.service
           `-691 /usr/bin/python2 /usr/bin/ssserver -c /etc/shadowsocks.json --log-file /var/log/shadowsocks.log start

Aug 03 05:56:09 kevin systemd[1]: Started Ssserver.
Aug 03 05:56:09 kevin systemd[1]: Starting Ssserver...
Aug 03 05:56:09 kevin ssserver[691]: INFO: loading config from /etc/shadowsocks.json
Aug 03 05:56:09 kevin ssserver[691]: 2017-08-03 05:56:09 INFO     loading libcrypto from libcrypto.so.10
```