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

`.chezmoi.yaml.tmpl` auto-detects the device serial via `ioreg`, hashes it with SHA-256, and exposes the first 8 hex chars as `.profile` in chezmoi's template data. Templates then look up `.profiles` from `.chezmoidata.yaml` using that key. Changes to profiles take effect immediately on `chezmoi apply` (no `chezmoi init` needed).

### Data Structure

`.chezmoidata.yaml` contains only the `profiles` map:

```yaml
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

### Profile Resolution Pattern

Each template starts with a 1-line preamble to resolve the profile (`.profile` is set by `.chezmoi.yaml.tmpl`):

```gotemplate
{{- $p := dig .profile (dict) .profiles -}}
```

Then access profile data with `dig`:

```gotemplate
{{- range dig "brews" "formulas" list $p }}
brew "{{ . }}"
{{- end }}
```

### Pattern for Conditional Blocks

Check if a package is in the list (lists are the source of truth, no exclude/extra):

```gotemplate
{{- if has "orbstack" (dig "brews" "casks" list $p) }}
# Content only included if orbstack is installed
{{- end }}
```

For mise tools, parse `tool:version` entries first to get plain names:

```gotemplate
{{- $miseTools := list -}}
{{- range dig "mise" "tools" list $p -}}
{{-   if contains ":" . -}}
{{-     $miseTools = append $miseTools (split ":" .)._0 -}}
{{-   else -}}
{{-     $miseTools = append $miseTools . -}}
{{-   end -}}
{{- end -}}
{{- if has "kubectl" $miseTools -}}
# kubectl is installed
{{- end -}}
```

### Examples

- `dot_zshrc.tmpl` - conditionally adds oh-my-zsh plugins based on installed tools
- `private_dot_ssh/config.tmpl` - includes OrbStack SSH config only if orbstack cask is installed

## Key Files

- `.chezmoi.yaml.tmpl` - auto-detects device profile via serial number hash, exposes `.profile` to all templates
- `dot_Brewfile.tmpl` → `~/.Brewfile` - Homebrew packages and casks
- `dot_config/mise/config.toml.tmpl` → `~/.config/mise/config.toml` - mise tools (gcloud, helm, kubectl, terraform, etc.)
- `dot_gitconfig.tmpl` → `~/.gitconfig` - Git config using `gh` for credentials
- `dot_zshrc.tmpl` → `~/.zshrc` - Shell config with oh-my-zsh and mise activation
- `.chezmoiignore` - files to exclude from target (CLAUDE.md, README.md)
