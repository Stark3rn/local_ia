#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
  echo "Ce script doit être exécuté en root (sudo)."
  exit 1
fi

if [ -z "$1" ]; then
  echo "Usage: $0 <utilisateur>"
  exit 1
fi

USER_TO_ADD="$1"

if ! id "$USER_TO_ADD" &>/dev/null; then
  echo "L'utilisateur $USER_TO_ADD n'existe pas."
  exit 1
fi

apt update
apt install -y ca-certificates curl gnupg lsb-release

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable docker
systemctl start docker

usermod -aG docker "$USER_TO_ADD"

docker --version

echo ""
echo "Installation terminée. Veuillez exécuter la commande suivante :"
echo "    newgrp docker"
