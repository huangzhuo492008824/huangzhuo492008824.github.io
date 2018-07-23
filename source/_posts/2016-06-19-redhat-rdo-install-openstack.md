---
author: huangzhuo
comments: true
date: 2016-06-19 13:01:04+00:00
excerpt: 学习openstack在安装过程中也遇到了很多的问题，，在此记录一下：
layout: post
slug: redhat7%e4%b8%8brdo%e6%96%b9%e5%bc%8f%e5%ae%89%e8%a3%85openstack%e7%ac%94%e8%ae%b0
title: redhat7下rdo方式安装openstack笔记
wordpress_id: 84
categories:
- 云计算
tags:
- centos7
- epel
- linux
- openstack
- rdo
- redhat7
- 云计算
---

学习openstack在安装过程中也遇到了很多的问题，，在此记录一下：
1. 首先查看硬件是否支持虚拟化：
linux下：

```

grep -E 'svm|vmx' /proc/cpuinfo

```

有输出信息说明支持，然后在bios中开启虚拟化
如果不支持虚拟化，openstack会默认使用软件虚拟化技术qemu来创建虚拟机，性能上和kvm差距很大，并且个人赶脚比较占内存；
2. 先用 YUM 安裝 RDO 及 openstack-packstack

```

# yum update -y
# yum install -y http://rdo.fedorapeople.org/rdo-release.rpm
# yum install -y openstack-packstack

```

3. 本机设置成静态ip：

```

# vim /etc/sysconfig/network-scripts/ifcfg-eno16777736

```


修改如下：

```
HWADDR=00:0C:29:99:3C:45
TYPE=Ethernet
BOOTPROTO=none
DEFROUTE=yes
PEERDNS=yes
PEERROUTES=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes
IPV6_FAILURE_FATAL=no
NAME=eno16777736
UUID=88d86789-394c-4647-b8e6-88f14a652c84
ONBOOT=yes
IPADDR=192.168.1.50
PREFIX=24
GATEWAY=192.168.1.1
DNS1=114.114.114.114

```

重启网卡：

```
# systemctl restart network
```

4.生成安装配置文件：

```
# packstack --gen-answer-file=allinone.txt
# vim allinone.txt
```

配置需要安装的服务和设置密码，根据个人需要设置，然后执行费时较长的最终安装：

```
# packstack --answer-file=allinone.txt
```

国内安装过程中极有可能会中断，重新执行即可，直到安装成功。
5.allinone方式安装成功以后需要配置网卡：

```

# vim /etc/sysconfig/network-scripts/ifcfg-eno16777736 配置如下:

```


```
HWADDR=00:0C:29:99:3C:45
#TYPE=Ethernet
BOOTPROTO=none
DEFROUTE=yes
PEERDNS=yes
PEERROUTES=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes
IPV6_FAILURE_FATAL=no
NAME=eno16777736
UUID=88d86789-394c-4647-b8e6-88f14a652c84
#ONBOOT=yes
#IPADDR=192.168.1.50
#PREFIX=24
#GATEWAY=192.168.1.1
#DNS1=114.114.114.114
TYPE=OVSPort
DEVICETYPE=ovs
OVS_BRIDGE=br-ex
```



```

# vim /etc/sysconfig/network-scripts/ifcfg-br-ex 配置如下：

```


```
DEVICE=br-ex
DEVICETYPE=ovs
TYPE=OVSBridge
BOOTPROTO=static
IPADDR=192.168.1.50
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=114.114.114.114
ONBOOT=yes
```

重启网卡：

```

# systemctl restart network

```


记录的一些问题：
a. packstack --answer-file=xxx.txt安装过程，有可能因为源的原因中断，你可以修改一下netns.pp文件中延时。

b.创建云主机参照：http://www.chenshake.com/centos6-4-single-card-all-in-one-install-havana/ 照着步骤用SecureCRT登录不上云主机，提示：需要一个.pub的公钥文件，所以照着第四步用用户名和密码登录的

c.登录云主机参照：http://www.chenshake.com/openstack-mirror-and-password/

d. DNS的错误，今天搭了CentOS6.5上RDO（Vlan）双节点安装Icehouse版本：总是报DNS的错误：

```
ERROR : Failed to run remote script, stdout: Loaded plugins: fastestmirror, security
Loading mirror speeds from cached hostfile
* epel: mirrors.neusoft.edu.cn

stderr: Warning: Permanently added '192.168.115.115' (RSA) to the list of known hosts.
+ trap t ERR
+ yum install -y puppet openssh-clients tar nc rubygem-json
http://yum.theforeman.org/releases/1.3/el6/x86_64/repodata/repomd.xml: [Errno 14] PYCURL ERROR 6 - "Couldn't resolve host 'yum.theforeman.org'"
Trying other mirror.
Error: Cannot retrieve repository metadata (repomd.xml) for repository: foreman. Please verify its path and try again
++ t
++ exit 1
Please check log file /var/tmp/packstack/20141102-222130-D8Ve6D/openstack-setup.log for more information
```

最后yum update以后还是报DNS的错误：于是把8.8.8.8 改成了114.114.114.114，关了计算节点的iptables和Selinux以后就好了，记录一下
