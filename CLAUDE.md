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

## Conditional Templates

Templates use data from `.chezmoidata.yaml` to conditionally include content based on installed packages.

### Data Structure

```yaml
brews:
  formulas: [...]    # CLI tools installed via brew
  casks: [...]       # GUI apps installed via brew cask
  mas:               # Mac App Store apps
    - name: App Name
      id: 123456
  exclude:
    formulas: []     # Device-specific exclusions
    casks: []
    mas: []
  extra:
    formulas: []     # Device-specific additions
    casks: []
    mas: []

mise:
  tools: [...]       # Tools managed by mise
  exclude: []
  extra: []
```

### Pattern for Conditional Blocks

Check if a package will be installed (in main list OR extra) AND not excluded:

```gotemplate
{{- /* package-name */ -}}
{{- $in_brew := or (has "package" .brews.casks) (has "package" .brews.extra.casks) -}}
{{- if and $in_brew (not (has "package" .brews.exclude.casks)) }}
# Content only included if package is installed
{{- end }}
```

For tools that can come from either mise or brew (like kubectl):

```gotemplate
{{- /* kubectl */ -}}
{{- $in_mise := or (has "kubectl" .mise.tools) (has "kubectl" .mise.extra) -}}
{{- $in_brew := or (has "kubectl" .brews.formulas) (has "kubectl" .brews.extra.formulas) -}}
{{- if and (or $in_mise $in_brew) (not (has "kubectl" .mise.exclude)) (not (has "kubectl" .brews.exclude.formulas)) -}}
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
- `.chezmoiignore` - files to exclude from target (CLAUDE.md, README.md)
