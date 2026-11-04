#!/bin/bash

preinstall_neovim_plugins() {
  # Install plugins and parsers in headless mode
  nvim --headless "+Lazy! sync" -c "TSUpdate" +qa
}

run_on_remote_only() {
  if [ -n "${CODESPACES:-}" ] || [ -n "${CODER_WORKSPACE_OWNER_NAME:-}" ]; then
    preinstall_neovim_plugins
  fi
}

run_on_remote_only
