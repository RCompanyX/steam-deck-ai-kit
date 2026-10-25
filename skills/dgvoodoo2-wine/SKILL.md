---
name: dgvoodoo2-wine
description: Configure dgVoodoo2 for a classic game running through Wine or Proton, including DLL placement, overrides, and troubleshooting.
license: MIT
compatibility: Steam Deck, Linux, Wine, or Proton; exact steps depend on the game and wrapper version.
---

# Configure dgVoodoo2 with Wine or Proton

Use this skill when the user asks to configure dgVoodoo2 for a game under Wine or Proton. First identify the exact game/version, graphics API, architecture, launcher, Proton/Wine version, and game directory. Before proposing game-specific settings, consult that game's [PCGamingWiki](https://www.pcgamingwiki.com/) page. Check its wrapper/DLL, patches, launch options, configuration notes, known issues, and the date/source of relevant reports. If it has no useful entry, say so and check other reliable sources; do not invent game-specific steps or treat an old community report as current fact.

## Known-good Steam Deck baseline

For the Steam Deck setup this kit is based on, use **dgVoodoo2 2.79.3 with Valve Proton 9.0.x** as the known-good starting point. The original Deck notes specifically report this pairing as tested; they advise against GE-Proton 11 for this configuration because its newer WoW64 path was associated with crashes.

Treat this as a tested baseline, not a universal compatibility guarantee. Start with this exact pair when reproducing that setup; do not silently upgrade dgVoodoo2 or substitute a Proton/GE-Proton major version. If a game requires another combination, check current reports, change one component at a time, and keep a rollback path.

Reports of newer dgVoodoo2 releases failing under Wine/Proton are game- and build-dependent. PCGamingWiki's Wine configuration notes recommend trying 2.79.3 when problems occur and currently link a community-maintained Wine/Proton-compatible package. The upstream 2.79.3 release is available from the [official dgVoodoo2 GitHub release](https://github.com/dege-diosg/dgVoodoo2/releases/tag/v2.79.3). Check these sources again before publishing version-specific advice:

- [PCGamingWiki: dgVoodoo 2 — Linux (Wine) configuration](https://www.pcgamingwiki.com/wiki/DgVoodoo_2#Linux_(Wine)_configuration)
- [Official dgVoodoo2 v2.79.3 release](https://github.com/dege-diosg/dgVoodoo2/releases/tag/v2.79.3)

## Safe workflow

1. Use PCGamingWiki and, where possible, the game's own documentation to determine whether it uses DirectDraw, Direct3D 1–7, Direct3D 8, or Direct3D 9. Do not install every wrapper DLL; use only the matching components and architecture. Cite the game page and distinguish its recommendation from the known-good baseline below.
2. Obtain the baseline release from its official source, or use a community-maintained Wine/Proton build only after checking its provenance and changes. Do not commit or redistribute dgVoodoo2 binaries in this kit. Check the archive and requested files before extraction.
3. Identify and verify the actual game executable directory. Back up existing DLLs and configuration before changing them.
4. Place the matching wrapper DLL beside the game executable, following dgVoodoo2's documentation. On case-sensitive filesystems, check the exact DLL filename the game requests; if needed, use a lowercase symlink or filename, without overwriting an existing file.
5. Set a Proton/Wine DLL override only when required. Explain where it belongs for that launcher, preserve existing launch options, and do not replace Steam's `%command%` handling.
6. Start from the supplied configuration file and change only the required settings. Keep an untouched backup and avoid copying a configuration from another game without checking its renderer and display mode.
7. Test one change at a time. If the game fails, restore the backup and report the exact error, game, wrapper version, and Proton/Wine version.

## Important cautions

- Compatibility varies by dgVoodoo2 version, Wine/Proton build, graphics API, game, and GPU. Preserve 2.79.3 + Proton 9.0.x as this kit's known-good Deck baseline, but do not describe it as universally compatible or later versions as universally broken.
- Wine prefixes and Steam compatibility data are easy to misidentify. Do not edit a registry, `system.reg`, drive mapping, or prefix unless its ownership is confirmed and the user approves a backup.
- A folder exposed as a CD-ROM may need both a drive mapping and a Wine drive type. Verify the game's expected drive letter and test with the selected Proton/Wine build; do not assume a particular letter is free or stable.
- Avoid hand-editing generated prefix files while Wine processes are running.
