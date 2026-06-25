# 🧹 git-branch-cleaner

A lightweight shell tool to **delete inactive Git branches** (both local & remote)  
while keeping your **main (`master` or `main`) branch** and **recently active branches** safe.  
Perfect for developers and teams managing large repositories with hundreds of old branches.

---

## 🚀 Features

- 🗑️ Deletes stale branches both **locally** and on **GitHub remote**  
- ⚙️ Configurable inactivity threshold (default: 30 days)  
- 🛡️ Keeps your main branch (`master` or `main`) protected  
- 💬 Asks for confirmation before deletion  
- 🧩 Works even when cloned anywhere — you just specify the repo path  
- 💻 Compatible with Linux, macOS, and WSL environments  

---

## 📦 Installation

```bash
# Clone the repo
git clone https://github.com/omaralalwi/git-branch-cleaner.git

# Go inside the folder
cd git-branch-cleaner

# Make the script executable
chmod +x cleanup_branches.sh
````

---

## ⚙️ Configuration

You can change these defaults inside the script or let it ask interactively:

```bash
DEFAULT_MAIN_BRANCH="master"   # main branch name
DAYS_ACTIVE=30                 # branches inactive for more than X days will be deleted
```

When running, the script will:

* Ask for your main branch name (`master` by default)
* Ask for the inactivity duration (in days)
* Confirm before deleting any branch

---

## 🧩 Usage

You can run it **with or without arguments**:

```bash
./git-branch-cleaner.sh
```
➡️ You’ll be asked to enter the path to the repository you want to clean.

---

## 🧰 Requirements

* `git` 2.20+
* `bash` or compatible shell (`bash`, `zsh`, etc.)
* Remote access to your GitHub repository (HTTPS or SSH)

---

## 📜 License

MIT License © 2025
