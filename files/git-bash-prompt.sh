#!/usr/bin/env bash

if [ ! -d /opt/bash-git-prompt ]; then
    echo "install an informative bash-git-prompt..."
    git clone https://github.com/magicmonty/bash-git-prompt.git /opt/bash-git-prompt --depth=1
fi
