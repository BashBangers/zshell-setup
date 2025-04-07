
# ⚙️ Zsh Developer Shell

A modern Zsh shell setup tailored for productivity, cloud workflows, and clean terminal ergonomics — powered by Zinit, Powerlevel10k, Oh My Zsh plugins, and custom functions.

---

## 🚀 Why Use This Setup?

This shell config turns your terminal into a **developer cockpit**:

- 🔁 **Speed**: Fast startup with lazy-loaded plugins via Zinit  
- 🌈 **Visual Clarity**: Powerlevel10k with AWS + Git prompt awareness  
- 🧠 **Smarts**: Autocomplete, syntax highlighting, and fuzzy recall  
- 🛠️ **Workflow Boosters**: Git, Terraform, AWS, Docker, K8s, and GH aliases  
- 🧩 **Modular & Hackable**: Custom shell functions under `~/.zsh/functions/`

---

## 📦 What’s Inside?

- **Plugin Manager**: [Zinit](https://github.com/zdharma-continuum/zinit) with lazy-loading
- **Prompt Theme**: Powerlevel10k, pre-configured
- **Plugins via OMZ**: `git`, `aws`, `docker`, `kubectl`, `gh`
- **Core Enhancements**:
  - `zsh-autosuggestions` for inline suggestions
  - `zsh-syntax-highlighting` for live feedback
  - `fzf` for fuzzy history and tab-completion
- **Custom Tools**:
  - `aws-profile`: Show current STS identity
  - `please`, `push-upstream`, `notes`, `clean-terragrunt`: Developer aliases

---

## 🛠️ Installation

```bash
git clone https://github.com/your-user/zshell-setup.git
cd zshell-setup
chmod +x setup_zsh.sh
./setup_zsh.sh
```

---

## 🔐 AWS Identity Utility

Use `aws-profile` to inspect your AWS caller identity.

```bash
aws-profile                 # Uses current AWS_PROFILE
aws-profile --profile dev  # Uses specified named profile
```

It will alert if your credentials are expired or invalid and prompt re-auth via AWS SSO.

---

## 🧠 Zsh Productivity Cheat Sheet

### 🔍 History Navigation

| Key / Command | Action |
|---------------|--------|
| ↑ / ↓         | Prefix-aware recall |
| `Ctrl + R`    | Fuzzy history search (FZF) |
| `!!` / `!n` / `!foo` | Re-run previous, numbered, or matching command |

### 🗂 Word & Line Editing

| Key           | Action |
|---------------|--------|
| `⌥ ← / →`     | Move by word |
| `⌥ ⌫` / `Ctrl+W` | Delete word backward |
| `Ctrl+A/E`    | Line start / end |
| `Ctrl+U/K`    | Delete before / after cursor |

### 📁 Directory Shortcuts

| Command       | Description |
|---------------|-------------|
| `cd`, `cd -`  | Standard and previous dir |
| `..`, `...`   | Go up 1 or 2 levels (via alias) |
| `wd add dev`  | Save current dir as `dev` |
| `wd dev`      | Jump to saved dir (via zsh-wd) |

### 💬 Aliases & Functions

| Alias / Func       | Action |
|--------------------|--------|
| `ll`               | `ls -laFh --group-directories-first` |
| `please`           | Shortcut for `sudo` |
| `notes foo`        | Launch Neovim to `:Note foo` |
| `push-upstream`    | Git push and set upstream |
| `clean-terragrunt` | Remove `.terraform.lock.hcl` and `.terragrunt-cache` |
| `aws-profile`      | Show AWS caller identity |

### 🌐 Prompt Details

- Git branch shown with ` branch`
- AWS profile displayed as `AWS: (profile)`
- Prompt is theme-aware via Powerlevel10k

### 🔌 Plugin Highlights

| Plugin                  | Purpose |
|-------------------------|---------|
| `zsh-autosuggestions`   | Inline suggestions |
| `zsh-syntax-highlighting` | Live syntax feedback |
| `fzf` + `fzf-tab`       | Fuzzy finder UI |
| OMZ plugins             | Git, Docker, AWS, etc. |
| Powerlevel10k           | Responsive and rich prompt |

### 🧩 Shell Optimizations

| Feature         | Setting |
|-----------------|---------|
| Autoenv         | Load `.env` on `cd` |
| Shared history  | `setopt share_history` |
| Auto-correct    | `setopt correct` |
| Key introspect  | `bindkey -P` |
| Shell config    | `source ~/.zshrc` or `exec zsh` |

---

## ⚙️ Configuration Layout

Your shell config is modular:

```
~/.zshrc                       # Primary config
~/.zsh/functions/*.zsh         # Custom functions
~/.zsh/p10k.zsh                # Powerlevel10k theme config
~/.zinit                       # Plugin manager
```

---

## 🧼 Cleanup Instructions

To fully remove the setup:

```bash
rm -rf ~/.zshrc ~/.zsh ~/.zinit ~/.p10k.zsh
```

---

## 📜 License

MIT License
