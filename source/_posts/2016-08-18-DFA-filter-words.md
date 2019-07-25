---
date: 2016-08-18 08:26:49+00:00
title: 用DFA算法来实现敏感词汇的过滤
categories:
- 技术
tags:
- DFA
- python
- 算法
- 过滤敏感词
---
 

工作中遇到一个过滤敏感词汇的问题，网上找了一下主要解决方法有3种思路：
【可行思路】
1、暴力匹配--这个就算了，只是说说而已，实际应用中很少的。
2、正则表达式，暂时没有用过
3、利用DFA实现文字过滤，
本文主要研究的就是DFA算法，在计算理论中，确定有限状态自动机或确定有限自动机（英语：deterministic finite automation, DFA）是一个能实现状态转移的自动机。对于一个给定的属于该自动机的状态和一个属于该自动机字母表的字符，它都能根据事先给定的转移函数转移到下一个状态（这个状态可以是先前那个状态）。以上是wiki上的介绍，通俗点来讲就是实现了一个链表，每个元素是一个字典，字典中存储的是敏感词的单位子串，子串也是一个链表元素内容也是一个字典，描述起来有点绕，还是图来的实在：

![dfa]({{ IMAGE_PATH }}2016/08/dfa.png)

python代码实现：

``` python
# -*- coding:utf-8 -*-
import time
import copy
FILENAME = 'dict.txt'

class DFA(object):
    def __init__(self, filename):
        """
        初始化装载敏感词
        """
        self.data = {}
        with open(filename, 'r') as fp:
            lines = fp.readlines()
            for line in lines:
                l_d = line.strip().split()[-1]
                t = self.data
                for w in l_d:
                    if not t.get(w):
                        # print(self.data)
                        t[w] = {'is_end': False}
                        # print(self.data)
                    t = t[w]
                # print(t)
                t['is_end'] = True

    def has_sensitive(self, word):
        """是否包含某个敏感词"""
        t = self.data
        for w in word:
            if t.get(w):
                t = t[w]
            else:
                return False
        if t['is_end']:
            return True
        return False

    def sensitive_replace(self, words):
        """句子中敏感词替换"""
        new_words = copy.deepcopy(words)
        for s in range(len(words)):
            t = self.data
            for e in range(s, len(words)-1):
                # print(s, e, words[e], t.get(words[e]))
                if t.get(words[e]):
                    t = t[words[e]]
                else:
                    break
            if t.get('is_end'):
                word = new_words[s:e]
                # print('enter is_end', word)
                new_words = new_words.replace(word, len(word)*'*')
        return new_words

message = '四处乱咬乱吠，办理证件吓得家中11岁的女儿躲在屋里不敢出来，直到辖区派出所民警赶到后，才将孩子从屋中救出。最后在征得主人同意后，民警和村民合力将这只发疯的狗打死'

dfa = DFA(FILENAME)
print(dfa.has_sensitive('办理证件'))
print(dfa.sensitive_replace(message))

start_time = time.time()
for i in range(10000):
    s = i % len(message)
    res = dfa.sensitive_replace(message[s:])
    print(res)
end_time = time.time()
print(end_time - start_time)

```

14600个敏感词汇查询10000次，普通暴力和dfa对比测试结果：

``` shell
----------------dfa-----------
***message*** 224
0.976715803146
------------normal--------------
***message*** 224
The count of word: 14600
30.5309519768

Process finished with exit code 0

```

