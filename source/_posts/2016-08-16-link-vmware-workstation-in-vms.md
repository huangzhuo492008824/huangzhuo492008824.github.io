---
author: huangzhuo
comments: true
date: 2016-08-16 09:16:13+00:00
layout: post
slug: '%e8%bf%9e%e6%8e%a5vmware-workstation%e5%ad%90%e8%99%9a%e6%8b%9f%e6%9c%ba%e5%88%b0%e4%ba%92%e8%81%94%e7%bd%91%ef%bc%9f'
title: 连接VMware Workstation子虚拟机到互联网？
wordpress_id: 175
categories:
- 云计算
tags:
- linux
- 虚拟化
---
 




VMware Workstation是桌面或笔记本上的用于独立实验测试环境的理想桌面应用。使用Workstation，你可以创建多个专用网络，连接虚拟机到主机，桥接网络到局域网（LAN）或使用Network Address Translation协议（NAT）连接网络到LAN。




其实，VMware Workstation的虚拟网络配置能力正是Workstation的魅力所在。但同时，虚拟网络灵活性又使其在配置时很困难。因此，在Workstation里创建新虚拟机不难，配置虚拟网络才是难题所在。在本文中，TechTarget中国的特约虚拟化专家David Davis将描述VMware Workstation实验网络的几种情景，并解决一些常见问题：如何将虚拟子机连接到网络？




**VMware Workstation的虚拟网络编辑器**




使Workstation的虚拟网络配置简单又复杂的一个功能是Virtual Network Editor。这个工具允许你配置每个不同类型的Workstation网络，与动态主机配置协议（DHCP）和NAT Workstation服务一起工作。我们将使用这个工具连接虚拟子机到互联网，并创建不同的实验场景。你可以利用Vrtual Network Editor做许多事。我就不用详细描述如何使用这个工具了，你可以参考我以前的文章“使用VMware Workstation和Virtual Network Editor管理虚拟网络”。




下面我们看看使用VMware Workstation搭建的四个不同的虚拟网络场景。




**场景一、使用桥接功能连接虚拟机到互联网**




我经常被问及关于VMware Workstation的一个问题是如何连接子虚拟机到互联网。基于你的网络和互联网配置，连接虚拟机到Web的方法可能基于你的网络配置而更改。因此我们假定你的LAN提供了DHPC服务器（使用默认网关或域名系统，或者DNS，没有MAC限制，你的防火墙允许任何计算机从LAN连接到互联网。）




在这种情况下，你不需要做任何事，如果你为虚拟网络适配器选择NAT或者桥接的链接，配置应该能够自动工作。我自己建议你使用Bridged Networking或VMnet0）。




在下图中，虚拟主机有一个IP地址（10.0.0.100），每台虚拟子机有自己的从DHCP服务器获得的IP地址（分别是10.0.0.101、102和103）。这样的话，每台虚拟子机作为网络上自己的IP节点运行。通常我喜欢这样的系统，因为每台虚拟子机都可以识别。我能使用Remote Desktop Protocol（RDP）连接每一台虚拟子机，或者链接到虚拟子机的Web接口上（如果运行Web服务器）。




缺点是如果你的网络存在IP限制，那么每台子机必须在网络上单独配置。就是说你的防火墙只允许某一个设备与互联网通信。使用桥接，每台虚拟子机应该必须在防火墙上有自己的授权，因为它有自己的IP地址。也可能存在Windows网络限制。可能你的思科交换机存在MAC地址限制。如果这样，每一台虚拟子机有自己的MAC地址。由于许多MAC地址请求网络访问，虚拟主机的以太网端口可能在思科交换机上是锁着的。如果在交换机上配置有端口安全的MAC地址和限制的MAC地址，使用桥接就算供养一台虚拟子机，都很容易由于违背端口安全，导致主机PC或服务器从网络断开连接。




