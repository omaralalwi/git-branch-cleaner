#!/bin/bash

# --- Default values ---
DEFAULT_MAIN_BRANCH="master"
DAYS_ACTIVE=30  # keep branches updated within last X days

echo ""
echo "🧹 Git Branch Cleaner"
echo "----------------------"

# --- Accept path from argument or prompt user ---
if [ -n "$1" ]; then
  REPO_PATH="$1"
else
  read -p "Enter the path to the git repository you want to clean: " REPO_PATH
fi

# --- Validate path ---
if [ ! -d "$REPO_PATH/.git" ]; then
  echo "❌ Error: '$REPO_PATH' is not a valid Git repository (no .git folder found)."
  exit 1
fi

cd "$REPO_PATH" || exit 1
echo "📁 Using repository at: $REPO_PATH"
echo ""

# --- Ask for main branch name (optional) ---
read -p "Enter main branch name (default: $DEFAULT_MAIN_BRANCH): " USER_INPUT_BRANCH
MAIN_BRANCH=${USER_INPUT_BRANCH:-$DEFAULT_MAIN_BRANCH}

# --- Ask for inactivity period (optional) ---
read -p "Enter number of days to consider a branch inactive (default: $DAYS_ACTIVE): " USER_INPUT_DAYS
if [[ "$USER_INPUT_DAYS" =~ ^[0-9]+$ ]]; then
  DAYS_ACTIVE=$USER_INPUT_DAYS
fi

echo ""
echo "Using main branch: $MAIN_BRANCH"
echo "Inactive threshold: $DAYS_ACTIVE days"
echo ""

echo "Fetching latest remote info..."
git fetch --all --prune

echo ""
echo "Checking for branches to delete (inactive > $DAYS_ACTIVE days)..."
current_date=$(date +%s)

# --- Get all remote branches except main and HEAD ---
remote_branches=$(git branch -r | grep -vE "$MAIN_BRANCH|HEAD" | sed 's/origin\///')

inactive_branches=()

for branch in $remote_branches; do
  last_commit_date=$(git log -1 --format="%ct" origin/$branch 2>/dev/null)
  [ -z "$last_commit_date" ] && continue

  diff_days=$(( (current_date - last_commit_date) / 86400 ))

  if [ $diff_days -gt $DAYS_ACTIVE ]; then
    echo "🗑️  $branch is inactive ($diff_days days old)"
    inactive_branches+=($branch)
  else
    echo "✅  $branch is active ($diff_days days old)"
  fi
done

if [ ${#inactive_branches[@]} -eq 0 ]; then
  echo ""
  echo "✨ No inactive branches found. Everything is clean!"
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

# --- Delete from remote ---
for branch in "${inactive_branches[@]}"; do
  echo "Deleting remote branch: $branch"
  git push origin --delete "$branch"
done

# --- Delete locally if exists ---
for branch in "${inactive_branches[@]}"; do
  if git show-ref --quiet "refs/heads/$branch"; then
    echo "Deleting local branch: $branch"
    git branch -D "$branch"
  fi
done

echo ""
echo "✅ Cleanup complete!"
