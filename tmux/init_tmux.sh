#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if ! which tmux >/dev/null 2>&1; then
  echo 'could not find tmux'
  exit
fi

session_name="local"
projectList=("nvim" "lc" "config" "hugo")

if ! tmux has-session -t "${session_name}" >/dev/null 2>&1; then
  tmux new -s "${session_name}" -d
fi

for i in "${projectList[@]}"; do
  if ! tmux has-session -t "${session_name}:${i}" >/dev/null 2>&1; then
    tmux new-window -n "${i}" -t "${session_name}"
    tmux send -t "${session_name}:${i}" "j ${i}; clear" Enter
  fi
done
