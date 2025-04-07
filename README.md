# ⚙️ Zsh Shell Setup

A developer-focused Zsh environment powered by Zinit, Powerlevel10k, OMZ plugins, and productivity-boosting aliases and functions.

---

## 🚀 What This Setup Includes

- Zinit plugin manager with lazy loading
- Powerlevel10k theme for a beautiful, fast prompt
- OMZ plugins (Git, AWS, Docker, K8s, GH)
- Autosuggestions, syntax highlighting, and FZF-enhanced history
- Custom aliases and shell functions
- Modular config with `~/.zsh/functions/`
- Fully scriptable installer (`setup_zsh.sh`)
- AWS-aware profile checker with STS identity lookup

---

## 🛠️ Installation

```bash
git clone https://github.com/your-user/zshell-setup.git
cd zshell-setup
chmod +x setup_zsh.sh
./setup_zsh.sh
```

---

## 🔐 AWS Identity Checker

The `aws-profile` function shows your current caller identity using `aws sts get-caller-identity`.

### ✅ Usage

```bash
aws-profile                 # Uses current AWS_PROFILE or default
aws-profile --profile dev  # Uses named profile 'dev'
```

If the session is expired or invalid, it will suggest re-login via AWS SSO.

---

## 🧠 Zsh Cheat Sheet (Dev-Centric)

### 🔍 History Search & Recall

| Key / Command   | Description                                   |
|-----------------|-----------------------------------------------|
| ↑ / ↓           | Prefix-aware history search                   |
| `Ctrl + R`      | FZF fuzzy history with preview                |
| `history`       | Show history                                  |
| `!n`            | Run history entry number `n`                  |
| `!!`            | Rerun previous command                        |
| `!string`       | Run last command that starts with `string`    |

---

### 🗂 Word Navigation & Editing

| Key Binding     | Description                                   |
|-----------------|-----------------------------------------------|
| `⌥ ← / ⌥ →`     | Move by word (left/right)                     |
| `Esc + b / f`   | Backward/forward one word                     |
| `⌥ ⌫`           | Delete previous word                          |
| `Ctrl + W`      | Delete word backward                          |
| `Ctrl + U/K`    | Delete line before/after cursor               |
| `Ctrl + A/E`    | Move to start/end of line                     |

---

### 🧱 Directory Navigation

| Command         | Description                                   |
|-----------------|-----------------------------------------------|
| `cd`            | Change directory                              |
| `cd -`          | Switch to previous directory                  |
| `..`, `...`     | Go up 1 or 2 levels (if aliases defined)      |
| `wd add x`      | Save current dir as `x` (via zsh-wd)          |
| `wd x`          | Jump to saved location                        |

---

### 💬 Aliases & Functions

| Alias / Function     | Description                               |
|----------------------|-------------------------------------------|
| `ll`                 | `ls -laFh --group-directories-first`      |
| `please`             | Shortcut for `sudo`                       |
| `notes foo`          | Open Neovim and run `:Note foo`           |
| `push-upstream`      | Git push + set upstream                   |
| `aws-profile`        | Show AWS STS identity, with profile support |
| `clean-terragrunt`   | Clean Terraform lock and cache            |

---

### 🌐 Prompt Status

- AWS profile shown as `AWS: (profile)`
- Git branch shown as ` branch` if in Git repo
- Colored prompt via Powerlevel10k

---

### 🔌 Plugin Highlights

| Plugin                  | Purpose                                 |
|-------------------------|-----------------------------------------|
| zsh-autosuggestions     | Inline command suggestions              |
| zsh-syntax-highlighting | Colorful syntax feedback                |
| fzf + fzf-tab           | Interactive fuzzy search and tab UI     |
| OMZ git/aws/docker/etc. | OMZ plugin snippets                     |
| Powerlevel10k           | Fast and feature-rich prompt            |

---

### ⚙️ Miscellaneous

| Command / Key    | Description                                   |
|------------------|-----------------------------------------------|
| `source ~/.zshrc`| Reload config                                 |
| `exec zsh`       | Restart current shell                         |
| `bindkey -P`     | List active key bindings                      |
| `setopt`         | List current shell options                    |

=======
## 🧠 Zsh Cheat Sheet (Dev-Centric)

### 🔍 History Search & Recall

| Key / Command   | Description                                   |
|-----------------|-----------------------------------------------|
| ↑ / ↓           | Prefix-aware history search                   |
| `Ctrl + R`      | FZF fuzzy history with preview                |
| `history`       | Show history                                  |
| `!n`            | Run history entry number `n`                  |
| `!!`            | Rerun previous command                        |
| `!string`       | Run last command that starts with `string`    |

---

### 🗂 Word Navigation & Editing

| Key Binding     | Description                                   |
|-----------------|-----------------------------------------------|
| `⌥ ← / ⌥ →`     | Move by word (left/right)                     |
| `Esc + b / f`   | Backward/forward one word                     |
| `⌥ ⌫`           | Delete previous word                          |
| `Ctrl + W`      | Delete word backward                          |
| `Ctrl + U/K`    | Delete line before/after cursor               |
| `Ctrl + A/E`    | Move to start/end of line                     |

---

### 🧱 Directory Navigation

| Command         | Description                                   |
|-----------------|-----------------------------------------------|
| `cd`            | Change directory                              |
| `cd -`          | Switch to previous directory                  |
| `..`, `...`     | Go up 1 or 2 levels (if aliases defined)      |
| `wd add x`      | Save current dir as `x` (via zsh-wd)          |
| `wd x`          | Jump to saved location                        |

---

### 💬 Aliases & Functions

| Alias / Function     | Description                               |
|----------------------|-------------------------------------------|
| `ll`                 | `ls -laFh --group-directories-first`      |
| `please`             | Shortcut for `sudo`                       |
| `notes foo`          | Open Neovim and run `:Note foo`           |
| `push-upstream`      | Git push + set upstream                   |
| `aws-profile`        | Echo current AWS profile                  |
| `clean-terragrunt`   | Clean Terraform lock and cache            |

---

### 🌐 Prompt Status

- AWS profile shown as `AWS: (profile)`
- Git branch shown as ` branch` if in Git repo
- Colored prompt via Powerlevel10k

---

### 🔌 Plugin Highlights

| Plugin                  | Purpose                                 |
|-------------------------|-----------------------------------------|
| zsh-autosuggestions     | Inline command suggestions              |
| zsh-syntax-highlighting | Colorful syntax feedback                |
| fzf + fzf-tab           | Interactive fuzzy search and tab UI     |
| OMZ git/aws/docker/etc. | OMZ plugin snippets                     |
| Powerlevel10k           | Fast and feature-rich prompt            |

---

### 🔁 Terminal Multipliers

| Feature         | Shortcut / Usage                              |
|-----------------|------------------------------------------------|
| Autoenv         | Load `.env` when `cd` into folder              |
| Shared history  | `setopt share_history`                        |
| Auto-correct    | `setopt correct`                              |

---

### ⚙️ Miscellaneous

| Command / Key    | Description                                   |
|------------------|-----------------------------------------------|
| `source ~/.zshrc`| Reload config                                 |
| `exec zsh`       | Restart current shell                         |
| `bindkey -P`     | List active key bindings                      |
| `setopt`         | List current shell options                    |

---

## 🧼 Cleanup

```bash
rm -rf ~/.zshrc ~/.zsh ~/.zinit ~/.p10k.zsh
```

---

## 📜 License

MIT License
