#!/usr/bin/env bash

set -xEeuo pipefail

dnf install -y --allowerasing epel-release
crb enable
dnf install -y --allowerasing libxkbfile-devel

$(dirname $0)/nvm.sh
