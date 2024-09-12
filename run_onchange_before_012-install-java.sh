#!/usr/bin/env bash

set -e

if [ ! -d "$HOME/.sdkman" ]; then
	echo "⏳ Installing SKDMAN ..."
	curl -s "https://get.sdkman.io?rcupdate=false" | bash
	echo "✅ SKDMAN has been installed"
else
	echo "✅ SKDMAN is already installed"
fi

export SDKMAN_DIR="$HOME/.sdkman"
source "$HOME/.sdkman/bin/sdkman-init.sh"

if ! sdk list java | grep -q installed; then 
	version=$(sdk list java | grep -o "[0-9]*\.[0-9]*\.[0-9]*\-tem" | head -n 1)
	echo "⏳ Installing Java ..."
	sdk install java $version
	echo "✅ Java has been installed"
else
	echo "✅ Java is already installed"
fi
