#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! brew list visual-studio-code &> /dev/null; then
	echo "⏳ Installing Visual Studio Code ..."
	brew install --cask visual-studio-code
	echo "✅ Visual Studio Code has been installed"
else
	echo "✅ Visual Studio Code has been already installed"
fi

EXTENSIONS=(
	"hashicorp.terraform"
	"ms-azuretools.vscode-docker"
	"ms-vscode-remote.remote-containers"
	"redhat.vscode-yaml"
	"wayou.vscode-todo-highlight"
)

for EXTENSION in ${EXTENSIONS[@]}; do
  if ! grep  -q "\"id\":\"$EXTENSION\"" ~/.vscode/extensions/extensions.json; then
	echo "⏳ Installing Visual Studio Code extension $EXTENSION ..."
	code --install-extension $EXTENSION
	echo "✅ Visual Studio Code extension $EXTENSION has been installed"
	else
		echo "✅ Visual Studio Code extension $EXTENSION has been already installed"
	fi
done
