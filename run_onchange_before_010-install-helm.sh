#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! helm version &> /dev/null; then
	echo "⏳ Installing Helm ..."
	asdf plugin-add helm https://github.com/Antiarchitect/asdf-helm.git
	asdf install helm latest
	asdf global helm latest
	echo "✅ Helm has been installed"
else
	echo "✅ Helm has been already installed"
fi