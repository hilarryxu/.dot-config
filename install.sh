#!/bin/bash

__gather_os_info() {
    OS_NAME=$(uname -s 2>/dev/null)
    OS_NAME_L=$( echo "$OS_NAME" | tr '[:upper:]' '[:lower:]' )
    OS_VERSION=$(uname -r)
    # shellcheck disable=SC2034
    OS_VERSION_L=$( echo "$OS_VERSION" | tr '[:upper:]' '[:lower:]' )
}
__gather_os_info

if [ ! -d $HOME/Downloads ]; then
  mkdir ~/Downloads
fi

if [ ! "$(command -v git)" != "" ]; then
  case ${OS_NAME_L} in
    linux )
      sudo apt-get install git
      ;;
   esac
fi

if [ ! "$(command -v pip)" != "" ]; then
  echo "pip not installed"
  if [ ! -f $HOME/Downloads/get-pip.py ]; then
    case ${OS_NAME_L} in
      linux )
        cd ~/Downloads && wget https://bootstrap.pypa.io/get-pip.py
        ;;
    esac
  fi
  case ${OS_NAME_L} in
    linux )
      sudo python $HOME/Downloads/get-pip.py
    ;;
  esac
fi

python -c 'import dotfiles' >/dev/null 2>&1
if [[ $? != 0 ]]; then
  pip install --user dotfiles
fi

if [ ! -d $HOME/.dot-config ]; then
  git clone --recursive https://github.com/tony/.dot-config ~/.dot-config
fi
ln -sf ~/.dot-config/.dotfilesrc ~/.dotfilesrc

~/.local/bin/dotfiles --sync
