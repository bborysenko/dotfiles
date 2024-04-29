<div align="center">

# Dotfiles

![Latest commit](https://img.shields.io/github/last-commit/bborysenko/dotfiles?style=flat)

My dotfiles managed with [Chezmoi](https://www.chezmoi.io).

</div>

## Quick Start

Set up a new machine with a single command

```
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply bborysenko
```

## Chezmoi Usage

- [`chezmoi add`](https://www.chezmoi.io/reference/commands/add/) Add targets to the source state. If any target is already in the source state, then its source state is replaced with its current state in the destination directory.
- [`chezmoi diff`](https://www.chezmoi.io/reference/commands/diff/) Print the difference between the target state and the destination state for targets. If no targets are specified, print the differences for all targets.
- [`chezmoi apply`](https://www.chezmoi.io/reference/commands/apply/) Ensure that target... are in the target state, updating them if necessary. If no targets are specified, the state of all targets are ensured. If a target has been modified since chezmoi last wrote it then the user will be prompted if they want to overwrite the file.
- [`chezmoi cd`](https://www.chezmoi.io/reference/commands/cd/) Launch a shell in the working tree (typically the source directory). The shell will have various `CHEZMOI*` environment variables set, as for scripts.
- [`chezmoi update`](https://www.chezmoi.io/reference/commands/update/) Pull changes from the source repo and apply any changes.
- [`chezmoi state`](https://www.chezmoi.io/reference/commands/state/) Manipulate the persistent state.

## System Settings

...

## Applications

- Web Browser ([Safari](https://www.apple.com/safari/), [Chrome](https://www.google.com/))
- Note Taking ([Apple Notes](https://apps.apple.com/us/app/notes/id1110145109), [Bear Notes](https://bear.app))
- Task Management ([Apple Reminders](https://apps.apple.com/us/app/reminders/id1108187841))

## Developer Environment

- Shell ([Zsh](https://www.zsh.org), [Oh My Zsh](https://ohmyz.sh))
- Terminal ([iTerm2](https://iterm2.com))
- Containers & VMs ([OrbStack](https://orbstack.dev))

## References

- [dotfiles.github.io](https://dotfiles.github.io)
- [chezmoi](https://www.chezmoi.io)