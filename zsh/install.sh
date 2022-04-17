#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

scriptDir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

if [[ -e "${HOME}/.oh-my-zsh" ]]; then
  echo "${HOME}/.oh-my-zsh already existed, ignored..."
else
  echo "installing oh-my-zsh..."
  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ -e "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
  echo "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions already existed, ignored..."
else
  echo "installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi

if [[ -e "${HOME}/.oh-my-zsh/custom/plugins/fast-syntax-highlighting" ]]; then
  echo "${HOME}/.oh-my-zsh/custom/plugins/fast-syntax-highlighting already existed, ignored..."
else
  echo "installing fast-syntax-highlighting..."
  git clone https://github.com/zdharma/fast-syntax-highlighting.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting"
fi

/bin/cp -i "${scriptDir}/zshrc" "${HOME}/.zshrc"

echo "zshrc/install.sh finish..."
