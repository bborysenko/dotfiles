#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! brew list asdf &> /dev/null; then
	echo "⏳ Installing Asdf ..."
	brew install asdf
	echo "✅ Asdf has been installed"
else
	echo "✅ Asdf has been already installed"
fi
