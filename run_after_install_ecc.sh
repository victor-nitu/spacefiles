#!/usr/bin/env bash
# Install Everything Claude Code (ECC): the Claude Code plugin, plus its common
# rules copied into ~/.claude/rules/ecc so they load in every repo.
#
# A run_after_ hook rather than run_once_ because claude may not be on PATH yet
# on the first apply; every step checks before acting, so later runs are cheap.
# Always exits 0 -- setup.sh runs `chezmoi init --apply` under `set -e`.

set -uo pipefail

ECC_REPO=https://github.com/affaan-m/everything-claude-code
ECC_DIR="$HOME/.ecc"

if ! command -v claude >/dev/null 2>&1; then
  echo "ecc: claude not on PATH, skipping" >&2
  exit 0
fi

claude plugin marketplace list 2>/dev/null | grep -q 'everything-claude-code' ||
  claude plugin marketplace add "$ECC_REPO" ||
  echo "ecc: could not add marketplace" >&2

claude plugin list 2>/dev/null | grep -q 'everything-claude-code@everything-claude-code' ||
  claude plugin install everything-claude-code@everything-claude-code ||
  echo "ecc: could not install plugin" >&2

if [ ! -d "$ECC_DIR" ]; then
  git clone "$ECC_REPO.git" "$ECC_DIR" &&
    (cd "$ECC_DIR" && npm install) ||
    echo "ecc: could not clone or npm install $ECC_DIR" >&2
fi

if [ -d "$ECC_DIR/rules/common" ]; then
  mkdir -p "$HOME/.claude/rules/ecc"
  cp -R "$ECC_DIR/rules/common" "$HOME/.claude/rules/ecc/" ||
    echo "ecc: could not copy rules" >&2
fi

exit 0
