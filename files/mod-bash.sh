#!/usr/bin/env bash

# in order to be executed on every start of a bash,
# this file should be placed here: /etc/bash_completion.d/mod-bash.sh

echo 'Welcome to the Workshop VM'

# global git configs
git config --global core.autocrlf input
git config --global core.longpaths true
git config --global push.default simple

# configure bash-git-prompt
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_THEME=TruncatedPwd_WindowTitle_Ubuntu
source /opt/bash-git-prompt/gitprompt.sh

# define some aliases
alias gl='git log --oneline --all --graph --decorate'
alias gg='gl -n 10 && git status'
alias ctop='docker run --name ctop --rm -it -v /var/run/docker.sock:/var/run/docker.sock wrfly/ctop'
alias code='/usr/bin/code --disable-gpu -n'
alias dc='/usr/local/bin/docker-compose'
