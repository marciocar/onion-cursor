#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$ROOT_DIR"

echo "🔎 Executando varredura de segredos..."

PATTERN='(ghp_[A-Za-z0-9]{36}|github_pat_[A-Za-z0-9_]{82}|AKIA[0-9A-Z]{16}|ASIA[0-9A-Z]{16}|AIza[0-9A-Za-z\-_]{35}|sk_live_[A-Za-z0-9]{16,}|-----BEGIN (RSA|EC|OPENSSH|DSA|PGP) PRIVATE KEY-----|(^|[^A-Za-z0-9_])(password|token|secret|api[_-]?key)\s*[:=]\s*["'"'"']?[A-Za-z0-9_\-./+=]{16,})'

IGNORE_GLOBS=(
  "!**/.env.example"
  "!**/*.md"
  "!**/CHANGELOG*.md"
  "!**/README.md"
)

RG_ARGS=()
for glob in "${IGNORE_GLOBS[@]}"; do
  RG_ARGS+=(--glob "$glob")
done

if rg -n --hidden --no-ignore-vcs "${RG_ARGS[@]}" -e "$PATTERN" .; then
  echo
  echo "❌ Possíveis segredos encontrados. Revise antes de commitar."
  exit 1
fi

echo "✅ Nenhum segredo crítico detectado pelos padrões atuais."
