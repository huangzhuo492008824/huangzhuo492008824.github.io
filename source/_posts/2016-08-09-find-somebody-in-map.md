---
date: 2016-08-09 08:20:53+00:00
title: 查找附近的人功能实现
categories:
- 技术
tags:
- python
- redis
- 数据库
- 系统
---
 

* 查找附近的人是移动开发非常流行的功能，最近在给移动端写后台接口，上午查了很多资料发现用geohash算法的人居多，本来想自己设计数据库来实现以下geohash的，但是项目赶得紧，正好发现新版的redis支持geo的地理位置的操作：

1. 安装最新版的redis3.2.3+
2. redis的geo模块支持的操作有：

添加位置和获取位置
为了进行地理位置相关操作， 我们首先需要将具体的地理位置记录起来， 这一点可以通过执行 GEOADD 命令来完成， 该命令的基本格式如下：

``` shell
GEOADD location-set longitude latitude name [longitude latitude name ...]

```

GEOADD 命令每次可以添加一个或多个经纬度地理位置。 其中 location-set 为储存地理位置的集合， 而 longitude 、 latitude 和 name 则分别为地理位置的经度、纬度、名字。

举个例子， 以下代码展示了如何通过 GEOADD 命令， 将清远、广州、佛山、东莞、深圳等数个广东省的市添加到位置集合 Guangdong-cities 里面：

``` shell
redis> GEOADD Guangdong-cities 113.2099647 23.593675 Qingyuan
```

1. -- 成功添加一个位置

``` shell
redis> GEOADD Guangdong-cities 113.2278442 23.1255978 Guangzhou 113.106308 23.0088312 Foshan 113.7943267 22.9761989 Dongguan 114.0538788 22.5551603 Shenzhen
```

4. -- 成功添加四个位置
在将位置记录到位置集合之后， 我们可以使用 GEOPOS 命令， 输入位置的名字并取得位置的具体经纬度：

``` shell
GEOPOS location-set name [name ...]
```

比如说， 如果我们想要获取清远、广州和佛山的经纬度， 那么可以执行以下代码：
``` shell 
redis> GEOPOS Guangdong-cities Qingyuan Guangzhou Foshan
1) 1) "113.20996731519699" -- 清远的经度
2) "23.593675019671288" -- 清远的纬度
2) 1) "113.22784155607224" -- 广州的经度
2) "23.125598202060807" -- 广州的纬度
3) 1) "113.10631066560745" -- 佛山的经度
2) "23.008831202413539" -- 佛山的纬度
```

* 计算两个位置之间的距离
* 在拥有了地理数据之后， 我们就可以基于这些数据进行各种各样的操作。 针对地理位置信息的其中一个最简单的操作， 就是计算两个位置之间的距离。

* 在 Redis 里面， 计算两个位置之间的距离可以通过 GEODIST 命令来实现：

``` shell 
GEODIST location-set location-x location-y [unit]
```

在调用这个命令时， 用户需要给定想要计算差距的地点 location-x 和 location-y ， 以及储存这两个地点的地理位置集合。

可选参数 unit 用于指定计算距离时的单位， 它的值可以是以下单位的其中一个：

m 表示单位为米。
km 表示单位为千米。
mi 表示单位为英里。
ft 表示单位为英尺。
如果用户没有指定 unit 参数， 那么 GEODIST 默认使用米为单位。

作为例子， 以下代码展示了如何计算清远和广州之间的距离：
``` shell 
redis> GEODIST Guangdong-cities Qingyuan Guangzhou
```

"52094.433840356309" -- 两地相距 52094 米
上面的计算结果使用了米来表示清远和广州两地的距离， 不过在表示比较长的距离时， 我们更习惯采用公里（km）作为单位。 通过显式地给定 km （千米）作为单位， 我们可以让 GEODIST 显示两个地点之间相距的公里数：
``` shell
redis> GEODIST Guangdong-cities Qingyuan Guangzhou km
```
"52.094433840356309" -- 两地相距 52 公里

获取指定范围内的元素
除了计算两地的距离之外， 另一个常见的地理位置操作就是找出特定范围之内的其他存在的地点。 比如找出地点 x 范围 100 米之内的所有地点， 找出地点 y 范围 50 公里之内的所有地点等等。

