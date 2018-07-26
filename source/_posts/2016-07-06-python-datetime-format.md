---
date: 2016-07-06 09:50:01+00:00
title: python对时间日期做格式化
categories:
- 技术
tags:
- django
- python
- 数据库
---
 

1. Python格式化日期时间的函数为datetime.datetime.strftime()；由字符串转为日期型的函数为：datetime.datetime.strptime()，两个函数都涉及日期时间的格式化字符串，列举如下：
``` shell
%a Abbreviated weekday name
%A Full weekday name
%b Abbreviated month name
%B Full month name
%c Date and time representation appropriate for locale
%d Day of month as decimal number (01 - 31)
%H Hour in 24-hour format (00 - 23)
%I Hour in 12-hour format (01 - 12)
%j Day of year as decimal number (001 - 366)
%m Month as decimal number (01 - 12)
%M Minute as decimal number (00 - 59)
%p Current locale's A.M./P.M. indicator for 12-hour clock
%S Second as decimal number (00 - 59)
%U Week of year as decimal number, with Sunday as first day of week (00 - 51)
%w Weekday as decimal number (0 - 6; Sunday is 0)
%W Week of year as decimal number, with Monday as first day of week (00 - 51)
%x Date representation for current locale
%X Time representation for current locale
%y Year without century, as decimal number (00 - 99)
%Y Year with century, as decimal number
%z, %Z Time-zone name or abbreviation; no characters if time zone is unknown
%% Percent sign
```
举一个例子：

ebay中时间格式为‘Sep-21-09 16:34’

则通过下面代码将这个字符串转换成datetime

>>> c = datetime.datetime.strptime('Sep-21-09 16:34','%b-%d-%y %H:%M');
>>> c
datetime.datetime(2009, 9, 21, 16, 34)

又如：datetime转换成字符串
<blockquote>>> datetime.datetime.now().strftime('%b-%d-%y %H:%M:%S');
'Sep-22-09 16:48:08'</blockquote>

2. 获取指定日期的n个月之后（或之前）的日期

``` python
def months(dt, months):  # 这里的months 参数传入的是正数表示往后 ，负数表示往前
    month = dt.month - 1 + months
    year = dt.year + month / 12
    month = month % 12 + 1
    day = min(dt.day, calendar.monthrange(year, month)[1])
    dt = dt.replace(year=year, month=month, day=day)

    return dt
求两天以前的日期：
```

``` python
today = datetime.datetime.now()
morning_day = datetime.datetime(today.year, today.month, today.day, 0, 0, 0)
before_two_day = today - datetime.timedelta(days=2)
```

3. django utc时间格式不兼容的问题：RuntimeWarning: DateTimeField MonthlyStatistics.start_time received a naive datetime (2016-06-30 00:00:00) while time zone support is active.
 RuntimeWarning)
``` python
import pytz
utc = pytz.timezone('UTC')
today = datetime.date.today()
today_start = datetime.datetime(today.year, today.month, today.day).replace(tzinfo=utc)
end_day = today_start - datetime.timedelta(days=today_start.day)
```