[![](http://images.51cto.com/files/uploadimg/20090702/1834520.jpg)](http://images.51cto.com/files/uploadimg/20090702/1834520.jpg)




为了映射虚拟子机到某个虚拟网络，只需要配置虚拟网络接口卡到桥接“NATed”等。如下图：




[![](http://images.51cto.com/files/uploadimg/20090702/1834521.jpg)](http://images.51cto.com/files/uploadimg/20090702/1834521.jpg)




场景二、使用NAT连接虚拟机到互联网




如我在第一个场景里所说的，可以使用NAT或VMnet8替换桥接。使用NAT，主机的IP地址供所有虚拟子机使用。换句话说，当虚拟子机与LAN通信时，就好像虚拟主机在发出请求。




[![](http://images.51cto.com/files/uploadimg/20090702/1834522.jpg)](http://images.51cto.com/files/uploadimg/20090702/1834522.jpg)




不过子虚拟机如何获得它们的IP地址？因为每台虚拟机需要自己的IP地址。在Workstation里使用NAT的情况下，VMware Workstation实际有其自己的内部DHCP服务器，能发送内部的和专用的IP地址给任何位于NAT网络上的虚拟子机。




如果你去到VMware Workstation Virtual Network Editor里的NAT表，你能看见NAT服务。需要运行NAT服务翻译某个Workstation NAT网络——192.168.220.0到192.168.220.254——到虚拟主机的IP地址。如你在下一张图所看见的，NAT'ed虚拟机的默认网关是192.168.220.2。




[![](http://images.51cto.com/files/uploadimg/20090702/1834523.jpg)](http://images.51cto.com/files/uploadimg/20090702/1834523.jpg)




NAT服务仍然没有发放IP地址，VMware Workstation DHCP Service发了。如果我们查看DHPC表格，能看见用于VMnet8的DHPC列。如下图：




[![](http://images.51cto.com/files/uploadimg/20090702/1834524.jpg)](http://images.51cto.com/files/uploadimg/20090702/1834524.jpg)




因此使用NAT，每台虚拟机将有其自己的IP地址，是由VMware Workstation DHCP服务提供的。这个IP是NAT'ed到虚拟主机的IP，以便访问LAN（然后访问互联网）。




场景三、使用IP地址冲突、恶意软件或重复域名测试机器




如果你有一些虚拟机存在IP地址冲突、恶意软件或者与生产服务器DNS名称相冲突的DNS名称该怎么办？你想要这些服务器运行在安全的专用网络里，避免对生产网络产生任何威胁。使用VMware Workstation能做到。




默认下，VMware Workstation拥有一个叫做VMnet7的专用虚拟网络，如下图：




[![](http://images.51cto.com/files/uploadimg/20090702/1834525.jpg)](http://images.51cto.com/files/uploadimg/20090702/1834525.jpg)




记住，你将在专有网络里的虚拟子机上配置一个静态IP地址，因为默认下，在这个子网上没有DHCP服务。如果想要DHCP，你应该在子网中配置Workstation以提供拥有Workstation DHCP服务的IP地址，或者运行Windows DHCP服务作为虚拟机。




场景四、测试需要访问主机（仅仅是主机）的安全虚拟机




最后，如果你想要虚拟子机不在本地LAN上，但又需要跨虚拟网络共享文件和访问虚拟机该怎么办？虽然没有专有网络（VMnet7）那么安全，仅仅访问主机的虚拟网络（VMnet1）可用。使用Host Only，在虚拟网络上的虚拟主机和虚拟子机能够通过它们共享的专有网络上的TCP/IP网络进行通信。




VMware Workstation使用192.168.234.0到192.168.234.254范围的默认IP地址，为专有网络提供DHCP服务，如下图所示：




[![](http://images.51cto.com/files/uploadimg/20090702/1834526.jpg)](http://images.51cto.com/files/uploadimg/20090702/1834526.jpg)




要配置虚拟子机使用这个专有网络，连接它到Host Only Virtual network（VMnet1），如下图：




[![](http://images.51cto.com/files/uploadimg/20090702/1834527.jpg)](http://images.51cto.com/files/uploadimg/20090702/1834527.jpg)




[![](http://images.51cto.com/files/uploadimg/20090702/1834528.jpg)](http://images.51cto.com/files/uploadimg/20090702/1834528.jpg)




总之，VMware Workstation为配置虚拟网络提供了许多可能，如桥接、NAT'ed、专有和host-only。每一种都有其专门的用处。如果你只是想连接虚拟子机到本地LAN和互联网，根据网络的安全配置，我建议使用bridged或NAT'ed。




【编辑推荐】






  1. [企业如何应对虚拟化管理的挑战](http://virtual.51cto.com/art/200901/107057.htm)


  2. [实施服务器虚拟化前需要评估4个问题](http://virtual.51cto.com/art/200901/107056.htm)


  3. [2009年度思杰的虚拟化之路](http://virtual.51cto.com/art/200901/107054.htm)

【责任编辑：[符甲](mailto:tanmao@51cto.com) TEL：（010）68476606】

  




 
 




原文：[**如何连接VMware Workstation子虚拟机到互联网？**](http://virtual.51cto.com/art/200907/133555.htm) [返回虚拟化频道首页](http://virtual.51cto.com)






