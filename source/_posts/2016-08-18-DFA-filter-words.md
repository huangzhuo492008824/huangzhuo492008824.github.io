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
class Node(object):
    def __init__(self):
        self.children = None

# The encode of word is UTF-8
def add_word(root,word):
    node = root
    for i in range(len(word)):
        if node.children == None:
            node.children = {}
            node.children[word[i]] = Node()

        elif word[i] not in node.children:
            node.children[word[i]] = Node()

        node = node.children[word[i]]

def init(path):
    root = Node()
    fp = open(path,'r')
    for line in fp:
        line = line[0:-1]
        # print len(line)
        # print line
        # print type(line)
        add_word(root,line)
    fp.close()
    return root

# The encode of word is UTF-8
# The encode of message is UTF-8
def is_contain(message, root):
    for i in range(len(message)):
        p = root
        j = i
        while (j<len(message) and p.children!=None and message[j] in p.children):
            p = p.children[message[j]]
            j = j + 1

        if p.children==None:
            #print '---word---',message[i:j]
            return True

    return False

def dfa():
    print '----------------dfa-----------'
    root = init(FILENAME)

    message = '四处乱咬乱吠，吓得家中11岁的女儿躲在屋里不敢出来，直到辖区派出所民警赶到后，才将孩子从屋中救出。最后在征得主人同意后，民警和村民合力将这只发疯的狗打死'
    #message = '不顾'
    print '***message***',len(message)
    start_time = time.time()
    for i in range(10000):
        res = is_contain(message,root)
        #print res
    end_time = time.time()
    print (end_time - start_time)

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

