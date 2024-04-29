#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! brew list viscosity &> /dev/null; then
	echo "⏳ Installing Viscosity ..."
	brew install --cask viscosity
	echo "✅ Viscosity has been installed"
else
	echo "✅ Viscosity has been already installed"
fi
