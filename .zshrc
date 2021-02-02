# -------------------------------------
# 環境変数
# -------------------------------------

# SSHで接続した先で日本語が使えるようにする
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# エディタ
# export EDITOR=/usr/local/bin/vim

# ページャ
# export PAGER=/usr/local/bin/vimpager
# export MANPAGER=/usr/local/bin/vimpager

# -------------------------------------
# zshのオプション
# -------------------------------------

## 補完機能の強化
autoload -U compinit
compinit

## 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

## 色を使う
setopt prompt_subst

## ^Dでログアウトしない。
setopt ignoreeof

## バックグラウンドジョブが終了したらすぐに知らせる。
setopt no_tify

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 補完
## タブによるファイルの順番切り替えをしない
unsetopt auto_menu

# cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_pushd

# ディレクトリ名を入力するだけでcdできるようにする
setopt auto_cd

# curlとか叩いたときのno matches foundエラーをなくす
setopt nonomatch

# -------------------------------------
# パス
# -------------------------------------

# 重複する要素を自動的に削除
typeset -U path cdpath fpath manpath

path=(
    $HOME/bin(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $path
)

# -------------------------------------
# プロンプト
# -------------------------------------

autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

# begin VCS
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
    zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
    zstyle ":vcs_info:git:*" stagedstr "<S>"
    zstyle ":vcs_info:git:*" unstagedstr "<U>"
    zstyle ":vcs_info:git:*" formats "(%b) %c%u"
    zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi

function vcs_prompt_info() {
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yellow]%}$vcs_info_msg_0_%f"
}
# end VCS

OK="^_^ "
NG="X_X "

PROMPT=""
PROMPT+="%(?.%F{green}$OK%f.%F{red}$NG%f) "
PROMPT+="%F{blue}%~%f"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="
"
PROMPT+="%% "

RPROMPT="[%*]"

# 補完で大文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完絞り込み設定
autoload -Uz compinit && compinit -u
zstyle ':completion:*' menu select interactive
setopt menu_complete

# 補完用のキーバインド設定
zmodload zsh/complist                                         # "bindkey -M menuselect"設定できるようにするためのモジュールロード
bindkey -v '^a' beginning-of-line                             # 行頭へ(menuselectでは補完候補の先頭へ)
bindkey -v '^b' backward-char                                 # 1文字左へ(menuselectでは補完候補1つ左へ)
bindkey -v '^e' end-of-line                                   # 行末へ(menuselectでは補完候補の最後尾へ)
bindkey -v '^f' forward-char                                  # 1文字右へ(menuselectでは補完候補1つ右へ)
bindkey -v '^h' backward-delete-char                          # 1文字削除(menuselectでは絞り込みの1文字削除)
bindkey -v '^i' expand-or-complete                            # 補完開始
bindkey -M menuselect '^g' .send-break                        # send-break2回分の効果
bindkey -M menuselect '^i' forward-char                       # 補完候補1つ右へ
bindkey -M menuselect '^j' .accept-line                       # accept-line2回分の効果
bindkey -M menuselect '^k' accept-and-infer-next-history      # 次の補完メニューを表示する
bindkey -M menuselect '^n' down-line-or-history               # 補完候補1つ下へ
bindkey -M menuselect '^p' up-line-or-history                 # 補完候補1つ上へ
bindkey -M menuselect '^r' history-incremental-search-forward # 補完候補内インクリメンタルサーチ

# -------------------------------------
# エイリアス
# -------------------------------------

# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# ls
alias ls="ls -F"
alias la="ls -a"
alias ll="ls -l"

# tree
alias tree="tree -NC" # N: 文字化け対策, C:色をつける

