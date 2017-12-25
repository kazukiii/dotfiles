#!/bin/bash
set -u
DOT_DIRECTORY="${HOME}/dotfiles"
echo "link home directory dotfiles"
cd ${DOT_DIRECTORY}
for f in .??*
do
#無視したいファイルやディレクトリ
    [ "$f" = ".git" ] && continue
    ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done
echo "linked dotfiles complete!"#!/bin/bash
