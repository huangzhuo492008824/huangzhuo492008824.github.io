---
date: 2016-06-21 14:30:54+00:00
title: python中的中英文混搭字符串中文的提取
categories:
- 技术
tags:
- python
---
 

### 模块内容
re.compile(pattern, flags=0)
编译正则表达式，返回RegexObject对象，然后可以通过RegexObject对象调用match()和search()方法。

``` python
#coding=utf-8
import re
s = 'hi新手oh'.decode('utf-8') #举个栗子是字符串s，为了匹配下文的unicode形式，所以需要解码
p = re.compile(ur'[\u4e00-\u9fa5]') #这里是精髓，[\u4e00-\u9fa5]是匹配所有中文的正则，因为是unicode形式，所以也要转为ur
```

print p.split(s) #使用re库的split切割

中英文混搭字符串中文的提取

``` python
import re
mys = u'hi新手oh上o路hea多ooo多oo指教98' #提取其中的中文字符串
p = re.compile(ur'[\u4e00-\u9fa5]')
res = re.findall(p, mys)
result = ''.join(res)
print result
```

新手上路多多指教

###![正则图]({{ IMAGE_PATH }}2016/06/正则图-1.png)
![正则图]({{ IMAGE_PATH }}home-bg.jpg)
