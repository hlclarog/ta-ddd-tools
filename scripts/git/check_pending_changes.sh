#!/usr/bin/env bash

# Variable to indicate if there are pending changes
changes_pending=false

# Get the list of local branches with pending changes
branches_with_changes=$(git for-each-ref --format '%(refname:short)' --sort -committerdate refs/heads/)

# Iterate over each branch and check if it has pending changes
for branch in $branches_with_changes; do
  # Check if the branch has pending changes
  changes=$(git log origin/${branch}..${branch})

  if [ -n "$changes" ]; then
    echo "The branch '${branch}' has pending changes to push."
    changes_pending=true
  else
    echo "The branch '${branch}' has no pending changes."
  fi
done

# If there are pending changes, exit with a non-zero exit code (1)
if [ "$changes_pending" = true ]; then
  exit 1
else
  exit 0
fi