Redis 提供了 GEORADIUS 和 GEORADIUSBYMEMBER 两个命令来实现查找特定范围内地点的功能， 它们的作用一样， 只是指定中心点的方式不同： GEORADIUS 使用用户给定的经纬度作为计算范围时的中心点， 而 GEORADIUSBYMEMBER 则使用储存在位置集合里面的某个地点作为中心点。 以下是这两个命令的基本格式：

``` shell
GEORADIUS location-set longitude latitude radius m|km|ft|mi [WITHCOORD] [WITHDIST] [ASC|DESC] [COUNT count]
GEORADIUSBYMEMBER location-set location radius m|km|ft|mi [WITHCOORD] [WITHDIST] [ASC|DESC] [COUNT count]
```

* 这两个命令的各个参数的意义如下：
m|km|ft|mi 指定的是计算范围时的单位；
如果给定了可选的 WITHCOORD ， 那么命令在返回匹配的位置时会将位置的经纬度一并返回；
如果给定了可选的 WITHDIST ， 那么命令在返回匹配的位置时会将位置与中心点之间的距离一并返回；
在默认情况下， GEORADIUS 和 GEORADIUSBYMEMBER 的结果是未排序的， ASC 可以让查找结果根据距离从近到远排序， 而 DESC 则可以让查找结果根据从远到近排序；
COUNT 参数指定要返回的结果数量。
作为示例， 我们可以使用 GEORADIUSBYMEMBER 去找出位于广州 50 公里、 100 公里以及 150 公里以内的城市：

``` shell
redis> GEORADIUSBYMEMBER Guangdong-cities Guangzhou 50 km
1) "Foshan"
2) "Guangzhou"

redis> GEORADIUSBYMEMBER Guangdong-cities Guangzhou 100 km
1) "Foshan"
2) "Guangzhou"
3) "Dongguan"
4) "Qingyuan"

redis> GEORADIUSBYMEMBER Guangdong-cities Guangzhou 150 km
1) "Foshan"
2) "Guangzhou"
3) "Dongguan"
4) "Qingyuan"
5) "Shenzhen"
```

* geohash查找精度：
![geo精度]({{ IMAGE_PATH }}2016/08/geo精度.png)
示例：查找附近的人
好的， 在了解了 Redis GEO 特性的基本信息之后， 接下来我们该思考如何使用这些特性去解决实际的问题了。

为了让用户可以方便地找到自己附近的其他用户， 每个社交网站基本上都内置了“查找附近的人”这一功能， 通过 Redis ， 我们也可以实现同样的功能， 以下是实现该功能的伪代码：
``` python
def pin(user, longitude, latitude):
"""
记录用户的地理位置。
"""
GEOADD('user-location-set', longitude, latitude, user)

def find_nearby(user, n):
"""
返回指定用户附近 n 公里的所有其他用户。
"""
return GEORADIUSBYMEMBER('user-location-set', user, n, unit='km')
```

示例：摇一摇
为了增加乐趣性， 我们可以对“查找附近的人”这一功能进行修改 —— 程序不是返回指定范围内的所有人， 而是随机地返回指定范围内的某个人， 这也就是非常著名的“摇一摇”功能。 以下是实现该功能的伪代码：
``` python
RANDOM_RADIUS = 1 # 随机查找的范围为 1 公里

def find_random(user):
# 获取范围内的所有其他用户
get_all_near_users = find_nearby(user, RANDOM_RADIUS)
# 将查找的结果从 Python 列表转换为 Python 集合
user_set = set(get_all_near_users)
# 然后调用 pop() 方法，从集合里面随机地移除并返回一个元素
return user_set.pop()

``` python
    # python目前的连接redis的第三方模块暂时没发现支持geo模块的，但是redis模块有一个execute_command()的函数支持传入redis命令：
    db = redis.Redis(host=self.ip, port=self.port, db=0, password=self.password)
    db.execute_command('geoadd', collect, lng, lat, user_id)
    db.execute_command('georadiusbymember', collect, user_id, distance, 'm')

```
* 简单的测了一下：百万条地理位置信息，查询附近的人只需要0.002秒左右，redis还是很给力的，以后要多多研究
