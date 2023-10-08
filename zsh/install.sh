#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

if [[ -e "${HOME}/.oh-my-zsh" ]]; then
  echo "${HOME}/.oh-my-zsh already existed, ignored..."
else
  echo "installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

function _zsh_install_plugin() {
  PLUGIN_NAME="$(basename "$1")"
  CUSTOM_PLUGIN="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

  if [[ -e "${CUSTOM_PLUGIN}/${PLUGIN_NAME}" ]]; then
    echo "${CUSTOM_PLUGIN}/${PLUGIN_NAME} already existed, ignored..."
  else
    echo "installing ${PLUGIN_NAME}..."
    git clone "$1" "${CUSTOM_PLUGIN}/${PLUGIN_NAME}"
  fi
}

function _zsh_backup() {
  target="$1"
  name=$(basename "$1")
  backup="/tmp/$(date +%Y%m%d_%H%M%S)_${name}.bak"

  if [[ ! -e "${target}" ]]; then
    return 0
  fi

  echo "backup ${target} to ${backup}"
  /bin/cp -i "${target}" "${backup}"
}

_zsh_install_plugin "https://github.com/zsh-users/zsh-autosuggestions"
_zsh_install_plugin "https://github.com/z-shell/F-Sy-H.git"
_zsh_install_plugin "https://github.com/hlissner/zsh-autopair.git"

_zsh_backup "${HOME}/.zshrc"
_zsh_backup "${HOME}/.p10k.zsh"

/bin/cp -i "${script_dir}/zshrc" "${HOME}/.zshrc"
/bin/cp -i "${script_dir}/p10k.zsh" "${HOME}/.p10k.zsh"

echo "zshrc/install.sh finish..."
