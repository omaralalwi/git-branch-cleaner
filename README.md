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
./cleanup_branches.sh
```

## 🧰 Requirements

* `git` 2.20+
* Bash shell (`bash`, `zsh`, or compatible)
* Access to your GitHub remote (via HTTPS or SSH)
* 
---

## 📜 License

MIT License © 2025
