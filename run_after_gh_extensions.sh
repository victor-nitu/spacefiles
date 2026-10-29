#!/usr/bin/env bash
# Install gh CLI extensions. `gh extension install` errors when the extension is
# already present, hence the check. Always exits 0 so it cannot fail the apply.

command -v gh >/dev/null 2>&1 || exit 0

for ext in dlvhdr/gh-dash; do
  gh extension list 2>/dev/null | grep -q "$ext" ||
    gh extension install "$ext" ||
    echo "warning: could not install gh extension $ext" >&2
done

exit 0
