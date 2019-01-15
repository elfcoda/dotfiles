#!/bin/bash

echo "##################"
echo "##################"

# 获取目录
baseDir=`pwd`
vimDir=${baseDir}/plugin/vim
zshDir=${baseDir}/plugin/zsh

# 先判断网络能否连通，能的话从网络下载，否则使用本地修改的版本
isNetOK=1
ping baidu.com -c 1
pingResult=$?
if [ $pingResult -ne 0 ]; then
    isNetOK=0
fi

# to install my dotfiles.
## zsh

## vimrc
cd
mkdir -p .vim/autoload .vim/bundle
cd .vim
cp ${vimDir}/pathogen.vim autoload/
if [ -f ~/.vimrc ]; then
    cp ~/.vimrc ~/.vimrc.bak
    echo "back up ~/.vimrc as ~/.vimrc.bak"
fi
cp ${vimDir}/vimrc ~/.vimrc



## .vim plugin

## others
## 包括升级更新以及各种常用软件的安装
## 甚至环境部署

## 语言安装

## install docker
wget -qO- https://get.docker.com/ | sh


