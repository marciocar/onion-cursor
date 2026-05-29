#!/usr/bin/env bash

set -euo pipefail

payload="$(cat)"
command="$(printf '%s' "$payload" | python3 -c 'import json,sys; print((json.load(sys.stdin).get("command","") or "").strip())' 2>/dev/null || true)"

if [[ -z "${command}" ]]; then
  printf '{"permission":"allow"}\n'
  exit 0
fi

is_git_add_with_env=0
is_git_commit_with_staged_env=0

if [[ "${command}" =~ ^git[[:space:]]+add[[:space:]] ]]; then
  if [[ "${command}" =~ (^|[[:space:]])\.env($|[[:space:]]) ]] || [[ "${command}" =~ (^|[[:space:]])\.env\.[^[:space:]]+ ]]; then
    if [[ ! "${command}" =~ (^|[[:space:]])\.env\.example($|[[:space:]]) ]]; then
      is_git_add_with_env=1
    fi
  fi
fi

if [[ "${command}" =~ ^git[[:space:]]+commit\b ]]; then
  if git diff --cached --name-only | rg -q '(^|/)\.env($|\.)'; then
    if ! git diff --cached --name-only | rg -q '(^|/)\.env\.example$'; then
      is_git_commit_with_staged_env=1
    fi
  fi
fi

if [[ "${is_git_add_with_env}" -eq 1 || "${is_git_commit_with_staged_env}" -eq 1 ]]; then
  printf '{"permission":"deny","user_message":"Bloqueado: commit/add de .env detectado. Use .env.example para versionar placeholders.","agent_message":"Hook protect-env bloqueou operacao com arquivo .env sensivel."}\n'
  exit 2
fi

printf '{"permission":"allow"}\n'
exit 0
