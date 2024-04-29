#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! mas list | grep 1091189122 &> /dev/null; then
	echo "⏳ Installing Bear Notes ..."
	mas install 1091189122
	echo "✅ Bear Notes has been installed"
else
	echo "✅ Bear Notes has been already installed"
fi