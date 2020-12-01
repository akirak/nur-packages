#!/usr/bin/env bash

# (c) 2020 Akira Komamura

set -euo pipefail

remote=origin
unset changed_hook
is_interactive=1

usage() {
  cat <<EOF
Usage: git-safe-update [--on-changed COMMAND] [--no-interactive]

  --on-changed      Run the command after the head changes
  --no-interactive  Don't enter shell on failure
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --on-changed)
      changed_hook="$2"
      shift
      ;;
    --no-interactive)
      is_interactive=0
      ;;
    *)
      usage
      exit 1
      ;;
  esac
  shift
done

err() { echo "git-safe-update: ERROR: $*" >&2; }

log() { echo "git-safe-update: $*" >&2; }

# Make this script run only inside a working tree
if [[ $(git rev-parse --is-inside-work-tree) != true ]]; then
  err "Not inside a Git working tree."
  exit 1
fi

# If the HEAD is not on a branch, don't update head.
if ! git rev-parse --quiet --verify HEAD >/dev/null; then
  err "The current HEAD is detached."
  exit 1
fi

branch="$(git symbolic-ref --short HEAD)"

# Verify if there is the remote
if [[ -z "$(git config --local --get remotes.origin.url)" ]]; then
  err "There is no remote named origin."
  exit 1
fi

# Allow running it on any branch
# TODO: Abort if HEAD is not on master
# 
# if [[ $branch != master ]]; then
#     err "Not on master branch."
#     exit 1
# fi

# Fetch all commits from the remote
git fetch --recurse-submodules=on-demand "$remote"

# Compare the commits
if git diff-tree --quiet "HEAD..$remote/$branch"; then
  log "The branch is up-to-date."
  exit 0
fi

# Preserve merges when rebasing.
# See https://derekgourlay.com/blog/git-when-to-merge-vs-when-to-rebase/
if git rebase --autostash --rebase-merges "$remote/$branch"; then
  if [[ -v changed_hook ]]; then
    ${changed_hook}
  fi
elif ! git diff-index --name-status --exit-code HEAD; then
  err "The working tree is not clean."
  err "Maybe uncomitted changes have been restored from a stash."
  if [[ ${is_interactive} -gt 0 ]]; then
    exec "$SHELL"
  fi
else
  err "Rebasing failed."
  if [[ ${is_interactive} -gt 0 ]]; then
    exec "$SHELL"
  fi
fi
