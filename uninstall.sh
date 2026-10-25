#!/usr/bin/env bash
set -euo pipefail

repo=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
config_home=${XDG_CONFIG_HOME:-"$HOME/.config"}
claude_home=${CLAUDE_CONFIG_DIR:-"$HOME/.claude"}
copilot_home=${COPILOT_HOME:-"$HOME/.copilot"}
targets=("$@")
skills=(dgvoodoo2-wine steam-launch-wrapper)

if ((${#targets[@]} == 0)); then
  printf 'Usage: %s opencode [claude] [copilot]\n' "$0" >&2
  exit 2
fi

declare -A seen=()
for target in "${targets[@]}"; do
  [[ -z ${seen[$target]+x} ]] || continue
  seen[$target]=1
  case "$target" in
    opencode)
      agent_dest="$config_home/opencode/agents/deck-helper.md"
      agent_source="$repo/agents/opencode/deck-helper.md"
      skills_dest="$config_home/opencode/skills"
      ;;
    claude)
      agent_dest="$claude_home/agents/deck-helper.md"
      agent_source="$repo/agents/claude/deck-helper.md"
      skills_dest="$claude_home/skills"
      ;;
    copilot)
      agent_dest="$copilot_home/agents/deck-helper.agent.md"
      agent_source="$repo/agents/copilot/deck-helper.agent.md"
      skills_dest="$copilot_home/skills"
      ;;
    *)
      printf 'Unknown target: %s\n' "$target" >&2
      exit 2
      ;;
  esac

  if [[ -L $agent_dest && $(readlink -- "$agent_dest") == "$agent_source" ]]; then
    rm -- "$agent_dest"
    printf 'Removed kit link: %s\n' "$agent_dest"
  else
    printf 'Left untouched: %s\n' "$agent_dest"
  fi

  for skill in "${skills[@]}"; do
    dest="$skills_dest/$skill"
    src="$repo/skills/$skill"
    if [[ -L $dest && $(readlink -- "$dest") == "$src" ]]; then
      rm -- "$dest"
      printf 'Removed kit link: %s\n' "$dest"
    else
      printf 'Left untouched: %s\n' "$dest"
    fi
  done
done
