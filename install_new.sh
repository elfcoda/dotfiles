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
fontsDir=${baseDir}/plugin/fonts

# 先判断网络能否连通，能的话从网络下载，否则使用本地修改的版本

## install necessary softwares.
apt install git -y
apt install python-pip -y
apt install python3-pip -y

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

################## install emacs ## and i will use emacs
echo "installing emacs..."
add-apt-repository ppa:ubuntu-elisp/ppa
apt update
apt install emacs-snapshot emacs-snapshot-el -y
echo "echo emacs complete."
# install emacs config
# restart emacs for serverl times and it will success.
# Spacemacs will automatically install the packages it requires. If you get an error regarding package downloads then 
# you may try to disable the HTTPS protocol by starting Emacs with: (emacs --insecure)
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
### fonts shell code In plugin/fonts directory.
# install Source Code Pro.
sh ${fontsDir}/source-code-pro-install.sh
## And then the gui mode is ok.

### install powerline fonts. 
# https://github.com/powerline/fonts
# On other environments, you can copy and paste these commands to your terminal. Comments are fine too.
# git clone https://github.com/powerline/fonts.git --depth=1
# cd fonts
# ./install.sh
# cd ..
# rm -rf fonts
apt install fonts-powerline -y
### install VundleVim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
### install vim-airline
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
### install vim-airline-themes
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
### install html plugin
git clone https://github.com/mattn/emmet-vim.git ~/.vim/bundle/emmet-vim
### install lisp plugin(slimv)
git clone https://github.com/kovisoft/slimv.git ~/.vim/bundle/slimv
### install rainbow parentheses
git clone https://github.com/kien/rainbow_parentheses.vim.git ~/.vim/bundle/rainbow_parentheses

## others
## 软件安装
echo "installing other softwares..."
apt install cmatrix -y
# install translation tools
# sudo npm install fanyi -g
sudo apt install translate-shell -y # usage: trans [Words]  .. man trans | trans -R | trans [en]:ta thanks
# install haskell
sudo apt install haskell-platform -y
echo "installing other softwares complete."

## oh-my-zsh 安装完这个会切shell，所以把它放到最后安装。
echo "installing oh-my-zsh..."
apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp ${zshDir}/lambda-mod.zsh-theme ~/.oh-my-zsh/custom/themes/
cp ${zshDir}/zshrc ~/.zshrc
echo "installing oh-my-zsh complete."

