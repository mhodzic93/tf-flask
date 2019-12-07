#!/bin/bash

# terraform install
xcode-select --install
brew install gcc
brew install tfenv
tfenv install 0.11.14
chmod +x plan.sh
chmod +x deploy.sh
chmod +x destroy.sh
