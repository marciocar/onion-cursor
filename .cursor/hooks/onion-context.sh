#!/usr/bin/env bash

set -euo pipefail

provider="$(
  if [[ -f ".env" ]]; then
    rg '^TASK_MANAGER_PROVIDER=' ".env" | python3 -c 'import sys; line=sys.stdin.read().strip(); print(line.split("=",1)[1] if "=" in line else "")' 2>/dev/null || true
  fi
)"

if [[ -z "${provider}" ]]; then
  provider="none"
fi

branch="$(git branch --show-current 2>/dev/null || true)"
if [[ -z "${branch}" ]]; then
  branch="detached"
fi

sessions_list="$(
  if [[ -d ".cursor/sessions" ]]; then
    ls -1 ".cursor/sessions" 2>/dev/null | rg '\S' || true
  fi
)"

if [[ -z "${sessions_list}" ]]; then
  sessions_list="nenhuma"
else
  sessions_list="$(printf '%s' "${sessions_list}" | tr '\n' ',' | sed 's/,$//')"
fi

printf '{"additional_context":"Onion context: provider=%s | branch=%s | sessions=%s"}\n' "${provider}" "${branch}" "${sessions_list}"
exit 0
