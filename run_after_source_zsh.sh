#!/bin/zsh

# Run codespace and Coder specific commands here
if [ -n "${CODESPACES:-}" ] || [ -n "${CODER_WORKSPACE_OWNER_NAME:-}" ]; then
  # install tmux plugins. install_plugins reads its config from a running tmux
  # server, and tmux.conf locates TPM through XDG_CONFIG_HOME.
  export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
  tmux new-session -d -s tpm-install
  ~/.config/tmux/plugins/tpm/bin/install_plugins
  tmux kill-session -t tpm-install
fi
