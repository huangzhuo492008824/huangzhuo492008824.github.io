---
date: 2016-10-25 07:17:31+00:00
title: Mac下安装python连接mysql工具MySQLdb
categories:
- 其它
tags: [mac,xcode]
---
 

## 解决mac升级10.11后，出现的 xcrun: error: invalid active developer path, missing xcrun 错误


前天把小mac升级到了10.11，结果今天在终端里使用git的时候，弹出一行莫名其妙的错误：

```
xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
```

```

去google了一圈，找到了一个github上homebrew issues里[很老的帖子](https://github.com/Homebrew/homebrew/issues/23500)，按着里面说的，重装了一下xcode command line，结果就正常了……

```
xcode-select --install
```

