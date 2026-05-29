#!/usr/bin/env bash

set -euo pipefail

payload="$(cat)"

file_path="$(
  printf '%s' "$payload" | python3 -c '
import json,sys
data=json.load(sys.stdin)
for key in ("file_path","path","relative_path","target_file"):
    value=data.get(key)
    if isinstance(value,str) and value.strip():
        print(value.strip())
        break
' 2>/dev/null || true
)"

if [[ -z "${file_path}" || ! -f "${file_path}" ]]; then
  printf '{}\n'
  exit 0
fi

# Heurística simples:
# - código/identificadores em inglês
# - comentários e documentação em pt-BR
diff_content="$(git diff -- "${file_path}" || true)"

if [[ -z "${diff_content}" ]]; then
  printf '{}\n'
  exit 0
fi

english_comment_hits="$(printf '%s' "$diff_content" | rg -n '^\+.*(//|#|/\*|\*).*\b(the|this|should|must|return|use|fix|update)\b' -i || true)"
portuguese_comment_hits="$(printf '%s' "$diff_content" | rg -n '^\+.*(//|#|/\*|\*).*\b(nao|não|deve|usar|corrige|atualiza|sessao|sessão)\b' -i || true)"

if [[ -n "${english_comment_hits}" && -z "${portuguese_comment_hits}" ]]; then
  printf '{"additional_context":"Hook enforce-language: possivel comentario em ingles detectado. Preferir comentarios/docs em pt-BR e identificadores de codigo em ingles."}\n'
else
  printf '{}\n'
fi

exit 0
