---
author: huangzhuo
comments: true
date: 2016-08-21 09:04:21+00:00
layout: post
slug: win8%e4%b8%8bgpt%e5%88%86%e5%8c%ba%e5%ae%89%e8%a3%85win7%e7%b3%bb%e7%bb%9f
title: win8下GPT分区安装win7系统
wordpress_id: 209
categories:
- windows
tags:
- 系统
---
 

朋友的笔记本win8升级win10以后比较卡想重装系统，咨询我怎么装，今天让他把本拿到了我家，目前win10激活工具比较难找，so建议朋友装win7，于是找了win7专业版的镜像用UltralSO做U盘启动，记录一下遇到的几个问题：
1.不能进入bios修改开机启动：
用了F12,F2和Del键都进不了bios，朋友电脑是联想G50，网上查了一下原来是电源键旁边有个按钮，关机状态按该按钮顺利进入bios；
2.在win7安装界面提示：无法加载CD/DVD驱动程序：
这个问题最坑了，启动U盘插在了usb3.0的口，然而win7安装过程貌似不支持usb3.0, 换了一个usb2.0的口就解决了。
3.选择系统安装位置的时候提示win7不能安装在GPT分区上：
那就需要把硬盘的分区表格式转换成MBR，可以用分区工具，或者在win7安装界面按shift + F10(+Fn)，然后，输入：

```
diskpart.exe #启动diskpart程序
list disk #列出磁盘
sel disk 0  #选择相应磁盘 (根据上面提示，如果你的硬盘是disk 0的话)
clean  #（这个命令会清除硬盘里面的所有资料，请注意）
conver mbr #转换为mbr分区
Create Partition Primary Size=512000 #创建主分区，容量为：512000MB
Active      #激活主分区
Format Quick  #快速格式化当前分区
Create Partition Extended：#创建扩展分区(用所有剩余空间创建扩展分区)

```

