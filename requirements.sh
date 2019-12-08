#!/bin/bash

# Install Terraform
xcode-select --install
brew install gcc
brew install tfenv
tfenv install 0.11.14

# Install git
git --version
if [ "$?" -eq 0 ]; then
  echo "Git is already installed, continuing..."
  exit 0
else
  echo "Git not found, installing..."
  brew install git
fi

# Insall docker
brew cask install docker

# make scripts executable
chmod +x plan.sh
chmod +x deploy.sh
chmod +x destroy.sh
chmod +x ./scripts/ecr_login.sh
chmod +x ./docker_images/flask/flask.sh