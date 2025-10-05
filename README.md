# 🧹 git-branch-cleaner

A lightweight shell tool to **auto-delete inactive Git branches** (both local & remote)  
while keeping your **main (`master`) branch** and **recently active branches** safe.  
Perfect for developers and teams managing large repositories with hundreds of old branches.

---

## 🚀 Features

- 🧠 Detects inactive branches based on last commit age  
- 🗑️ Deletes stale branches locally **and** on GitHub  
- ⚙️ Configurable inactivity threshold (default: 30 days)  
- 🛡️ Keeps your `master` (or `main`) branch protected  
- 🧩 Clear confirmation before deletion  
- 💻 Works on Linux, macOS, and WSL

---

## 📦 Installation

```bash
# Clone the repo
git clone https://github.com/omaralalwi/git-branch-cleaner.git

# Go inside the repo
cd git-branch-cleaner

# Make the script executable
chmod +x clean_inactive_branches.sh
````

---

## ⚙️ Configuration

You can change these two variables inside the script:

```bash
MAIN_BRANCH="master"   # your main branch name
DAYS_ACTIVE=30         # keep branches active within last 30 days
```

If your main branch is called `main`, just update the value accordingly.

---

## 🧩 Usage

```bash
./clean_inactive_branches.sh
```

The script will:

1. Fetch all remote branches
2. Check each branch’s last commit date
3. List inactive branches (> X days old)
4. Ask for confirmation before deletion
5. Delete inactive branches locally & remotely

---

## 🧠 Example Output

```
Fetching latest remote info...
✅  feature/api-refactor is active (12 days old)
🗑️  fix/old-bug is inactive (74 days old)
🗑️  test/deprecated-flow is inactive (129 days old)

⚠️  The following branches will be deleted:
fix/old-bug
test/deprecated-flow

Are you sure you want to delete these branches? (y/N): y

Deleting remote branch: fix/old-bug
Deleting remote branch: test/deprecated-flow
Deleting local branch: fix/old-bug
Deleting local branch: test/deprecated-flow

✅ Cleanup complete!
```

---

## 🛡️ Safety Tips

* The script **never touches** your `master` (or main) branch.
* You’ll always get a confirmation before deletion.
* To preview branches **without deleting**, comment out these lines:

  ```bash
  git push origin --delete "$branch"
  git branch -D "$branch"
  ```

---

## 🧰 Requirements

* `git` 2.20+
* Bash shell (`bash`, `zsh`, or compatible)
* Access to your GitHub remote (via HTTPS or SSH)

---

## 🤝 Contributing

Pull requests are welcome!
If you’d like to:

* Add support for Bitbucket or GitLab
* Include filters (e.g., keep branches by author or prefix)
* Add dry-run mode or GitHub Action integration

👉 Open an issue or PR — contributions are highly appreciated.

---

## 📜 License

MIT License © 2025

---

## 💬 Inspiration

Created to help developers and teams keep their Git repositories clean and fast.
Because no one needs 1800 stale branches slowing things down 🚀

---

Would you like me to customize this README automatically with your GitHub username and your real repo link (so you can copy-paste and publish immediately)?
```
