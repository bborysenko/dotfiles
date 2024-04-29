#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! brew list google-chrome &> /dev/null; then
	echo "⏳ Installing Google Chrome ..."
	brew install --cask google-chrome
	echo "✅ Google Chrome has been installed"
else
	echo "✅ Google Chrome has been already installed"
fi