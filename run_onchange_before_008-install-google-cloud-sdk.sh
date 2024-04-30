#!/usr/bin/env bash

set -e

if ! gcloud --version &> /dev/null; then
	echo "⏳ Installing Google Cloud CLI ..."
	if [[ "$CHEZMOI_OS" == "linux" ]]; then
		sudo apt-get update
		sudo apt-get install -y apt-transport-https ca-certificates gnupg curl
		curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
		echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
		sudo apt-get update && sudo apt-get install -y google-cloud-cli
	fi
	if [[ "$CHEZMOI_OS" == "darwin" ]]; then
		asdf plugin add gcloud https://github.com/jthegedus/asdf-gcloud
		asdf install gcloud latest
		asdf global gcloud latest
	fi
	echo "✅ Google Cloud CLI has been installed"
else
	echo "✅ Google Cloud CLI has been already installed"
fi
