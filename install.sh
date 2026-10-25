#!/usr/bin/env bash
set -euo pipefail

repo=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
config_home=${XDG_CONFIG_HOME:-"$HOME/.config"}
claude_home=${CLAUDE_CONFIG_DIR:-"$HOME/.claude"}
copilot_home=${COPILOT_HOME:-"$HOME/.copilot"}
skills=(dgvoodoo2-wine steam-launch-wrapper)
targets=("$@")

if ((${#targets[@]} == 0)); then
  printf 'Usage: %s opencode [claude] [copilot]\n' "$0" >&2
  exit 2
fi

declare -A seen=()
links=()
sources=()
for target in "${targets[@]}"; do
  [[ -z ${seen[$target]+x} ]] || continue
  seen[$target]=1
  case "$target" in
    opencode)
      agent_source="$repo/agents/opencode/deck-helper.md"
      agent_dest="$config_home/opencode/agents/deck-helper.md"
      skills_dest="$config_home/opencode/skills"
      ;;
    claude)
      agent_source="$repo/agents/claude/deck-helper.md"
      agent_dest="$claude_home/agents/deck-helper.md"
      skills_dest="$claude_home/skills"
      ;;
    copilot)
      agent_source="$repo/agents/copilot/deck-helper.agent.md"
      agent_dest="$copilot_home/agents/deck-helper.agent.md"
      skills_dest="$copilot_home/skills"
      ;;
    *)
      printf 'Unknown target: %s\n' "$target" >&2
      exit 2
      ;;
  esac
  [[ -f $agent_source ]] || { printf 'Missing kit file: %s\n' "$agent_source" >&2; exit 1; }
  links+=("$agent_dest")
  sources+=("$agent_source")
  for skill in "${skills[@]}"; do
    [[ -f "$repo/skills/$skill/SKILL.md" ]] || { printf 'Missing skill: %s\n' "$skill" >&2; exit 1; }
    links+=("$skills_dest/$skill")
    sources+=("$repo/skills/$skill")
  done
done

# Preflight all paths so a conflict cannot leave a partially installed kit.
for i in "${!links[@]}"; do
  dest=${links[$i]}
  src=${sources[$i]}
  if [[ -L $dest && $(readlink -- "$dest") == "$src" ]]; then
    continue
  fi
  if [[ -e $dest || -L $dest ]]; then
    printf 'Refusing to overwrite existing path: %s\n' "$dest" >&2
    exit 1
  fi
done

for i in "${!links[@]}"; do
  dest=${links[$i]}
  src=${sources[$i]}
  if [[ -L $dest && $(readlink -- "$dest") == "$src" ]]; then
    printf 'Already installed: %s\n' "$dest"
    continue
  fi
  mkdir -p -- "$(dirname -- "$dest")"
  ln -s -- "$src" "$dest"
  printf 'Installed: %s\n' "$dest"
done
