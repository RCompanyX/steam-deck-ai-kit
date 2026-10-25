---
name: steam-launch-wrapper
description: Create a pre-launch script for Steam games that prepares configuration files and then executes Steam's existing %command%.
license: MIT
compatibility: Steam on Linux, including Steam Deck; shell and display detection details vary by session.
---

# Steam pre-launch wrapper

Use this when a game needs host-side preparation immediately before Steam launches it through its selected compatibility tool—for example, selecting a config file based on display mode.

## Pattern

Steam launch options can invoke a wrapper before `%command%`. The wrapper performs a small, reversible preparation step and then passes control to Steam's original command:

```bash
#!/usr/bin/env bash
set -e

# Perform only the requested preparation here.
exec "$@"
```

Set Steam's launch options to the quoted wrapper path followed by `%command%`, for example:

```text
"/path/to/wrapper.sh" %command%
```

Keep `%command%` last so Steam's full launch command is passed as the wrapper's arguments. Preserve any existing options and explain how they combine before changing them.

## Rules

- Steam owns Proton selection and launch setup. Do not manually invoke Proton, alter compatibility-data paths, or set Wine variables in this wrapper unless the user explicitly requests a different design.
- Do not assume `xrandr` is available or reports the active display in every Steam Deck session. Check the actual desktop/game-mode environment and use a reliable detection method for that setup; ask if uncertain.
- Quote paths, validate the selected config exists, and avoid overwriting the live config until the source has been checked. Back it up when changing an existing setup.
- Keep the wrapper limited to the requested preparation and `exec "$@"`. Do not add unrelated cleanup, downloads, prefix edits, or privilege escalation.
- Make the script executable and test it with a harmless stand-in command before using it to launch the game.

## When this pattern is not appropriate

- If the requirement is only to set a Wine environment variable, first check whether Steam launch options can express it directly.
- If preparation must run inside the Wine prefix, or Steam does not pass the expected command arguments for the specific setup, explain the alternative and its tradeoffs before creating a more complex launcher.
