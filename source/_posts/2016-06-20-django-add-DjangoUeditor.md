---
date: 2016-06-20 04:02:00+00:00
title: Django添加富文本编辑器DjangoUeditor
categories:
- 技术
tags:
- django
- DjangoUeditor
- linux
- python
---
 

1.上DjangoUeditor的github官网下载安装Ueditor，网址如下：https://github.com/zhangfisher/DjangoUeditor.git 按照readme.md安装即可
推荐下载DjangoUeditor源码到项目根目录下

2.django admin中配置富文本编辑器：
a. settings.py中添加apps：

```
INSTALLED_APPS = (             
    'django.contrib.admin',    
    'django.contrib.auth',     
    'django.contrib.contenttypes',
    'django.contrib.sessions', 
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'bootstrap_toolkit',
    'DjangoUeditor',  
    'news',
)
```

b. urls.py中配置ueditor的路由：

```
url(r'^ueditor/', include('DjangoUeditor.urls')),
```


c. models.py中添加ueditor字段：

``` python
from DjangoUeditor.models import UEditorWidget
class News(BaseModel):         
    title = models.CharField(verbose_name=u"新闻标题", max_length=127)
    content = UEditorField(u"文章正文", width=600, height=300, default=u'', blank=True, imagePath="uploads/images/",
             toolbars='besttome', filePath='uploads/files/')
```


d. 在admin.py中添加ueditor

``` python
# -*- encoding: utf-8 -*-
from django.contrib import admin
from django import forms
from models import News
from django.utils.html import strip_tags
from DjangoUeditor.models import UEditorWidget

# Register your models here.
class NewsForm(forms.ModelForm):
    content=forms.CharField(widget=UEditorWidget(attrs={'width': 1000, 'height': 500,
                            'imagePath': 'uploads/images/', 'filePath': 'uploads/files/'}))
    class Meta:
        model = News
        exclude = []

class NewsAdmin(admin.ModelAdmin):
    form = NewsForm
    # 只读字段
    readonly_fields = ['_get_thumbnail', 'create_time']
    # 可编辑的字段
    fields = ['title', 'publish_time','is_active', 'news_type', 'index_flag', 'cover_image', 'slide_show',
              '_get_thumbnail', 'introduce', 'content']
    # 列表页展示字段
    list_display = ('title', 'introduce',)
    # 筛选字段
    list_filter = ['publish_time']
    # 搜索字段
    search_fields = ['title']

    def _get_content(self, obj):
        return strip_tags(obj.content)[:20]
    _get_content.short_description = '内容'
    _get_content.allow_tags = True

admin.site.register(News, NewsAdmin)
```

e. 参数说明：
文件图片和视频都是保存在MEDIA_ROOT目录下，所以需要在settings.py文件中指定MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
imagePath 保存图片的目录
filePath 保存文件的目录



