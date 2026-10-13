#!/usr/bin/env bash
# Copy my personal skills from ~/.claude/skills into this repo, then show what changed.
# netinf-troubleshooter is intentionally excluded (Amazon-internal content).
set -euo pipefail
cd "$(dirname "$0")"
for s in teach explain unknowns asset-advisor; do
  rsync -a --delete --exclude '.backup' ~/.claude/skills/$s/ skills/$s/
done
git status --short
