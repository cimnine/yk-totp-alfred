#!/bin/bash

export PATH="$PATH:/usr/local/bin"

if ! hash jq 2>/dev/null; then
  echo "Please install 'jq'."
  exit 1
fi

# if YKTOTP is set, then use this
if [ "${YKTOTP}x" != "x" ] && hash "$YKTOTP" 2>/dev/null; then
  return
fi

# if yk-totp is installed globally, then use this
if hash yk-totp 2>/dev/null; then
  export YKTOTP="yk-totp"
  return
fi

# if yk-totp is installed in venv, then use this
if [ -x .venv/bin/yk-totp ]; then
  export YKTOTP=".venv/bin/yk-totp"
fi

install_instructions() {
  echo "Installation of 'yk-totp' in venv '$PWD/.venv' failed."
  echo "Run the following in a Terminal:"
  echo "cd $PWD"
  echo "source .venv/bin/active"
  echo "python3 -m pip install pip setuptools wheel"
  echo "pip3 install -U yk-totp"
}

# if .venv exists, then the installation was probably not successful
if [ -d .venv ]; then
  install_instructions
  exit 1
fi

# ensure python3 is available
if ! hash python3 2>/dev/null; then
  echo "Please make sure that 'python3' is installed."
  exit 1
fi

# make a venv
python3 -m venv .venv 1>&2

# shellcheck disable=SC1091
source .venv/bin/activate

# update the build tools
python3 -m pip install -U pip wheel setuptools 1>&2

# install yk-totp
if ! python3 -m pip install -U yk-totp 1>&2; then
  install_instructions
  exit 1
fi

if [ -x .venv/bin/yk-totp ]; then
  export YKTOTP=".venv/bin/yk-totp"
  return
fi

install_instructions
exit 1
