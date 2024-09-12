#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! mas list | grep 904280696 &> /dev/null; then
	echo "⏳ Installing Things 3 ..."
	mas install 904280696
	echo "✅ Things 3 has been installed"
else
	echo "✅ Things 3 is already installed"
fi
