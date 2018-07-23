---
author: huangzhuo
comments: true
date: 2016-08-22 07:39:23+00:00
layout: post
slug: django%e4%b8%ad%e8%8e%b7%e5%8f%96%e8%af%b7%e6%b1%82%e5%a4%b4header
title: Django中获取请求头header
wordpress_id: 217
categories:
- django
- python
tags:
- django
- python
---
 

requests库来模拟请求

```

#test header
headers = { "Accept":"text/html,application/xhtml+xml,application/xml;",
            "Accept-Encoding":"gzip",
            "Accept-Language":"zh-CN,zh;q=0.8",
            "Referer":"http://www.example.com/",
            "User-Agent":"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36",
            "myuser": 'hello',
            }
payload = {'user_id': 11, 'token': 'token', 'is_reported': 25, 'content': u'不正当经营', 'is_activity': True}
r = requests.get('http://localhost:9000/test/', data=payload, headers=headers)
print r.text

```

request请求头信息的键会加上HTTP_转换成大写存到request.META中

```

def test(request):
    if request.method == 'GET':
        # header = request.get('header', None)
        msg = {'code': 200}
        print 'request:', dir(request)
        print 'meta:', request.META
        print 'GET:', dir(request.GET)
        print 'user:', request.META.get('HTTP_MYUSER', None)
        fp = open('out.txt', 'w')
        fp.write('request:%s\n' % str(request))
        fp.write('request:%s\n' % str(request.META))
        fp.write('request:%s\n' % str(request.GET))
        fp.close()
        # response['X-DJANGO'] = "It's the best."
        return HttpResponse(json.dumps(msg), content_type="application/json")

```


django官网的解释：

```

HttpRequest.META
A standard Python dictionary containing all available HTTP headers. Available headers depend on the client and server, but here are some examples:

CONTENT_LENGTH – the length of the request body (as a string).

CONTENT_TYPE – the MIME type of the request body.

HTTP_ACCEPT_ENCODING – Acceptable encodings for the response.

HTTP_ACCEPT_LANGUAGE – Acceptable languages for the response.

HTTP_HOST – The HTTP Host header sent by the client.

HTTP_REFERER – The referring page, if any.

HTTP_USER_AGENT – The client’s user-agent string.

QUERY_STRING – The query string, as a single (unparsed) string.

REMOTE_ADDR – The IP address of the client.

REMOTE_HOST – The hostname of the client.

REMOTE_USER – The user authenticated by the Web server, if any.

REQUEST_METHOD – A string such as "GET" or "POST".

SERVER_NAME – The hostname of the server.

SERVER_PORT – The port of the server (as a string).

With the exception of CONTENT_LENGTH and CONTENT_TYPE, as given above, any HTTP headers in the request are converted toMETA keys by converting all characters to uppercase, replacing any hyphens with underscores and adding an HTTP_ prefix to the name. So, for example, a header called X-Bender would be mapped to the META key HTTP_X_BENDER.

```


