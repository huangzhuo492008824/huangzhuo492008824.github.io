#!/bin/bash

hexo clean
hexo g
rm -rf public/uploads/*.jpg
rm -rf public/uploads/git-cmd-summary
rm -rf public/uploads/graphql
rm -rf public/uploads/news
rm -rf public/uploads/post-grpc
rm -rf public/uploads/tesseract
rm -rf public/uploads/uwsgi-gunicorn
rm -rf public/uploads/mysql-groupby
rm -rf public/images
rm -rf public/css
rm -rf public/2016*
rm -rf public/2017*
rm -rf public/2018*

chmod -R 755 public/*

scp -r public/* root@47.94.13.169:/home/workplace/myhuangzhuo/
