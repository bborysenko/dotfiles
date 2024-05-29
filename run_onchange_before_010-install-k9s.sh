#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! brew list k9s &> /dev/null; then
	echo "⏳ Installing k9s ..."
	brew install derailed/k9s/k9s
	echo "✅ k9s has been installed"
else
	echo "✅ k9s is already installed"
fi
