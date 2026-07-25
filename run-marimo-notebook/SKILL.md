---
name: start-marimo-notebook
description: Starts a Marimo notebook in tmux. Use when the user wants to open, edit, or launch a Marimo notebook in a new tmux window or detached tmux session without blocking the current terminal.
---

# Start Marimo notebook

Use this skill to launch a Marimo notebook through the bundled helper script.

## Usage

Run:

```bash
scripts/start-marimo-notebook-in-tmux <notebook.py>
```

You can pass custom `MARIMO_HOST` of `MARIMO_PORT` beforehand if the user instructs you to do so.

If no notebook path is provided, the script defaults to `notebook.py`. By default the script uses your Tailscale network interface and port 2718 (incrementing one-by-one until the next free one if ports are used already). If tailscale is not available, let the user know and ask whether they want to install or a different host should be used (suggest localhost).

## After running

Report both of the following to the user:

- The notebook URL printed by the script.
- The tmux target printed by the script.
