#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

if [[ -e "${HOME}/.tmux/plugins/tpm" ]]; then
  echo "${HOME}/.tmux/plugins/tpm already existed, ignored..."
else
  git clone --depth=1 https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
fi

/bin/cp -i "${script_dir}/tmux.conf" "${HOME}/.tmux.conf"

echo "tmux/install.sh finish..."
