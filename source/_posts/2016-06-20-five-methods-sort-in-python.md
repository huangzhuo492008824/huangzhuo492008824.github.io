---
author: huangzhuo
comments: true
date: 2016-06-20 01:20:05+00:00
layout: post
slug: '%e7%94%a8python%e6%9d%a5%e5%86%995%e7%a7%8d%e6%8e%92%e5%ba%8f%e6%96%b9%e6%b3%95'
title: 用Python来写5种排序方法
wordpress_id: 87
categories:
- python
tags:
- linux
- python
- 算法
---
 

中C语言的毒太深了，目前在自学Python，一时兴起用Python写了五种排序


#### 1.冒泡排序：



```

def bubble(ori_list, n):
	"""
	冒泡排序	
	"""
	for i in range(n-1, 0, -1):
		for j in range(0, i):	
			if ori_list[j] > ori_list[j+1]:
				ori_list[j], ori_list[j+1] = ori_list[j+1], ori_list[j]

```





#### 2.选择排序：



```

def select(ori_list, n):
	"""
	选择排序
	"""
	for i in range(1, n):
		min_num = i-1
		j = i
		while j < n:
			if ori_list[j] < ori_list[min_num]:
				min_num = j
			j += 1
		ori_list[i-1], ori_list[min_num] = ori_list[min_num], ori_list[i-1]

```



#### 3.插入排序：



```

def insert(ori_list, n):
	"""
	插入排序
	"""
	for i in range(1, n):
		tmp = ori_list[i]
		j = i - 1
		while j > -1:
			if ori_list[j] > tmp:
				ori_list[j+1] = ori_list[j]
				ori_list[j] = tmp
			j -= 1

```



#### 4.归并排序：



```

def merge(left, right):
	"""
	归并排序
	"""
	i, j = 0, 0
	result = []	
	while i < len(left) and j < len(right):
		if left[i] <= right[j]:
			result.append(left[i])
			i += 1
		else:
			result.append(right[j])
			j += 1
	result += left[i:]
	result += right[j:]
	return result

def merge_sort(ori_list):
	if len(ori_list) <= 1:
		return ori_list	
	mid = len(ori_list)/2
	left = merge_sort(ori_list[:mid])
	right = merge_sort(ori_list[mid:])
	return merge(left, right)

```



#### 5.快速排序：



```

def quick_sort(lists, left, right):
    # 快速排序
    if left >= right:
        return lists
    key = lists[left]
    low = left
    high = right
    while left < right:
        while left < right and lists[right] >= key:
            right -= 1
        lists[left] = lists[right]
        while left < right and lists[left] <= key:
            left += 1
        lists[right] = lists[left]
    lists[right] = key
    quick_sort(lists, low, left - 1)
    quick_sort(lists, left + 1, high)
    return lists
res_list = quick_sort(ori_list, 0, len(ori_list)-1)
print 'quick_sort:', res_list

```

简易写法：

```

def qsort(q):
    if len(q) <= 1:
        return q
    else:
        p = q[0]
    return qsort([x for x in q[1:] if x < p]) + [p] + qsort([x for x in q[1:] if x >= p])

```

