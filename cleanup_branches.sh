#!/bin/bash

# Default values
DEFAULT_MAIN_BRANCH="master"
DAYS_ACTIVE=30  # keep branches updated within last X days

# Ask user for main branch (optional)
read -p "Enter main branch name (default: $DEFAULT_MAIN_BRANCH): " USER_INPUT_BRANCH
MAIN_BRANCH=${USER_INPUT_BRANCH:-$DEFAULT_MAIN_BRANCH}

echo "Using main branch: $MAIN_BRANCH"
echo "Fetching latest remote info..."
git fetch --all --prune

echo "Checking for branches to delete (inactive > $DAYS_ACTIVE days)..."
current_date=$(date +%s)

# Get all remote branches except main branch and HEAD
remote_branches=$(git branch -r | grep -vE "$MAIN_BRANCH|HEAD" | sed 's/origin\///')

inactive_branches=()

for branch in $remote_branches; do
  # Get last commit date in seconds since epoch
  last_commit_date=$(git log -1 --format="%ct" origin/$branch 2>/dev/null)

  if [ -z "$last_commit_date" ]; then
    # branch might be empty or invalid
    continue
  fi

  diff_days=$(( (current_date - last_commit_date) / 86400 ))

  if [ $diff_days -gt $DAYS_ACTIVE ]; then
    echo "🗑️  $branch is inactive ($diff_days days old)"
    inactive_branches+=($branch)
  else
    echo "✅  $branch is active ($diff_days days old)"
  fi
done

if [ ${#inactive_branches[@]} -eq 0 ]; then
  echo "No inactive branches to delete."
  exit 0
fi

echo ""
echo "⚠️  The following branches will be deleted (inactive > $DAYS_ACTIVE days):"
printf '%s\n' "${inactive_branches[@]}"
echo ""

read -p "Are you sure you want to delete these branches from origin and locally? (y/N): " confirm
if [[ $confirm != [yY] ]]; then
  echo "❌ Aborted."
  exit 0
fi

# Delete from remote
for branch in "${inactive_branches[@]}"; do
  echo "Deleting remote branch: $branch"
  git push origin --delete "$branch"
done

# Delete locally if they exist
for branch in "${inactive_branches[@]}"; do
  if git show-ref --quiet "refs/heads/$branch"; then
    echo "Deleting local branch: $branch"
    git branch -D "$branch"
  fi
done

echo ""
echo "✅ Cleanup complete!"
