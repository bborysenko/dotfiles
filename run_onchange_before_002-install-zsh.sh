#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" == "linux" ]]; then
	if ! zsh --version &> /dev/null; then
		echo "⏳ Installing Zsh ..."
		sudo apt-get update
		sudo apt-get install zsh
		sudo chsh -s $(which zsh) $(whoami)
		echo "✅ Zsh has been installed"
	else
		echo "✅ Zsh has been already installed"
	fi
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "⏳ Installing Oh My Zsh ..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo "✅ Oh My Zsh has been installed"
else
	echo "✅ Oh My Zsh has been already installed"
fi
