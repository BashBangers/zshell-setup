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

## 📁 Repository Structure

```
zshell-setup/
├── .zshrc                    # Entry point to load modular config
├── zsh/
│   ├── aliases.zsh           # Alias definitions
│   ├── functions.zsh         # Prompt, env vars, keybindings
│   ├── plugins.zsh           # Plugin loading via Zinit
│   └── functions/            # Modular shell functions
│       ├── aws-profile.zsh
│       ├── aws-ssh.zsh
│       ├── aws-scp.zsh
│       ├── sshquick.zsh
│       ├── scpquick.zsh
│       └── update-zsh.zsh
├── setup_zsh.sh              # Bootstrap setup script
└── README.md
```

---

## 🛠️ Installation

```bash
git clone https://github.com/BashBangers/zshell-setup.git
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

---

## 💬 Key Features

- FZF-powered `Ctrl+R` history recall
- ⌥← / ⌥→ word-based motion
- Prefix-aware history via ↑ / ↓
- Prompt includes AWS profile & Git branch
- `aws-ssh`, `aws-scp`, and `sshquick` for fast cloud access
- Git helpers, Terraform cleanup, `notes` launcher

---

## 🧠 Zsh Productivity Cheat Sheet

📘 Full version: [Zsh Developer Shell Cheat Sheet (Notion)](https://tangible-hoverfly-cc7.notion.site/Zsh-Developer-Shell-Cheat-Sheet-6ed44c36c3bf432e9939503ab0e54d02?pvs=74)

### ✨ Quick Keybindings

| Shortcut      | Action                                     |
|---------------|--------------------------------------------|
| `Ctrl+R`      | Fuzzy reverse history (via `fzf`)          |
| `↑ / ↓`       | Prefix-aware history search                |
| `⌥← / ⌥→`     | Word-level movement (Alt + arrow keys)     |
| `please`      | Sudo alias                                 |
| `push-upstream` | Git push current branch to upstream      |

### 💬 Aliases & Functions

| Alias / Func       | Action |
|--------------------|--------|
| `ll`               | `ls -laFh --group-directories-first` |
| `notes foo`        | Launch Neovim to `:Note foo` |
| `clean-terragrunt` | Remove `.terraform.lock.hcl` and `.terragrunt-cache` |
| `aws-profile`      | Show AWS caller identity |
| `aws-ssh`          | SSH to EC2 via SSM |
| `aws-scp`          | Copy files using SSM |
| `sshquick`         | SSH to configured host |
| `scpquick`         | SCP to configured host |

---

## 🧩 Plugin Highlights

| Plugin                  | Purpose |
|-------------------------|---------|
| `zsh-autosuggestions`   | Inline suggestions |
| `zsh-syntax-highlighting` | Live syntax feedback |
| `fzf` + `fzf-tab`       | Fuzzy finder UI |
| OMZ plugins             | Git, Docker, AWS, etc. |
| Powerlevel10k           | Responsive and rich prompt |


---

## 🤖 GitHub Copilot CLI Integration

This Zsh setup includes a helper module for working with [GitHub Copilot CLI](https://github.com/github/copilot-cli) from your terminal.

### ✅ Requirements

- GitHub CLI (`gh`)
- GitHub Copilot extension for GH CLI

```bash
gh auth login
gh extension install github/gh-copilot
```

### 🧩 Zsh Integration

If you have `~/.zsh/copilot.zsh`, it defines:

| Command / Alias     | Description                                     |
|---------------------|-------------------------------------------------|
| `copilot-suggest`   | Generate a command (alias: `cs`)                |
| `copilot-explain`   | Explain a command (alias: `ce`)                 |
| `copilot-status`    | Show Copilot CLI version and auth info          |

To enable:

```zsh
[[ -f ~/.zsh/copilot.zsh ]] && source ~/.zsh/copilot.zsh
```



## 🧼 Cleanup Instructions

To fully remove the setup:

```bash
rm -rf ~/.zshrc ~/.zsh ~/.zinit ~/.p10k.zsh
```

---

## 📜 License

MIT License
