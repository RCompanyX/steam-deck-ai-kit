#!/usr/bin/env bash
set -euo pipefail

repo=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT
export HOME="$tmp/home"
export XDG_CONFIG_HOME="$HOME/config"
export CLAUDE_CONFIG_DIR="$HOME/claude"
export COPILOT_HOME="$HOME/copilot"
mkdir -p "$HOME"

bash "$repo/install.sh" opencode claude copilot
for path in \
  "$XDG_CONFIG_HOME/opencode/agents/deck-helper.md" \
  "$XDG_CONFIG_HOME/opencode/skills/dgvoodoo2-wine" \
  "$XDG_CONFIG_HOME/opencode/skills/steam-launch-wrapper" \
  "$CLAUDE_CONFIG_DIR/agents/deck-helper.md" \
  "$CLAUDE_CONFIG_DIR/skills/dgvoodoo2-wine" \
  "$CLAUDE_CONFIG_DIR/skills/steam-launch-wrapper" \
  "$COPILOT_HOME/agents/deck-helper.agent.md" \
  "$COPILOT_HOME/skills/dgvoodoo2-wine" \
  "$COPILOT_HOME/skills/steam-launch-wrapper"; do
  [[ -L $path ]]
done

# Reinstall must be harmless.
bash "$repo/install.sh" opencode claude copilot >/dev/null

# Remove installed links before simulating a pre-existing personal file.
bash "$repo/uninstall.sh" opencode claude copilot >/dev/null

# A conflict is refused before any link for that target is created.
mkdir -p "$XDG_CONFIG_HOME/opencode/agents"
printf 'personal file\n' > "$XDG_CONFIG_HOME/opencode/agents/deck-helper.md"
if bash "$repo/install.sh" opencode >"$tmp/conflict.out" 2>&1; then
  printf 'Expected installer conflict to fail\n' >&2
  exit 1
fi
[[ ! -e "$XDG_CONFIG_HOME/opencode/skills/dgvoodoo2-wine" ]]

# Uninstall only removes links whose exact targets belong to this checkout.
rm -- "$XDG_CONFIG_HOME/opencode/agents/deck-helper.md"
bash "$repo/install.sh" opencode claude copilot >/dev/null
bash "$repo/uninstall.sh" opencode claude copilot >/dev/null
[[ ! -e "$XDG_CONFIG_HOME/opencode/agents/deck-helper.md" ]]
[[ ! -e "$XDG_CONFIG_HOME/opencode/skills/dgvoodoo2-wine" ]]
[[ ! -e "$CLAUDE_CONFIG_DIR/agents/deck-helper.md" ]]
[[ ! -e "$COPILOT_HOME/agents/deck-helper.agent.md" ]]

printf 'Installer checks passed.\n'
