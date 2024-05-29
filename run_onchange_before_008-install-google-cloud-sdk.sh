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
	echo "✅ Google Cloud CLI is already installed"
fi

# Install gke-gcloud-auth-plugin to interact with GKE
# https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl#gcloud
if ! gke-gcloud-auth-plugin --version &> /dev/null; then
	echo "⏳ Installing gke-gcloud-auth-plugin ..."
	gcloud components install gke-gcloud-auth-plugin --quiet
	echo "✅ gke-gcloud-auth-plugin has been installed"
else
	echo "✅ gke-gcloud-auth-plugin is already installed"
fi

if [ -f ~/.docker/config.json ] && ! grep -q europe-docker.pkg.dev ~/.docker/config.json; then
	echo "⏳ Configuring authentication to Artifact Registry for Docker ..."
	gcloud auth configure-docker europe-docker.pkg.dev --quiet
	echo "✅ Authentication to Artifact Registry for Docker has been configured."
else
	echo "✅ Authentication to Artifact Registry for Docker has been already configured."
fi