#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${OPENSAND_BASE_URL:-https://opensand.ai/v1}"
MODEL="${OPENSAND_DROID_MODEL:-claude-sonnet-4-6}"
PROVIDER="${OPENSAND_DROID_PROVIDER:-generic-chat-completion-api}"
MAX_OUTPUT_TOKENS="${OPENSAND_DROID_MAX_OUTPUT_TOKENS:-16384}"
API_KEY="${OPENSAND_API_KEY:-${OPENAI_API_KEY:-}}"
SETTINGS_DIR="$HOME/.factory"
SETTINGS_FILE="$SETTINGS_DIR/settings.json"

if [ -z "$API_KEY" ]; then
  printf "Enter your OpenSand API key: "
  stty -echo 2>/dev/null || true
  IFS= read -r API_KEY
  stty echo 2>/dev/null || true
  printf "\n"
fi

if [ -z "$API_KEY" ]; then
  echo "OpenSand API key is required." >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is required to update ~/.factory/settings.json safely." >&2
  exit 1
fi

if [ -n "${SHELL_PROFILE:-}" ]; then
  PROFILE="$SHELL_PROFILE"
elif [ -n "${ZSH_VERSION:-}" ]; then
  PROFILE="$HOME/.zshrc"
elif [ -n "${BASH_VERSION:-}" ]; then
  PROFILE="$HOME/.bashrc"
else
  PROFILE="$HOME/.profile"
fi

mkdir -p "$(dirname "$PROFILE")" "$SETTINGS_DIR"
touch "$PROFILE"
[ -f "$SETTINGS_FILE" ] || printf '{\n  "customModels": []\n}\n' > "$SETTINGS_FILE"
cp "$PROFILE" "$PROFILE.opensand.bak.$(date +%Y%m%d%H%M%S)"
cp "$SETTINGS_FILE" "$SETTINGS_FILE.opensand.bak.$(date +%Y%m%d%H%M%S)"

quote_sh() {
  printf "'%s'" "$(printf "%s" "$1" | sed "s/'/'\\\\''/g")"
}

TMP_PROFILE="$(mktemp)"
awk '
  /^# >>> OpenSand Droid CLI env >>>/ { skip = 1; next }
  /^# <<< OpenSand Droid CLI env <<</ { skip = 0; next }
  !skip { print }
' "$PROFILE" > "$TMP_PROFILE"

{
  printf "\n# >>> OpenSand Droid CLI env >>>\n"
  printf "export OPENSAND_API_KEY=%s\n" "$(quote_sh "$API_KEY")"
  printf "# <<< OpenSand Droid CLI env <<<\n"
} >> "$TMP_PROFILE"
mv "$TMP_PROFILE" "$PROFILE"

OPENSAND_BASE_URL="$BASE_URL" \
OPENSAND_DROID_MODEL="$MODEL" \
OPENSAND_DROID_PROVIDER="$PROVIDER" \
OPENSAND_DROID_MAX_OUTPUT_TOKENS="$MAX_OUTPUT_TOKENS" \
SETTINGS_FILE="$SETTINGS_FILE" \
python3 - <<'PY'
import json
import os
from pathlib import Path

settings_file = Path(os.environ["SETTINGS_FILE"])
base_url = os.environ["OPENSAND_BASE_URL"]
model = os.environ["OPENSAND_DROID_MODEL"]
provider = os.environ["OPENSAND_DROID_PROVIDER"]
max_tokens = int(os.environ["OPENSAND_DROID_MAX_OUTPUT_TOKENS"])

try:
    data = json.loads(settings_file.read_text())
except json.JSONDecodeError as exc:
    raise SystemExit(f"Invalid JSON in {settings_file}: {exc}")

if not isinstance(data, dict):
    data = {}

custom_models = data.get("customModels")
if not isinstance(custom_models, list):
    custom_models = []

custom_models = [
    item for item in custom_models
    if not (
        isinstance(item, dict)
        and (
            item.get("displayName", "").startswith("OpenSand ")
            or (item.get("baseUrl") == base_url and item.get("apiKey") == "${OPENSAND_API_KEY}")
        )
    )
]

custom_models.append({
    "model": model,
    "displayName": f"OpenSand {model}",
    "baseUrl": base_url,
    "apiKey": "${OPENSAND_API_KEY}",
    "provider": provider,
    "maxOutputTokens": max_tokens,
})

data["customModels"] = custom_models
settings_file.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n")
PY

export OPENSAND_API_KEY="$API_KEY"

echo "Factory Droid CLI is configured for OpenSand."
echo "Settings updated: $SETTINGS_FILE"
echo "Profile updated: $PROFILE"
echo "Run this command or open a new terminal:"
echo "  source \"$PROFILE\""