# その他
export ROOTSYS=~/root_v6.10.08
export PATH=${ROOTSYS}/bin:${PATH}
export DYLD_LIBRARY_PATH=${ROOTSYS}/lib:${DYLD_LIBRARY_PATH}
export PYTHONPATH=${ROOTSYS}/lib:${PYTHONPATH}
# GREP_OPTIONS="--color=always";export GREP_OPTIONS
alias e='emacsclient -t'
alias emacs='emacsclient -t'
alias kill-emacs="emacsclient -e '(kill-emacs)'"
alias mkdir='mkdir -p'
alias a='atom'
alias find='find . -iname'
alias py='python'
alias color='perl ~/.colors256.pl'
alias root='root -l'
alias global_ip='curl ipecho.net/plain; echo'
alias jst='sudo rm /etc/localtime; sudo ln -s /usr/share/zoneinfo/Japan /etc/localtime'
alias utc='sudo rm /etc/localtime; sudo ln -s /usr/share/zoneinfo/UTC /etc/localtime'
alias gst='git status'
alias gco='git checkout'
alias console='cd ~/working_space/air-closet/air-closet-console/'
alias socket='cd ~/working_space/air-closet/air-closet-console-socket/'
alias pickss='cd ~/working_space/air-closet/pickss/'
alias warehouse='cd ~/working_space/air-closet/air-closet-warehouse/'
alias migration='cd ~/working_space/air-closet/air-closet-migration/'
alias node-batch='cd ~/working_space/air-closet/air-closet-node-batch/'
alias universal='cd ~/working_space/air-closet/universal/'
alias ssr='cd ~/working_space/air-closet/air-closet-ssr/'
alias web='cd ~/working_space/air-closet/air-closet-web/'
alias api='cd ~/working_space/air-closet/air-closet-api'
alias simulator='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
alias styling-console='cd ~/working_space/air-closet/air-closet-styling-console/'
alias styling-api='cd ~/working_space/air-closet/air-closet-styling-api/'
alias draw.io=/Applications/draw.io.app/Contents/MacOS/draw.io
alias drun='docker run -it --net=host --runtime=nvidia --shm-size=128gb -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro -v /etc/shadow:/etc/shadow:ro -u $(id -u $USER):$(id -g $USER) -v $HOME:$HOME -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /usr/share/fonts:/usr/share/fonts -e MINIO_ACCESS_KEY=kazuki -e MINIO_SECRET_KEY=3U9igRAi51M1ogJ/jdN8r1z9PRzkdJsjKiyTxz86 -e MLFLOW_S3_ENDPOINT_URL=http://data.jupiter.ai-ms.com -e AWS_ACCESS_KEY_ID=kazuki -e AWS_SECRET_ACCESS_KEY=3U9igRAi51M1ogJ/jdN8r1z9PRzkdJsjKiyTxz86'

# function git(){hub "$@"} # for zsh
eval "$(hub alias -s)" # for bashみたいだけどこっちのがうまくいってる

HISTFILE=$HOME/.zsh-history         # 履歴の保存先
HISTSIZE=100000                     # メモリに展開する履歴の数
SAVEHIST=100000                     # 保存する履歴の数
setopt share_history                # 同一ホストで動いているZshで履歴を共有

export PGDATA=/usr/local/var/postgres
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export JAVA_HOME=`/usr/libexec/java_home -v 11`
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$(go env GOPATH)/bin
export PATH="/usr/local/opt/mongodb-community@3.6/bin:$PATH"
export PATH=~/.local/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# -------------------------------------
# キーバインド
# -------------------------------------

bindkey -e

function cdup() {
   echo
   cd ..
   zle reset-prompt
}
zle -N cdup
bindkey '^K' cdup

bindkey "^R" history-incremental-search-backward

# -------------------------------------
# その他
# -------------------------------------

# cdしたあとで、自動的に ls する
# function chpwd() { ls -1 }

# iTerm2のタブ名を変更する
function title {
    echo -ne "\033]0;"$*"\007"
}
export PATH="/usr/local/opt/llvm/bin:$PATH"

# C-sを検索で使えるようにする
stty stop undef

# iTerm2 window/tab color commands
#   Requires iTerm2 >= Build 1.0.0.20110804
#   http://code.google.com/p/iterm2/wiki/ProprietaryEscapeCodes
tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}
tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}
tab-text() {
    echo -ne "\033]0;$1\007"
}

# Change the color of the tab when using SSH
# reset the color after the connection closes
color-ssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-color 22 23 30 && tab-text $(pwd | rev | awk -F \/ '{print $1}'| rev)" INT EXIT
        if [[ "$*" =~ "production|ec2-.*compute-1" ]]; then
            tab-color 255 0 0
        else
            tab-color 0 255 0
        fi
    fi
    tab-text $*
    ssh $*
}
compdef _ssh color-ssh=ssh

alias ssh=color-ssh

# mcdコマンドの定義
mcd() {
    mkdir -p "$1"
    [ $? -eq 0 ] && cd "$1"
}

function chpwd() { echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print $1}'| rev)\007"}

# Dockerのコンテナ内にいる場合はプロンプトに表示
if [ -f /.dockerenv ]; then
    export PS1='\[(docker)\033[1;32m\]\u\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ '
fi
