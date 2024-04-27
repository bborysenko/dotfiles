#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! command -v brew &> /dev/null; then
	echo "⏳ Installing Homebrew ..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo "✅ Homebrew has been installed"
else
	echo "✅ Homebrew has been already installed"
fi
