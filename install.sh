#!/bin/bash

echo "##################"
echo "##################"

# 先判断网络能否连通，能的话从网络下载，否则使用本地修改的版本
ping baidu.com -c 1
pingResult=$?
isNetOK=1
if [ $pingResult -ne 0 ]; then
    isNetOK=0
fi

# to install my dotfiles.

## zsh

## vimrc

## .vim plugin

## others
## 包括升级更新以及各种常用软件的安装
## 甚至环境部署

## 语言安装

## docker?


