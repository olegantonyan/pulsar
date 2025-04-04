#!/usr/bin/env bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

set -xEeuo pipefail

if nvm --version; then
  exit 0
fi

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

# node-gyp (during yarn build:apm) fails with Python versions below 3.9
if python3 --version; then
  minor_version=$(python3 -c 'import sys; print(sys.version_info.minor)')
  minor_version=$(($minor_version+0))
  if (( $minor_version > 9)); then
    exit 0
  fi
fi
curl -L https://www.python.org/ftp/python/3.13.2/Python-3.13.2.tar.xz | tar -Jx -C .
cd Python-3.13.2
./configure --disable-test-modules
make -j$(nproc)
make install
cd ..
rm -rf Python-3.13.2
pip3 install setuptools
