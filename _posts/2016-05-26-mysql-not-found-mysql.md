---
author: huangzhuo
comments: true
date: 2016-05-26 13:41:41+00:00
layout: post
slug: mysql%e4%b8%ad%e6%b2%a1%e6%9c%89mysql%e6%95%b0%e6%8d%ae%e5%ba%93
title: mysql中没有mysql数据库
wordpress_id: 38
categories:
- 技术
tags:
- linux
- mysql
- 数据库
---
{% include JB/setup %}

mysql安装完之后，登陆后发现只有两个数据库：mysql> show databases;




+--------------------+




| Database |




+--------------------+




| information_schema |




| test |




+--------------------+




，mysql> use mysql




ERROR 1044 (42000): Access denied for user ''@'localhost' to database 'mysql'







访问被拒绝，原因就是在删除数据库时（rpm -e mysql*）没有删除干净，需要把/var/lib/mysql的目录全部删除干净，然后再重新安装即可。







顺便记一下一些常用的命令：







一、连接MYSQL。




格式： mysql -h主机地址 -u用户名 －p用户密码







1、连接到本机上的MYSQL。




# mysql -u root -p




回车后提示你输密码，注意用户名前可以有空格也可以没有空格，但是密码前必须没有空格，否则让你重新输入密码。




如果刚安装好MYSQL，超级用户root是没有密码的，故直接回车即可进入到MYSQL中了，MYSQL的提示符是： mysql>







2、连接到远程主机上的MYSQL。假设远程主机的IP为：192.168.2.2，用户名为root，密码为123456。则键入以下命令：




# mysql -h192.168.2.2 -uroot -p123456







3、退出MYSQL命令：




# exit （回车）







二、修改密码。




格式：mysqladmin -u用户名 -p旧密码 password 新密码







1、给root加个密码123456。键入以下命令：




# mysqladmin -u root -password 123456







2、再将root的密码改为56789。




# mysqladmin -u root -p123456 password 56789







三、增加新用户。




格式：grant select on 数据库.* to 用户名@登录主机 identified by “密码”







1、增加一个用户test1密码为abc，让他可以在任何主机上登录，并对所有数据库有查询、插入、修改、删除的权限。首先用root用户连入MYSQL，然后键入以下命令：




mysql>grant select,insert,update,delete on *.* to test1@”%” Identified by “abc”;




mysql>flush privileges; 使之生效







2、增加一个用户test2密码为abc,让他只可以在localhost上登录，并可以对数据库mydb进行查询、插入、修改、删除的操作（localhost指本地主机，即MYSQL数据库所在的那台主机），这样用户即使用知道test2的密码，他也无法从internet上直接访问数据库，只能通过MYSQL主机上的web页来访问了。




mysql>grant select,insert,update,delete on mydb.* to test2@localhost identified by “abc”;




mysql>flush privileges; 使之生效







如果你不想test2有密码，可以再打一个命令将密码消掉。




mysql>grant select,insert,update,delete on mydb.* to test2@localhost identified by “”;




mysql>flush privileges; 使之生效







操作技巧




1、如果你打命令时，回车后发现忘记加分号，你无须重打一遍命令，只要打个分号回车就可以了。也就是说你可以把一个完整的命令分成几行来打，完后用分号作结束标志就OK。




2、你可以使用光标上下键调出以前的命令。







查询、创建、删除、更新命令







1、显示当前数据库服务器中的数据库列表：




mysql>show databases;




注意：mysql库里面有MYSQL的系统信息，我们改密码和新增用户，实际上就是用这个库进行操作。







2、显示数据库中的数据表：




mysql>use 库名；




mysql>show tables;







3、显示数据表的结构：




mysql>describe 表名;







4、建立数据库：




mysql>create database 库名;







5、建立数据表：




mysql>use 库名;




mysql>create table 表名 (字段名 varchar(20), 字段名 char(1));







6、删除数据库：




mysql>drop database 库名;







7、删除数据表：




mysql>drop table 表名;







8、将表中记录清空：




mysql>delete from 表名;







9、显示表中的记录：




mysql>select * from 表名;







10、往表中插入记录：




mysql>insert into 表名 values (”123”,”b”);







11、更新表中数据：




mysql>update 表名 set 字段名1='a',字段名2='b' where 字段名3='c';







12、用文本方式将数据装入数据表中：




mysql>load data local infile “/root/mysql.txt” into table 表名;







13、导入.sql文件命令：




mysql>use 数据库名;




mysql>source /root/mysql.sql;







14、命令行修改root密码：




mysql>update mysql.user set password=PASSWORD('新密码') where user='root';




mysql>flush privileges;







15、显示use的数据库名：




mysql>select database();







16、显示当前的user：




mysql>select user();







备份数据库







1.导出整个数据库，导出文件默认是存在当前操作目录下




# mysqldump -u 用户名 -p 数据库名 > 导出的文件名




# mysqldump -u user_name -p123456 database_name > outfile_name.sql







2.导出一个表




# mysqldump -u 用户名 -p 数据库名 表名> 导出的文件名




# mysqldump -u user_name -p database_name table_name > outfile_name.sql







3.导出一个数据库结构




# mysqldump -u user_name -p -d –add-drop-table database_name > outfile_name.sql




-d 没有数据 –add-drop-table 在每个create语句之前增加一个drop table







4.带语言参数导出




# mysqldump -uroot -p –default-character-set=latin1 –set-charset=gbk –skip-opt database_name > outfile_name.sql
