#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! brew list mysql-client &> /dev/null; then
	echo "⏳ Installing mysql-client ..."
	brew install mysql-client
	echo "✅ mysql-client has been installed"
else
	echo "✅ mysql-client is already installed"
fi
