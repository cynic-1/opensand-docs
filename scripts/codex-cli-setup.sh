#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${OPENSAND_BASE_URL:-https://opensand.ai/v1}"
MODEL="${OPENSAND_CODEX_MODEL:-gpt-5.5}"
API_KEY="${OPENSAND_API_KEY:-${OPENAI_API_KEY:-}}"
CONFIG_DIR="${CODEX_HOME:-$HOME/.codex}"
CONFIG_FILE="$CONFIG_DIR/config.toml"

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

if [ -n "${SHELL_PROFILE:-}" ]; then
  PROFILE="$SHELL_PROFILE"
elif [ -n "${ZSH_VERSION:-}" ]; then
  PROFILE="$HOME/.zshrc"
elif [ -n "${BASH_VERSION:-}" ]; then
  PROFILE="$HOME/.bashrc"
else
  PROFILE="$HOME/.profile"
fi

mkdir -p "$(dirname "$PROFILE")" "$CONFIG_DIR"
touch "$PROFILE" "$CONFIG_FILE"
cp "$PROFILE" "$PROFILE.opensand.bak.$(date +%Y%m%d%H%M%S)"
cp "$CONFIG_FILE" "$CONFIG_FILE.opensand.bak.$(date +%Y%m%d%H%M%S)"

quote_sh() {
  printf "'%s'" "$(printf "%s" "$1" | sed "s/'/'\\\\''/g")"
}

TMP_PROFILE="$(mktemp)"
awk '
  /^# >>> OpenSand Codex CLI env >>>/ { skip = 1; next }
  /^# <<< OpenSand Codex CLI env <<</ { skip = 0; next }
  !skip { print }
' "$PROFILE" > "$TMP_PROFILE"

{
  printf "\n# >>> OpenSand Codex CLI env >>>\n"
  printf "export OPENSAND_API_KEY=%s\n" "$(quote_sh "$API_KEY")"
  printf "# <<< OpenSand Codex CLI env <<<\n"
} >> "$TMP_PROFILE"
mv "$TMP_PROFILE" "$PROFILE"

TMP_CONFIG="$(mktemp)"
awk '
  BEGIN { top_level = 1 }
  /^# >>> OpenSand Codex CLI >>>/ { skip_marker = 1; next }
  /^# <<< OpenSand Codex CLI <<</ { skip_marker = 0; next }
  skip_marker { next }
  /^\[model_providers\.opensand\]/ { skip_provider = 1; next }
  /^\[/ { skip_provider = 0; top_level = 0 }
  skip_provider { next }
  top_level != 0 && /^(model|model_provider)[[:space:]]*=/ { next }
  { print }
' "$CONFIG_FILE" > "$TMP_CONFIG.raw"

{
  printf '# >>> OpenSand Codex CLI >>>\n'
  printf 'model_provider = "opensand"\n'
  printf 'model = "%s"\n\n' "$MODEL"
  printf '[model_providers.opensand]\n'
  printf 'name = "OpenSand"\n'
  printf 'base_url = "%s"\n' "$BASE_URL"
  printf 'env_key = "OPENSAND_API_KEY"\n'
  printf 'wire_api = "responses"\n'
  printf 'env_key_instructions = "Set OPENSAND_API_KEY to your OpenSand API key."\n'
  printf '# <<< OpenSand Codex CLI <<<\n\n'
  cat "$TMP_CONFIG.raw"
} > "$TMP_CONFIG"

mv "$TMP_CONFIG" "$CONFIG_FILE"
rm -f "$TMP_CONFIG.raw"

export OPENSAND_API_KEY="$API_KEY"

echo "Codex CLI is configured for OpenSand."
echo "Config updated: $CONFIG_FILE"
echo "Profile updated: $PROFILE"
echo "Run this command or open a new terminal:"
echo "  source \"$PROFILE\""
