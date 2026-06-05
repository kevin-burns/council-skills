#!/usr/bin/env bash
#
# fetch-skills.sh — install/refresh the upstream public cloud skill repos.
#
# Lazy install: on first run (or when a provider's cache is missing) it sparse-
# checks-out only the `skills/` subtree of each vendor repo into vendor-skills/.
# On repeat runs it does nothing unless you pass --refresh, which re-pulls the
# latest from upstream. The council's architects read from this cache; nothing
# here is committed (see vendor-skills/.gitignore).
#
# Usage:
#   ./fetch-skills.sh            # install any missing providers, leave the rest
#   ./fetch-skills.sh --refresh  # re-pull every provider from upstream
#   ./fetch-skills.sh --list     # show what's installed and when it was last pulled
#
# Note: in some containerized/CI environments git may report "dubious ownership".
# If so, run: git config --global --add safe.directory '*'  (or the specific path).
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DEST="$ROOT/vendor-skills"

# provider | repo URL | branch | subtree to check out
# To swap Azure for the larger MicrosoftDocs catalogue (193 skills, curated
# Security/Infrastructure/DevOps bundles), comment the azure line and uncomment
# azure-docs. To use an internal mirror in a locked-down network, change the URL.
REPOS=(
  "aws|https://github.com/aws/agent-toolkit-for-aws.git|main|skills"
  "azure|https://github.com/microsoft/azure-skills.git|main|skills"
  "gcp|https://github.com/google/skills.git|main|skills"
  # "azure-docs|https://github.com/MicrosoftDocs/agent-skills.git|main|skills"
)

MODE="install"
case "${1:-}" in
  -r|--refresh) MODE="refresh" ;;
  -l|--list)    MODE="list" ;;
  "")           MODE="install" ;;
  *) echo "unknown option: $1 (use --refresh or --list)"; exit 2 ;;
esac

list_one() {
  local name=$1 dir="$DEST/$name"
  if [[ -d "$dir/.git" ]]; then
    local when; when="$(cat "$dir/.last-pull" 2>/dev/null || echo "unknown")"
    printf "  %-10s installed (last pull: %s)\n" "$name" "$when"
  else
    printf "  %-10s not installed\n" "$name"
  fi
}

fetch_one() {
  local name=$1 url=$2 branch=$3 subtree=$4
  local dir="$DEST/$name"

  if [[ -d "$dir/.git" ]]; then
    if [[ "$MODE" == "refresh" ]]; then
      echo "↻ refreshing $name"
      git -C "$dir" fetch --depth=1 origin "$branch" || return 1
      git -C "$dir" reset --hard "origin/$branch" || return 1
      git -C "$dir" sparse-checkout reapply 2>/dev/null || true
      date -u +"%Y-%m-%dT%H:%M:%SZ" > "$dir/.last-pull"
    else
      echo "✓ $name present (use --refresh to update)"
    fi
    return 0
  fi

  echo "↓ installing $name  ($url : $subtree)"
  git clone --filter=blob:none --no-checkout --depth=1 --branch "$branch" "$url" "$dir" || { rm -rf "$dir"; return 1; }
  git -C "$dir" sparse-checkout init --cone || return 1
  git -C "$dir" sparse-checkout set "$subtree" || return 1
  git -C "$dir" checkout || return 1
  date -u +"%Y-%m-%dT%H:%M:%SZ" > "$dir/.last-pull"
}

mkdir -p "$DEST"

if [[ "$MODE" == "list" ]]; then
  echo "vendor-skills cache: $DEST"
  for entry in "${REPOS[@]}"; do
    IFS='|' read -r name _ _ _ <<< "$entry"
    list_one "$name"
  done
  exit 0
fi

failed=()
for entry in "${REPOS[@]}"; do
  IFS='|' read -r name url branch subtree <<< "$entry"
  if ! fetch_one "$name" "$url" "$branch" "$subtree"; then
    failed+=("$name")
    echo "  ⚠ could not fetch $name from $url"
    echo "    if GitHub is blocked here, point this provider at an internal mirror in REPOS[]"
  fi
done

echo
if [[ ${#failed[@]} -eq 0 ]]; then
  echo "done — skills available under $DEST/<provider>/skills/"
else
  echo "done with ${#failed[@]} failure(s): ${failed[*]}"
  exit 1
fi
