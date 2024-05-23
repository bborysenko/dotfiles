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

plugins=(
	"diff https://github.com/databus23/helm-diff"
)

for plugin in "${plugins[@]}"; do
	plugin_name=$(echo "$plugin" | awk '{print $1}')
	plugin_repo=$(echo "$plugin" | awk '{print $2}')

	if ! helm plugin list | grep -q "^$plugin_name"; then
		echo "⏳ Installing Helm plugin $plugin_name ..."
		helm plugin install "$plugin_repo"
		echo "✅ Helm plugin $plugin_name has been installed"
	else
		echo "✅ Helm plugin $plugin_name is already installed"
	fi
done