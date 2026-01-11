# Dotfiles

Managed with [chezmoi](https://chezmoi.io).

## Quick Start

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply bborysenko
```

This will:
1. Install chezmoi (uses builtin git, no dependencies)
2. Clone this repo via HTTPS
3. Install Homebrew (handles Xcode CLT automatically)
4. Install oh-my-zsh
5. Install packages from Brewfile
6. Apply dotfiles

## After Bootstrap

1. **Set up Chrome**: Make Chrome the default browser, then create separate profiles for personal and work Google accounts

2. **Authenticate with GitHub** for push access:
   ```bash
   gh auth login
   ```

3. **Authenticate Claude Code**:
   ```bash
   claude
   ```

## Daily Usage

```bash
# Edit dotfiles
chezmoi edit ~/.zshrc

# See pending changes
chezmoi diff

# Apply changes
chezmoi apply

# Pull and apply updates from repo
chezmoi update

# Add a new file
chezmoi add ~/.config/some/file

# Push changes
chezmoi cd
git add -A && git commit -m "update" && git push
```

## Structure

```
.
├── .chezmoiignore                                      # Files excluded from home directory
├── .chezmoiscripts/
│   ├── run_once_before_01-install-homebrew.sh.tmpl     # Installs Homebrew
│   ├── run_once_before_02-install-oh-my-zsh.sh.tmpl    # Installs oh-my-zsh
│   └── run_onchange_after_02-brew-bundle.sh.tmpl       # Runs brew bundle when Brewfile changes
├── dot_Brewfile                                        # Homebrew packages and casks
├── dot_gitconfig.tmpl                                  # Git config with gh credential helper
└── dot_zshrc                                           # Zsh config with oh-my-zsh
```
