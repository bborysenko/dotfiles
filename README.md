# Dotfiles

My dotfiles managed with [chezmoi](https://chezmoi.io).

## Quick Start

```bash
xcode-select --install  # git is required; wait for install to complete
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply bborysenko
```

## What's Included

### Device Profiles

Each device has a profile in [.chezmoidata.yaml](.chezmoidata.yaml) that defines exactly what gets installed — Homebrew packages, mise tools, and git config. Profiles are keyed by a SHA256 hash of the Mac serial number (first 8 chars) for privacy. No profile = nothing installed.

The device profile is auto-detected via serial number hash in `.chezmoi.yaml.tmpl` and exposed to all templates — changes take effect immediately on `chezmoi apply`.

#### Adding a New Device

1. Get your profile ID:

```bash
system_profiler SPHardwareDataType | awk '/Serial/{print $NF}' | shasum -a 256 | cut -c1-8
```

2. Add a profile entry to `.chezmoidata.yaml`:

```yaml
profiles:
  a1b2c3d4:
    git:
      name: Your Name
      email: your@email.com
    brews:
      taps:
        - name: some/tap
      formulas: [chezmoi, gh, git, mas, mise, tree]
      casks: [google-chrome, iterm2, visual-studio-code]
      mas:
        - name: Bear
          id: 1091189122
    mise:
      tools: [python:3.14, jq, yq]  # use tool:version to pin
```

3. Apply:

```bash
chezmoi apply
```

Preview results with `chezmoi cat ~/.Brewfile` or `chezmoi cat ~/.config/mise/config.toml`.

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

SSH key is auto-generated during bootstrap (`~/.ssh/github_<hostname>`). Complete setup:

```bash
# 1. Authenticate with GitHub
gh auth login

# 2. Upload SSH key for authentication (pull/push)
gh ssh-key add ~/.ssh/github_$(hostname -s).pub --title $(hostname -s)

# 3. Upload SSH key for commit signing
gh auth refresh -s admin:ssh_signing_key
gh ssh-key add ~/.ssh/github_$(hostname -s).pub --title $(hostname -s) --type signing
```

Git is pre-configured to sign commits with SSH. After uploading the signing key, your commits will show as "Verified" on GitHub.

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

### Visual Studio Code

1. Open Settings Sync (Cmd+Shift+P → "Settings Sync: Backup and Sync Settings...")
2. Sign in with GitHub account
3. Choose what to sync (settings, keybindings, extensions, snippets)

### iTerm2

Settings are auto-loaded from `~/.config/iterm2`. Includes:
- Natural Text Editing preset (Cmd+Arrow for line, Option+Arrow for word navigation)

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

# Upgrade mise tools
mise upgrade
```