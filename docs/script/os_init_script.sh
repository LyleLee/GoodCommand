#!/bin/bash

# os init script

yum install -y vim git
yum groupinstall -y "Development Tools"
yum install kernel-devel-$(uname -r)


cat <<"EOF"  >> ~/.bashrc

alias full='_full(){ ls $PWD/$1; };_full'
alias rp='realpath () { 
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
};realpath'
alias cleancmake='rm CMakeFiles/ -rf; rm cmake_install.cmake; rm CMakeCache.txt Makefile'
alias grep='grep --exclude-dir={.git} --binary-files=without-match --color=auto --exclude={GPATH,GRTAGS,GTAGS,tags} '
EOF
source ~/.bashrc

cat <<"EOF"> ~/.tmux.conf

# Make mouse useful in copy mode
setw -g mode-mouse on

# Allow mouse to select which pane to use
set -g mouse-select-pane on

# Allow mouse dragging to resize panes
set -g mouse-resize-pane on

# Allow mouse to select windows
set -g mouse-select-window on

# Allow xterm titles in terminal window, terminal scrolling with scrollbar, and setting overrides of C-Up, C-Down, C-Left, C-Right
# (commented out because it disables cursor navigation in vim)
#set -g terminal-overrides "xterm*:XT:smcup@:rmcup@:kUP5=\eOA:kDN5=\eOB:kLFT5=\eOD:kRIT5=\eOC"

# Scroll History
set -g history-limit 30000

# Set ability to capture on start and restore on exit window data when running an application
setw -g alternate-screen on

# Lower escape timing from 500ms to 50ms for quicker response to scroll-buffer access.
set -s escape-time 50
EOF

.git/config

[sendemail]
        smtpserver = smtp.qq.com
        smtpuser = lixianfa.official@qq.com
        smtppass = nezrsekvnaghfhii
        from = lixianfa.official@qq.com
        confirm = always

# setup vundlevim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

cat <<"EOF"  >> ~/.vimrc
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
EOF

