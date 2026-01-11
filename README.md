# Dotfiles

My dotfiles managed with [chezmoi](https://chezmoi.io).

## Quick Start

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply bborysenko
```

## After Bootstrap

Manual steps that can't be easily automated. Since clean installs are rare, this is just a reference to not miss anything.

### Chrome

1. Set as default browser (System Settings > Desktop & Dock > Default web browser)
2. Create profiles for personal and work accounts

### CleanShot X

1. Activate license
2. Follow the built-in setup wizard
3. Enable "hide desktop icons while capturing"
4. Set save location to iCloud Drive/Screenshots

### Obsidian

1. Sign in to Obsidian Sync and connect Notes vault to ~/Notes
2. Exclude from Spotlight (System Settings > Spotlight > Privacy):
   - ~/Notes
   - iCloud Drive/Obsidian

### GitHub

Sign in to GitHub in Chrome first, then:

```bash
gh auth login
```

### Claude

Sign in with work account.

### Claude Code

Sign in with work account:

```bash
claude
```

### Raycast

1. Follow the built-in setup wizard (skip extensions, they sync after sign in)
2. Replace Spotlight hotkey with Raycast:
   - Disable "Show Spotlight search": System Settings > Keyboard > Keyboard Shortcuts > Spotlight
   - Set Raycast hotkey to Cmd+Space in Raycast Settings
3. Sign in to Raycast Pro
4. Enable cloud sync

### Slack

Sign in to work workspace.

### Telegram

Sign in to personal account.

### Viscosity

Import VPN configurations.

### VS Code

Sign in for settings sync.

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