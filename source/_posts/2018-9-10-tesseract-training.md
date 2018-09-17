---
date: 2018-09-10 18:19:00+00:00
categories: 验证码识别
title: Tesseract-training-recognize-lib
tags: [图像识别,验证码识别,训练]
---
### tesseract训练
## 采集样本：
* 获取足够多的样本数据，必须是能够覆盖所有被识别的字符集，如果字体比较固定比如印刷体或者是网络的字体库，可以尝试采集到每一个字符然后合成字体库，用完整的一套字体库来训练

### 三种训练方法对比
1. 找到需要识别的图片文本的字体，用字体库训练相应的库 (一般验证码很难找到字体库，找到字体的希望很渺茫)；
2. 采集到足够多的样本，然后切割响应字符串，最后组成一套非重复字符的字体集合，然后训练，亲测有效，特点：准确率高，切割和合并字符可能会麻烦一点;
3. 采集到尽可能多的样本，用所有的样本来训练，特点：工作量大，效果不一定好

### 生成tif字体库
原始需要识别图片转换成tif字体文件，linux有个convert命令可以转换：
``` shell
convert test.png num.font.exp0.tif
```
### 生成训练文件.tr
``` shell
tesseract num.font.exp2.tif num.font.exp2 batch.nochop makebox -psm 7 digits
```
* 上面的命令可以更加需求添加相关参数来提高初次识别的准确率
下载jTessBoxEditor,运行软件， 然后打开刚刚生成的tif文件来挑战识别有误的字符
创建font_properties文件写入：
``` shell
font 0 0 0 0 0 # 【语法】：<fontname> <italic> <bold> <fixed> <serif> <fraktur>  
```
tesseract.exe num.font.exp0.tif num.font.exp0 nobatch box.train 
### 生成训练库并打包到语言包目录
``` shell
unicharset_extractor *.box
shapeclustering -F font_properties -U unicharset *.tr
mftraining -F font_properties  -U unicharset *.tr
cntraining *.tr
mv unicharset shouxie.unicharset
mv inttemp shouxie.inttemp
mv normproto shouxie.normproto
mv pffmtable shouxie.pffmtable
mv shapetable shouxie.shapetable
combine_tessdata shouxie.
cp shouxie.traineddata /usr/local/share/tessdata/
```
* 然后就可以使用shouxie语言库了
tesseract ../shouji1.png stdout -l shouxie

* 训练语言库可以两种语言混合，有点类似基因结合，另外还可以用一些图片降噪手段来增加图片的清晰度来提高准确率；tesseract很强大，能做很多事情，期待后面能够找到更多的应用场景；
