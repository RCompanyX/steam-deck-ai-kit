# Steam Deck AI Kit

Reusable Steam Deck, classic-game, Proton, and Wine guidance for OpenCode, Claude Code, and GitHub Copilot CLI.

**Scope:** This kit is specifically intended for the Valve Steam Deck running SteamOS. Other Linux PCs and handhelds are out of scope and are not supported targets. Device models, SteamOS versions, games, and Proton/Wine combinations can still behave differently.

Agent and skill content is in English. `README.es.md` contains Spanish installation instructions.

## What is included

- `deck-helper`: platform-specific agent profiles with shared safety guidance.
- `dgvoodoo2-wine` and `steam-launch-wrapper`: portable Agent Skills.
- Small install and uninstall scripts. The installer only creates symlinks to this checkout; it does not install software, change tool settings, or modify SteamOS.

## Requirements

- A Steam Deck running SteamOS, with Bash.
- The target agent tool already installed and configured.
- Git to clone or update this repository.

The kit does not include game files, wrapper binaries, API credentials, models, Proton, or Wine.

## Install

Clone to a stable location, then select one or more tools:

```bash
git clone https://github.com/RCompanyX/steam-deck-ai-kit.git ~/.local/share/steam-deck-ai-kit
cd ~/.local/share/steam-deck-ai-kit
bash install.sh opencode
bash install.sh claude
bash install.sh copilot
# Or install all three:
bash install.sh opencode claude copilot
```

The installer checks all requested destinations before creating links. Existing files or links are never overwritten. If a destination conflicts, move or back it up yourself and rerun the installer.

## Update

Review the changes, then fast-forward the checkout:

```bash
cd ~/.local/share/steam-deck-ai-kit
git pull --ff-only
```

Because installed files link to the checkout, changes take effect from that checkout. Review updates before relying on them.

## Uninstall

Run the script for the tools you installed. It removes only symlinks that still point to this checkout:

```bash
bash uninstall.sh opencode claude copilot
```

The repository checkout and any pre-existing files are left untouched.

## Backups and recovery

Back up existing agent/skill files before installing over a setup you want to preserve. This kit refuses conflicts rather than replacing them. To restore a backup, first uninstall the kit links, then restore the saved files to their original locations.

## Security and limitations

Review scripts, agent prompts, and skill instructions before installing. Agent instructions are not a substitute for a tool's permission controls. OpenCode's profile asks before shell and edit actions; Claude Code and Copilot CLI still use their own permission settings. Never approve commands solely because this kit suggested them.

Compatibility guidance is not universal: SteamOS, device models, games, launchers, graphics APIs, Proton/Wine versions, and tool availability differ. Verify the actual device and game before applying instructions. No skill should edit a compatibility prefix or install a wrapper binary without explaining the change and protecting existing files.

## Disclaimer

This community project is not affiliated with or endorsed by Valve, OpenCode, Anthropic, GitHub, or the dgVoodoo2 authors. The kit and its instructions are provided “as is,” without warranties. Use them at your own risk: review commands and sources, and back up saves, game files, and compatibility prefixes before making changes. Compatibility and results are not guaranteed. To the maximum extent permitted by law, the contributors are not liable for damage, data loss, or other issues resulting from use of this kit.

## License

MIT. Third-party tools and binaries are not included and retain their own licenses.
