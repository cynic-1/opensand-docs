#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${OPENSAND_ANTHROPIC_BASE_URL:-https://opensand.ai}"
API_KEY="${OPENSAND_API_KEY:-${ANTHROPIC_AUTH_TOKEN:-${ANTHROPIC_API_KEY:-}}}"

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

mkdir -p "$(dirname "$PROFILE")"
touch "$PROFILE"
cp "$PROFILE" "$PROFILE.opensand.bak.$(date +%Y%m%d%H%M%S)"

quote_sh() {
  printf "'%s'" "$(printf "%s" "$1" | sed "s/'/'\\\\''/g")"
}

TMP_FILE="$(mktemp)"
awk '
  /^# >>> OpenSand Claude Code >>>/ { skip = 1; next }
  /^# <<< OpenSand Claude Code <<</ { skip = 0; next }
  !skip { print }
' "$PROFILE" > "$TMP_FILE"

{
  printf "\n# >>> OpenSand Claude Code >>>\n"
  printf "export OPENSAND_API_KEY=%s\n" "$(quote_sh "$API_KEY")"
  printf "export ANTHROPIC_BASE_URL=%s\n" "$(quote_sh "$BASE_URL")"
  printf "export ANTHROPIC_AUTH_TOKEN=\"\$OPENSAND_API_KEY\"\n"
  printf "export ANTHROPIC_API_KEY=\"\$OPENSAND_API_KEY\"\n"
  printf "# <<< OpenSand Claude Code <<<\n"
} >> "$TMP_FILE"

mv "$TMP_FILE" "$PROFILE"

export OPENSAND_API_KEY="$API_KEY"
export ANTHROPIC_BASE_URL="$BASE_URL"
export ANTHROPIC_AUTH_TOKEN="$API_KEY"
export ANTHROPIC_API_KEY="$API_KEY"

echo "Claude Code is configured for OpenSand."
echo "Profile updated: $PROFILE"
echo "Run this command or open a new terminal:"
echo "  source \"$PROFILE\""

