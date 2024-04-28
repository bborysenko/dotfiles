#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! brew list iterm2 &> /dev/null; then
	echo "⏳ Installing iTerm2 ..."
	brew install --cask iterm2
	echo "✅ iTerm2 has been installed"
else
	echo "✅ iTerm2 has been already installed"
fi
