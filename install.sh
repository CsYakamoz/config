#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

scriptDir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

if ! command -v git &>/dev/null || ! command -v zsh &>/dev/null; then
  echo "required git and zsh"
  exit 1
fi

if ! command -v curl &>/dev/null && ! command -v wget &>/dev/null; then
  echo "required curl or wget"
  exit 1
fi

gitReqVer="2.4.11"
gitVer=$(git --version | grep -oE "[0-9]+\.[0-9]+\.[0-9]+")
if [ "$(printf '%s\n' "${gitReqVer}" "${gitVer}" | sort -V | head -n1)" != "${gitReqVer}" ]; then
  echo "git version is at least ${gitReqVer}"
  exit 1
fi

zshReqVer="5.0"
zshVer=$(zsh --version | grep -oE "[0-9]+\.[0-9]+" | head -n1)
if [ "$(printf '%s\n' "${zshReqVer}" "${zshVer}" | sort -V | head -n1)" != "${zshReqVer}" ]; then
  echo "git version is at least ${zshReqVer}"
  exit 1
fi

if ! command -v fzf &>/dev/null; then
  echo 'command not found: fzf'
  read -r -p 'install fzf by using git?[Y/n]' installFzf
  installFzf=${installFzf:-Y}

  if [[ "${installFzf}" == "Y" ]]; then
    if [[ ! -e "${HOME}/.fzf" ]]; then
      git clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
    fi

    "${HOME}/.fzf/install"
  else
    echo 'fzf installation: https://github.com/junegunn/fzf#installation'
    exit 1
  fi
fi

echo "git: ✓
zsh: ✓
curl or wget: ✓
fzf: ✓"

"${scriptDir}/zsh/install.sh"
"${scriptDir}/tmux/install.sh"
