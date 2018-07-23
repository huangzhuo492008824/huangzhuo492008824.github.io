---
author: huangzhuo
comments: true
date: 2016-08-21 16:00:30+00:00
layout: post
slug: python%e6%a8%a1%e6%8b%9f%e7%94%9f%e7%89%a9%e8%bf%9b%e5%8c%96%e5%92%8c%e9%81%97%e4%bc%a0%e7%ae%97%e6%b3%95
title: python模拟生物进化和遗传算法
wordpress_id: 215
categories:
- python
tags:
- python
- 算法
---
 


```

#-*- coding:utf-8 -*-
from PIL import Image as im  
from os import path  
from math import log  
from random import randint  
from copy import deepcopy  
import pickle as pk  
  
#全局变量  
quanju_v = {}  
  
#定义图片预处理函数  
def process_pic(pic_name):  
    print("开始预处理图片")  
    #获得图片对象  
    img = im.open(pic_name)  
    #获得图片的规格  
    img_color = []  
    img_width,img_height = img.size  
    i = 1  
    for x in range(img_height):  
        img_color_tmp = []  
        for y in range(img_width):  
            #获得图片像素的rgb信息  
            r,g,b = img.getpixel((y,x))[:3]  
            #将rgb信息转为10进制数字  
            img_color_tmp.append((r,g,b,r+g+b))  
        img_color.append(img_color_tmp)  
    print("预处理图片结束")  
    return img_color,img.size  
  
#随机基因的函数  
def rand_genes(size):  
    print("图片规格为:{}".format(size))  
    print("正在初始化随机基因")  
    width,height = size  
    genes = []  
    for i in range(100):  
        gene = []  
        for x in range(height):  
            row = []  
            for y in range(width):  
                a = randint(0,255)  
                b = randint(0,255)  
                c = randint(0,255)  
                row.append([a,b,c,a+b+c])  
            gene.append(row)  
        genes.append([gene,0])  
    print("随机基因初始化完成")  
    return genes  
  
#定义适应度计算函数  
def forecast(genes):  
    print("开始处理基因")  
    sum_sum = 0  
    for i,gene in enumerate(genes):  
        sum_ = 0  
        for j,row in enumerate(gene[0]):  
            for k,col in enumerate(row):  
                _a,_b,_c,_d = data[j][k]  
                a,b,c,d = col  
                det_d = abs(_d-d)  
                sum_ += (abs(_a-a) + abs(_b-b) + abs(_c-c))*det_d  
        genes[i][1] = sum_  
        sum_sum += sum_  
    for i,gene in enumerate(genes):  
        genes[i][1] = genes[i][1]/sum_sum  
    print("正在排序基因")  
    genes.sort(key=lambda x:x[1])  
    print("基因处理完成")  
  
    return  
  
#基因变异函数  
def variation(genes,size):  
    rate = 0.5  
    print("开始变异")  
    for i,gene in enumerate(genes):  
        for x,row in enumerate(gene[0]):  
            for y,col in enumerate(row):  
                if randint(1,100)/100 <= rate:  
                    #图片由 r g b 三种颜色混合而成 变异就是改变他们的值  
                    #a b c 分别对应 r_ g_ b_ 改变的值 可自行修改  
                    #r g b 的最大值为255  
#------------------------------请修改这里-------------------------------------#  
                    a = [-1,1][randint(0,1)]*randint(3,10)  
                    b = [-1,1][randint(0,1)]*randint(3,10)  
                    c = [-1,1][randint(0,1)]*randint(3,10)  
#------------------------------请修改这里-------------------------------------#  
                    genes[i][0][x][y][0] += a   
                    genes[i][0][x][y][0] += b  
                    genes[i][0][x][y][0] += c  
                    genes[i][0][x][y][3] += a+b+c  
    print("变异结束")  
      
    return  
  
def merge(gene1,gene2,size):  
    width,height = size  
    x = randint(0,height-1)  
    y = randint(0,width-1)  
    new_gene = deepcopy(gene1[0][:x])  
    new_gene = [new_gene,0]  
    new_gene[0][x:] = deepcopy(gene2[0][x:])  
    new_gene[0][x][:y] = deepcopy(gene1[0][x][:y])  
  
    return new_gene  
  
#定义选择函数  
def select(genes,size):  
    print("这是选择环节 我们会选取种群中按适应度排名的前 三分之二")  
    seek = int(len(genes)*2/3)  
    i = 0  
    back_seek = seek+1  
    while i{}".format(genes[i][1]))  
        genera += 1  
              
#----------------------------------程序主体-----------------------------------#  
  
#---------------------------------程序数据保存模块------------------------------#  
#if not path.exists("quanju_v.tmp"):  
def save_data():  
    global quanju_v  
    print("文件存储中")  
    with open("quanju_v.tmp","wb") as fd:  
        pk.dump(quanju_v,fd)  
    print("文件储存完成")  
#---------------------------------程序数据保存模块------------------------------#  
#main()  
try:  
    main()  
except Exception, err:  
    print 'main exception err:'.format(str(err))
    save_data()


```


