#!/usr/bin/env bash

set -xEeuo pipefail

if nvm --version; then
    exit 0
fi

touch ~/.profile

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

source ~/.profile

nvm --version
