#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! brew list visual-studio-code &> /dev/null; then
	echo "⏳ Installing Visual Studio Code ..."
	brew install --cask visual-studio-code
	echo "✅ Visual Studio Code has been installed"
else
	echo "✅ Visual Studio Code has been already installed"
fi
