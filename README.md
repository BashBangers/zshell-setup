# ⚙️ Zsh Shell Setup

A modern Zsh environment installer for developers, built with Zinit, OMZ plugins, Powerlevel10k, and productivity-focused aliases, prompts, and functions.

## 🚀 What This Script Does

The `setup_zsh.sh` script:

- ✅ Installs required CLI tools on macOS or Ubuntu  
- ✅ Sets Zsh as your default shell  
- ✅ Bootstraps Zinit plugin manager  
- ✅ Copies `.zshrc` and modular config from `configs/` to `~/.zshrc` and `~/.zsh/`  
- ✅ Installs Powerlevel10k theme with a default config  
- ✅ Loads plugins including:  
  - `fzf`, `fzf-tab`, syntax highlighting, autosuggestions  
  - OMZ plugins: `git`, `aws`, `kubectl`, `gh`, `docker`, `kubectx`  
- ✅ Triggers Zinit to install all plugins/snippets during setup  
- ✅ Prepares custom functions under `~/.zsh/functions/`

## 📁 Folder Structure

zshell-setup/  
├── setup_zsh.sh  
└── configs/  
  ├── zshrc  
  └── zsh/  
    └── functions/  
      └── <your_custom_functions>.zsh  

## 🧰 Requirements

| Tool         | macOS Command              | Ubuntu Command                     |
|--------------|----------------------------|-------------------------------------|
| Zsh          | `brew install zsh`         | `sudo apt install zsh`             |
| Git          | `brew install git`         | `sudo apt install git`             |
| Fzf          | `brew install fzf`         | `sudo apt install fzf`             |
| GNU Coreutils| `brew install coreutils`   | Already included (Ubuntu)          |
| Other Tools  | `bat`, `exa`, `ripgrep`, `gh`, `awscli`, `terraform`, `pyenv`, `neovim` |

## 🛠️ Setup Instructions

```bash
git clone https://github.com/your-user/zshell-setup.git
cd zshell-setup
chmod +x setup_zsh.sh
./setup_zsh.sh
```

💡 Restart your terminal or run `exec zsh` to apply changes.

## 🔐 Included Plugins & Features

- Zinit: Plugin/snippet manager  
- Powerlevel10k: Fast and customizable prompt  
- fzf-tab: Better tab completion UI  
- fzf: Fuzzy history search (Ctrl+R)  
- zsh-autosuggestions: Inline autosuggests  
- zsh-syntax-highlighting: Colorful command line  
- OMZ Plugins: `git`, `aws`, `docker`, `kubectl`, `gh`, `kubectx`  
- Aliases & Functions: Includes `notes`, `push-upstream`, `clean-terragrunt`

## ⌨️ Zsh Cheat Sheet

### 🔍 History & Search

| Key        | Action                     |
|------------|----------------------------|
| ↑ / ↓      | Search history with prefix |
| Ctrl+R     | FZF fuzzy history search   |

### 🗂 Word Navigation

| Key        | Action                      |
|------------|-----------------------------|
| ⌥← / ⌥→    | Backward / forward word     |
| Esc + b/f  | Same as above               |
| ⌥⌫        | Delete word backward        |

### 🌍 Prompt Info

| Feature        | Shown When             |
|----------------|------------------------|
| AWS: (profile) | If AWS_PROFILE is set |
|  branch       | If inside a Git repo   |

### 📋 Aliases

| Alias             | Description                              |
|-------------------|------------------------------------------|
| ll                | ls -laFh --group-directories-first       |
| please            | sudo shortcut                            |
| notes foo         | Opens nvim with :Note foo                |
| push-upstream     | Push current Git branch with upstream    |
| aws-profile       | Echo current AWS_PROFILE                 |
| clean-terragrunt  | Removes .terraform locks and cache       |

## 🧼 Cleanup

```bash
rm -rf ~/.zshrc ~/.zsh ~/.zinit ~/.p10k.zsh
```

## 📜 License

MIT License
