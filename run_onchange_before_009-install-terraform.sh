#!/usr/bin/env bash

set -e

if [[ "$CHEZMOI_OS" != "darwin" ]]; then exit; fi

if ! terraform version &> /dev/null; then
	echo "⏳ Installing Terraform ..."
	asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
	asdf install terraform latest
	asdf global terraform latest
	echo "✅ Terraform has been installed"
else
	echo "✅ Terraform is already installed"
fi