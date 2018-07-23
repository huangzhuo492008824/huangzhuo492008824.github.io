---
date: 2018-07-21 9:49:32+00:00
categories: [git, cmd, summary]
title: git常用命令总结
---

## 版本控制系统（VCS）
* 版本控制系统（Version Control System）是一种记录一个或若干文件内容变化历史的系统。
![集中式VCS](/uploads/git-cmd-summary/one-center.jpg)
*集中化的版本控制系统(CVS，SVN)*


![分布式VCS](/uploads/git-cmd-summary/distribute.jpg)
*分布式版本控制系统（Git)*
## Git 的诞生 ##
* Git是目前世界上最先进的分布式版本控制系统（没有之一）
* 好不好用，看看它的开发者是谁就知道了：Linux之父 Linus Torvalds 
* Linux内核社区原本使用的是名为BitKeeper的商业化版本控制工具，2005年，因为社区内有人试图破解BitKeeper的协议，BitMover公司收回了免费使用BitKeeper的权力；
* Linus原本可以出面道个歉，继续使用BitKeeper，然而并没有… Linus大神仅用了两周时间，自已用C写了一个分布式版本控制系统，于是Git诞生了！

## Git 与GitHub
* Git： 是一种开源的版本控制系统，可以高效的管理项目版本，同时也是一种协议；
* GitHub： 是一个面向开源及私有软件项目的托管平台, 私有项目收费；
* GitLab： 社区版相当于私有版的github，可以自己搭建GitLab仓库服务器，企业版收费；
* Gitee：码云(gitee.com)是开源中国推出的代码托管平台,支持 Git 和 SVN,提供免费的私有仓库托管；
![linus大叔pic](/uploads/git-cmd-summary/linus.jpg)
*linus大叔*

## Git基本原理
![](/uploads/git-cmd-summary/git-basic1.png)
* git add files 把当前文件放入暂存区域。
* git commit 给暂存区域生成快照并提交。
* git reset -- files 用来撤销最后一次git add files，你也可以用git reset 撤销所有暂存区域文件。
* git checkout -- files 把文件从暂存区域复制到工作目录，用来丢弃本地修改。
![](/uploads/git-cmd-summary/git-basic2.png)
* git commit -a 相当于运行 git add 把所有当前目录下的文件加入暂存区域再运行git commit.
* git commit files 进行一次包含最后一次提交加上工作目录中文件快照的提交。并且文件被添加到暂存区域。
* git checkout HEAD -- files 回滚到复制最后一次提交。

## Git基本命令
``` shell
git status 查看代码修改状态
git clone 克隆代码
git diff 查看差异部分
git pull origin <branch>	拉取
git push origin <branch> 推送
git checkout <本地分支名> 切换到指定分支
git checkout –b <new_branch> 基于当前分支切换到指定分支
git merge <other_branch> 合并其他分支到当前分支(多了一次merge信息)
git rebase <other_branch> 基于其他分支应用合并
```
## git常见冲突解决
``` shell
CONFLICT (content): Merge conflict in readme.md
git merge中：
git add .   
git commit –m ””

git rebase :
git rebase –continue
```
## 紧急bug修复
``` shell
git stash :暂存当前编辑的代码
git checkout hotfix
git stash pop :切换到bug修复前的工作目录
```
## 快捷键设置
* 经常使用git命令,设置快捷键会方便很多,设置方式如下:
``` shell
git config --global alias.st status
```
* 或者:
* 修改~/.gitconfig,加入以下部分:
``` shell
[alias]
co = checkout
ci = commit
st = status
br = branch
sh = stash
sp = stash pop
pu = push
pr = pull -r
rb = rebase
lg = log -p
```
* 更多命令：git help



