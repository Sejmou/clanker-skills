#!/usr/bin/env bash
set -euo pipefail

notebook="${1:-notebook.py}"
notebook="$(realpath -m "$notebook")"
dir="$(dirname "$notebook")"
stem="$(basename "$notebook" .py)"
name="marimo-${stem//[^[:alnum:]-]/-}"
host="${MARIMO_HOST:-$(tailscale ip -4)}"
port="${MARIMO_PORT:-2718}"

while ss -ltn "sport = :$port" | grep -q LISTEN; do
  port=$((port + 1))
done

cmd="exec uv run marimo edit $(printf '%q' "$notebook") --headless --watch --no-token --host $(printf '%q' "$host") --port $(printf '%q' "$port")"

if [[ -n "${TMUX:-}" ]]; then
  target="$(tmux new-window -P -F '#S:#I' -n "$name" -c "$dir" "$cmd")"
else
  tmux new-session -d -s "$name" -c "$dir" "$cmd"
  target="${name}:0"
fi

printf 'Marimo target: %s\n' "$target"
printf 'URL: http://%s:%s\n' "$host" "$port"
