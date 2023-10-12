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

function _zsh_install() {
  NAME="$(basename "$2")"
  TARGET_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/$1"

  if [[ -e "${TARGET_DIR}/${NAME}" ]]; then
    echo "${TARGET_DIR}/${NAME} already existed, ignored..."
  else
    echo "installing ${NAME}..."
    git clone --depth=1 "$2" "${TARGET_DIR}/${NAME}"
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

_zsh_install "plugins" "https://github.com/zsh-users/zsh-autosuggestions"
_zsh_install "plugins" "https://github.com/z-shell/F-Sy-H"
_zsh_install "plugins" "https://github.com/hlissner/zsh-autopair"
_zsh_install "themes" "https://github.com/romkatv/powerlevel10k"

# the zsh-installer already rename an existing .zshrc file to .zshrc.pre-oh-my-zsh.
_zsh_backup "${HOME}/.zshrc"
_zsh_backup "${HOME}/.p10k.zsh"

/bin/cp -i "${script_dir}/zshrc" "${HOME}/.zshrc"
/bin/cp -i "${script_dir}/p10k.zsh" "${HOME}/.p10k.zsh"

echo "zshrc/install.sh finish..."
