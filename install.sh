#!/bin/bash

########################################################################################################
##### 警告：此脚本会安装一些乱七八糟的软件和做一些奇奇怪怪的事，所以请不要在公共的机器上执行此脚本 #####
#####                             尤其是不要放在运营环境执行！！！                                 #####
#####                         此脚本可能只适合放在个人的玩具机器上执行！！!                        #####
########################################################################################################

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
## vim
echo "installing vim plugins..."
apt install vim -y
apt install ctags -y
apt install cscope -y
if [ -d ~/.vim ]; then
    cp -R ~/.vim ~/.vim.bak
    rm -rf ~/.vim
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

# install emacs
echo "installing emacs..."
add-apt-repository ppa:ubuntu-elisp/ppa
apt update
apt install emacs-snapshot emacs-snapshot-el -y
echo "echo emacs complete."
# install emacs config
# Todo...


## others
## install docker
echo "installing docker..."
wget -qO- https://get.docker.com/ | sh
service docker stop
echo "installing docker complete."

## 软件安装
echo "installing other softwares..."
apt install cmatrix
echo "installing other softwares complete."

## oh-my-zsh 安装完这个会切shell，所以把它放到最后安装。
echo "installing oh-my-zsh..."
apt install zsh -y
if [ $isNetOK -eq 1 ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    cp ${zshDir}/lambda-mod.zsh-theme ~/.oh-my-zsh/custom/themes/
else
    sh ${baseDir}/plugin/zsh/oh-my-zsh/tools/install.sh
fi
cp ${zshDir}/zshrc ~/.zshrc
echo "installing oh-my-zsh complete."

