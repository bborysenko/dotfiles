# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

This is a chezmoi-managed dotfiles repository for macOS. Chezmoi manages dotfiles by storing them in a source directory (`~/.local/share/chezmoi`) and applying them to the home directory.

## Chezmoi Commands

```bash
# Apply changes to home directory
chezmoi apply

# See pending changes before applying
chezmoi diff

# Edit a managed file (opens source file)
chezmoi edit ~/.zshrc

# Add a new file to be managed
chezmoi add ~/.config/some/file

# Pull and apply updates from remote
chezmoi update
```

## File Naming Conventions

Chezmoi uses special prefixes to transform files:
- `dot_` → `.` (e.g., `dot_zshrc` becomes `~/.zshrc`)
- `.tmpl` suffix → template processed with Go text/template
- Scripts in `.chezmoiscripts/` run during apply:
  - `run_once_before_*` → runs once before other files
  - `run_onchange_after_*` → runs after files change (uses hash comments for change detection)

## Architecture

Bootstrap order on fresh Mac:
1. `run_once_before_01-install-homebrew.sh.tmpl` - installs Homebrew
2. `run_once_before_02-install-oh-my-zsh.sh.tmpl` - installs oh-my-zsh
3. `run_onchange_after_02-brew-bundle.sh.tmpl` - runs `brew bundle --global` when Brewfile changes
4. `run_onchange_after_03-mise-install.sh.tmpl` - installs mise tools (Python first, then others)
5. Dotfiles applied: `.gitconfig`, `.zshrc`, `.Brewfile`, `.config/mise/config.toml`

## Device Profiles

Each device has a profile in `.chezmoidata.yaml` keyed by `SHA256(Mac serial number)[:8]`. Profiles are the source of truth — they define exactly what gets installed. No profile = nothing installed.

`.chezmoi.yaml.tmpl` computes the hash at `chezmoi init` time, looks up the profile, and generates `~/.config/chezmoi/chezmoi.yaml` which overrides the empty defaults.

### Data Structure

Top-level keys are empty defaults. Profiles provide all values:

```yaml
# Defaults (empty)
git: { name: "", email: "" }
brews: { taps: [], formulas: [], casks: [], mas: [] }
mise: { tools: [], versions: {} }

# Each profile defines exactly what to install
profiles:
  <hash>:
    git:
      name: Name
      email: email@example.com
    brews:
      taps: [{ name: "org/tap" }]
      formulas: [chezmoi, gh, git]
      casks: [google-chrome, iterm2]
      mas: [{ name: "App", id: 123456 }]
    mise:
      tools: [python:3.14, jq]  # use tool:version to pin, default is latest
```

### Pattern for Conditional Blocks

Check if a package is in the list (lists are the source of truth, no exclude/extra):

```gotemplate
{{- if has "orbstack" .brews.casks }}
# Content only included if orbstack is installed
{{- end }}
```

For tools that can come from either mise or brew:

```gotemplate
{{- if or (has "kubectl" .mise.tools) (has "kubectl" .brews.formulas) -}}
# Content only included if kubectl is installed
{{- end -}}
```

### Examples

- `dot_zshrc.tmpl` - conditionally adds oh-my-zsh plugins based on installed tools
- `private_dot_ssh/config.tmpl` - includes OrbStack SSH config only if orbstack cask is installed

## Key Files

- `dot_Brewfile` → `~/.Brewfile` - Homebrew packages and casks
- `dot_config/mise/config.toml` → `~/.config/mise/config.toml` - mise tools (gcloud, helm, kubectl, terraform, etc.)
- `dot_gitconfig.tmpl` → `~/.gitconfig` - Git config using `gh` for credentials
- `dot_zshrc` → `~/.zshrc` - Shell config with oh-my-zsh and mise activation
- `.chezmoi.yaml.tmpl` → `~/.config/chezmoi/chezmoi.yaml` - selects device profile and generates config
- `.chezmoiignore` - files to exclude from target (CLAUDE.md, README.md)
