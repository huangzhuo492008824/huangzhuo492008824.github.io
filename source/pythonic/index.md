---
title: pythonic magic tips
date: 2019-04-9 22:18:36
---

#### 1. setdefault 与 defaultdict：
* setdefault:
``` python
result = {}
data = [("p", 1), ("p", 2), ("p", 3),
        ("h", 1), ("h", 2), ("h", 3)]
for (key, value) in data:
    result.setdefault(key, []).append(value)
```
* defaultdict：
``` python
>>> result = defaultdict(list)
>>> result
defaultdict(<type 'list'>, {})
>>> result['a']
[]
```
参数为 list，它就会构建一个默认value为list的字典，例如result['a']的值默认就是list对象。

因此，前面这段代码可以改为：
``` python
from collections import defaultdict
result = defaultdict(list)
data = [("p", 1), ("p", 2), ("p", 3),
        ("h", 1), ("h", 2), ("h", 3)]

for (key, value) in data:
    result[key].append(value)
```