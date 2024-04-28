#!/usr/bin/env bash

set -e

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "⏳ Installing Oh My Zsh ..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo "✅ Oh My Zsh has been installed"
else
	echo "✅ Oh My Zsh has been already installed"
fi
