---
name: steam-launch-wrapper
description: Create a pre-launch script for Steam games that prepares configuration files and then executes Steam's existing %command%.
license: MIT
compatibility: Steam on Linux, including Steam Deck; shell and display detection details vary by session.
---

# Steam pre-launch wrapper

Use this when a game needs host-side preparation immediately before Steam launches it through its selected compatibility tool—for example, selecting a config file based on display mode.

## Pattern

Steam launch options can invoke a wrapper before `%command%`. Put any required environment variables (for example, `DXVK_*`) in the wrapper script by default, alongside the requested preparation, then pass control to Steam's original command:

```bash
#!/usr/bin/env bash
set -euo pipefail

# Put only the required, user-approved environment variables here.
# export DXVK_HUD=...

# Perform only the requested preparation here.
exec "$@"
```

Set Steam's launch options to the quoted wrapper path followed by `%command%`, for example:

```text
"/path/to/wrapper.sh" %command%
```

Keep `%command%` last so Steam's full launch command is passed as the wrapper's arguments. Preserve existing launch options when needed; do not move wrapper variables into Steam's launch-option string unless the user prefers that.

## Response format

Return only the two code blocks needed to configure Steam: first the complete `.sh` script, then the exact Steam launch-options line containing the quoted script path and `%command%`. Do not add explanatory prose or unrelated commands. Use the actual script path when known; otherwise use a clear path placeholder.

## Rules

- Steam owns Proton selection and launch setup. Do not manually invoke Proton or alter compatibility-data paths. Put required Wine/Proton environment variables in the wrapper by default; honor an explicit user preference to configure them elsewhere.
- Do not assume `xrandr` is available or reports the active display in every Steam Deck session. Check the actual desktop/game-mode environment and use a reliable detection method for that setup; ask if uncertain.
- Quote paths, validate the selected config exists, and avoid overwriting the live config until the source has been checked. Back it up when changing an existing setup.
- Keep the wrapper limited to the requested preparation and `exec "$@"`. Do not add unrelated cleanup, downloads, prefix edits, or privilege escalation.
- Make the script executable and test it with a harmless stand-in command before using it to launch the game.

## When this pattern is not appropriate

- If environment variables are required, set them in the wrapper by default so Steam only needs the wrapper path and `%command%`.
- If preparation must run inside the Wine prefix, or Steam does not pass the expected command arguments for the specific setup, explain the alternative and its tradeoffs before creating a more complex launcher.
