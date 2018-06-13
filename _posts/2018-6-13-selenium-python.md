---
author: huangzhuo
comments: true
date: 2018-06-13 11:49:32+00:00
layout: post
slug: selenium python
title: selenium python笔记
---

# selenium python
- 最新版selenium 3.x已经不支持phantomjs了，桑心；需要用phantomjs的可以用selenium2.x
- selenium调用webdriver可以是本地的浏览器也可以是远程的，本地的webdriver(chrome,firefox)都需要下载driver，远程的需要下载一个selenium-stand，然后java -jar selenium-server-standalone-3.12.0.jar

```python
from PIL import Image
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36'
chrome_options = Options()
chrome_options.add_argument('user-agent={}'.format(USER_AGENT))
chrome_options.add_argument('--headless')
# local webdriver
driver = webdriver.Firefox(executable_path='./geckodriver', firefox_options=chrome_options)
# remote webdriver
dcap = dict(DesiredCapabilities.PHANTOMJS)
dcap["phantomjs.page.settings.userAgent"] = (
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36'
)
driver = webdriver.remote.webdriver.WebDriver(command_executor="http://172.16.56.13:4444/wd/hub",
                                        desired_capabilities=dcap)
# set cookie
driver.get('https://baidu.com/')
driver.delete_all_cookies()
cookie_list = [
    {'name': 'hehe', 'value':'222'}
]
for i in cookie_list:
    driver.add_cookie(i)
real_url = 'https://baidu.com'
driver.get(real_url)
# screenshot
driver.get_screenshot_as_file(before_png)
# save html
with open(before_html, 'w') as fp:
    fp.write(driver.page_source.encode('utf-8'))
# find selector and click
next_step = driver.find_element_by_css_selector('a[data="guideLayer"]')
next_step.click()
# scrop selector
def crop_selector(driver, filename, selector, dist):
    """ crop photo through selector. """
    element = driver.find_element_by_css_selector(selector)
    left = element.location['x']
    top = element.location['y']
    right = element.location['x'] + element.size['width']
    bottom = element.location['y'] + element.size['height']

    im = Image.open(filename)
    im = im.crop((left, top, right, bottom))
    im.save(dist)
crop_selector(driver, full_screen, 'img.book', email)
driver.quit()
```
- 几个小坑
1. add_cookie在使用chrome或firefox作为webdriver的时候，必须先get一次目标站点的域名，然后再add，推测可能是driver的问题，使用phantomjs可以直接add之后再get；
2. remote webdriver使用phantomjs必须使用selenium-server-standalone-2.x.jar
``` shell
java -jar selenium-server-standalone-2.53.1.jar  -Dphantomjs.binary.path=/usr/local/bin/phantomjs
```
