#1
HISTFILE=~/.zhistory
SAVEHIST=100000 #number of command saving in .zhistory
HISTSIZE=10000 #in zsh executing
alias history='history -10000'
#2
PS1='%%'
PS1='%n%% '
RPS1='[%~]'

autoload -U colors  #color
colors

#PS1="%{${fg[blue]}${bg[red]}%}"
#PROMPT='%{^[[32m%}%B%U%n@%m%#%{^[[m%}%u%b '
#RPROMPT='%{^[[32m%}%B[%d]%{^[[m%}%b'
#SPROMPT='%{^[[33m%} %BCurrenct> '\''%r'\'' [Yes, No, Abort, Edit]%{^[[m%}%b '

autoload -U compinit
compinit

#3
setopt IGNORE_EOF  #Ctrl+dによるログアウトを防ぐ
setopt NO_CLOBBER  #ファイルの上書きを阻止する
#setopt CORRECT_ALL


#history系
# 複数のzshを同時に使用したときに履歴ファイルを上書きせず追加する
setopt APPEND_HISTORY
# 履歴ファイルに時刻を記載
setopt EXTENDED_HISTORY
# 直前と同じコマンドを履歴に残さない
setopt HIST_IGNORE_DUPS
# 履歴を複数端末で共有
setopt SHARE_HISTORY


#5
watch=(all)  #ログイン、ログアウトの監視

setopt MULTIOS  #(default)リダイレクトで複数のファイルを指定することができる




#
unsetopt BEEP

alias ls='ls -FCG'

#setopt LIST_ROWS_FIRST  #
#setopt AUTO_CD #cdコマンドの自動入力(ディレクトリ名だけで移動)

#setopt AUTO_CDABLE_VARS
#setopt CDABLE_VARS
#setopt PUSHD_IGNORE_DUPS
#setopt PUSHD_SILENT  #pushd実行後にディレクトリスタックの情報を表示しない
setopt AUTO_PUSHD  #cdコマンドでもディレクトリスタックに保存する
setopt PUSHD_TO_HOME  #pushd実行でホームディレクトリに移動する

setopt NOHUP


#8
NULLCMD=cat  #コマンドを省略して>をおこなった場合の実行コマンドを定義する(default cat)
READNULLCMD=more  #コマンドを省略して<をおこなった場合の実行コマンドを定義する(default more)

printArg0 () {
    echo "Argument = $*"
    echo "Num of Argument = $#"
    echo "Arg[1] = $argv[1], Arg[2] = $argv[2]"
}
#fpath1=(~/func $fpath1)
#autoload ${fpath1[1]}/*(:t)

#fpath1=(~/education/c/pjt $fpath1)
#autolosd ${fpath1[1]}/*(:t)



#10
alias -g G='|grep'
setopt CORRECT_ALL #ファイル名,コマンド名の訂正機能をオンにする
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
export PAGER=/opt/local/bin/less
#11
FCEDIT=emacs

#own
alias rm='rm -v'

autoload -Uz zmv
alias zmv='noglob zmv -W'

# zsh option
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる

# zstyle
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=1  # 補完中の対象をハイライトする

# function
function docker-machine-start() {
    docker-machine start $1
    if (docker-machine env $1 2>&1 | grep -q 'regenerate-certs'); then
        docker-machine regenerate-certs $1
    fi
}

#tex
#2015/02/18
export TEXINPUTS=.:~/src/:

#R
export R_HOME=/Library/Frameworks/R.framework/Versions/3.0/Resources/

# Xcode
#alias symbolicatecrash='/Applications/Xcode.app/Contents/SharedFrameworks/DTDeviceKitBase.framework/Versions/A/Resources/symbolicatecrash'
# Xcode 7.3
alias symbolicatecrash='/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash'

#export DEVELOPER_DIR="/Applications/Xcode-6.4.app/Contents/Developer/"
export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer/"

# less
export LESS='-R'
export LESSOPEN='|lessfilter %s'
#export LESSOPEN='| /opt/local/bin/src-hilite-lesspipe.sh %s'
export LESSKEY='~/.lesskey'

#cat
alias cat='pygmentize -O style=monokai -f terminal256 -g -O encoding=utf-8'
function cl() {
    c $1 | nl -n ln -b a
}

#homebrew
export HOMEBREW_CACHE=/opt/homebrew/cache

#grep
export GREP_COLOR="01;32"
export GREP_OPTIONS=--color=auto

#ruby
#export RACK_ENV=development
eval "$(rbenv init -)"

# aws
source /opt/homebrew/share/zsh/site-functions/_aws

# cocoapods
alias pod=/Users/ryuichi/.rbenv/shims/pod
#alias pod=/usr/local/bin/pod

# diff
if [[ -x `which colordiff` ]]; then
    alias diff='colordiff -uprN'
else
    alias diff='diff -uprN'
fi

# github
eval "$(hub alias -s)"
compdef hub=git
alias git-log='git log --all --date-order --graph --oneline --decorate'

# go
#export GOROOT=$HOME/lib/go
#export GOBIN=$GOROOT/bin
export GOPATH=$HOME/lib/go/pkg
export PATH="$GOPATH/bin:$PATH"

# js
export JSCPATH=/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources
export PATH="$JSCPATH:$PATH"
alias js2coffee=/opt/local/lib/node_modules/js2coffee/bin/js2coffee
export PATH="`yarn global bin`:$PATH"

# chrome
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# python
eval "$(pyenv init -)"