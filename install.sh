#!/bin/bash

# 获取目录
baseDir=`pwd`
vimDir=${baseDir}/plugin/vim
zshDir=${baseDir}/plugin/zsh

# 先判断网络能否连通，能的话从网络下载，否则使用本地修改的版本
echo "networking test..."
isNetOK=1
ping baidu.com -c 1
pingResult=$?
if [ $pingResult -ne 0 ]; then
    isNetOK=0
fi
echo "networking test complete."

# to install my dotfiles.
## oh-my-zsh
echo "installing oh-my-zsh..."
if [ $isNetOK -eq 1 ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    cp ${zshDir}/lambda-mod.zsh-theme ~/.oh-my-zsh/custom/themes/
    cp ${zshDir}/zshrc ~/.zshrc
else
    sh ${baseDir}/plugin/zsh/oh-my-zsh/tools/install.sh
fi
echo "installing oh-my-zsh complete."

## vim
echo "installing vim plugins..."
if [ -d ~/.vim ]; then
    cp -R ~/.vim ~/.vim.bak
    echo "back up ~/.vim as ~/.vim.bak"
fi
cp -R ${vimDir}/vim ~/.vim

if [ -f ~/.vimrc ]; then
    cp ~/.vimrc ~/.vimrc.bak
    echo "back up ~/.vimrc as ~/.vimrc.bak"
fi
cp ${vimDir}/vimrc ~/.vimrc

mkdir -p /usr/share/vim/vimfiles/colors
cp ${vimDir}/solarized.vim /usr/share/vim/vimfiles/colors/      # vim themes.
echo "installing vim plugins complete."

## others
## install docker
echo "installing docker..."
wget -qO- https://get.docker.com/ | sh
echo "installing docker complete."

## 软件安装
echo "installing other softwares..."
apt install cmatrix
echo "installing other softwares complete."

