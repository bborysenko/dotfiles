#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! brew list mas &> /dev/null; then
	echo "⏳ Installing command line interface for the Mac App Store ..."
	brew install mas
	echo "✅ Command line interface for the Mac App Store has been installed"
else
	echo "✅ Command line interface for the Mac App Store has been already installed"
fi