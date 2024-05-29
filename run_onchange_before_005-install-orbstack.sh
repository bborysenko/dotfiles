#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! brew list orbstack &> /dev/null; then
	echo "⏳ Installing OrbStack ..."
	brew install --cask orbstack
	echo "✅ OrbStack has been installed"
else
	echo "✅ OrbStack is already installed"
fi
