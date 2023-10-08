#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# $1: the command to check
function _is_command_existed() {
  if [[ -n "$1" ]] && command -v "$1" &>/dev/null; then
    return 0
  fi

  return 1
}

function _output_command_result() {
  if _is_command_existed "$1"; then
    echo "$1: ✓"
  else
    echo "$1: ✗"
  fi
}

# $1: required version
# $2: current version
function _is_version_ok() {
  if [[ "$(printf '%s\n' "${1}" "${2}" | sort -V | head -n1)" == "${1}" ]]; then
    return 0
  fi

  return 1
}

if ! _is_command_existed "git" || ! _is_command_existed "zsh" || ! _is_command_existed "curl"; then
  echo "required git, zsh, curl"
  exit 1
fi

git_req_ver="2.4.11"
git_ver=$(git --version | grep -oE "[0-9]+\.[0-9]+\.[0-9]+")
if ! _is_version_ok "${git_req_ver}" "${git_ver}"; then
  echo "git version is at least ${git_req_ver}"
  exit 1
fi

zsh_req_ver="5.0"
zsh_ver=$(zsh --version | grep -oE "[0-9]+\.[0-9]+" | head -n1)
if ! _is_version_ok "${zsh_req_ver}" "${zsh_ver}"; then
  echo "zsh version is at least ${zsh_req_ver}"
  exit 1
fi

if ! _is_command_existed fzf; then
  echo 'command not found: fzf'
  read -r -p 'install fzf by using git?[Y/n]' install_fzf
  install_fzf=${install_fzf:-Y}

  if [[ "${install_fzf}" == "Y" ]]; then
    if [[ ! -e "${HOME}/.fzf" ]]; then
      git clone --depth=1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
    fi

    "${HOME}/.fzf/install"
  else
    echo 'fzf installation: https://github.com/junegunn/fzf#installation'
    exit 1
  fi
fi

echo ""
_output_command_result "git"
_output_command_result "zsh"
_output_command_result "curl"
_output_command_result "fzf"
echo ""

"${script_dir}/zsh/install.sh"
"${script_dir}/tmux/install.sh"
