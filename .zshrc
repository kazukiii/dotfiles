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
# function git(){hub "$@"} # for zsh
eval "$(hub alias -s)" # for bashみたいだけどこっちのがうまくいってる

HISTFILE=$HOME/.zsh-history         # 履歴の保存先
HISTSIZE=100000                     # メモリに展開する履歴の数
SAVEHIST=100000                     # 保存する履歴の数
setopt share_history                # 同一ホストで動いているZshで履歴を共有

export PGDATA=/usr/local/var/postgres

# added by Anaconda3 4.4.0 installer
export PATH="/Users/kazuki/anaconda/bin:$PATH"

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
