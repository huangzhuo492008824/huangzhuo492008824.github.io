#!/bin/bash

hexo clean
hexo g

chmod -R 755 public/*

scp -r public/* root@47.94.13.169:/home/workplace/myhuangzhuo/
