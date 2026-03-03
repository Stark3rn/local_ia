#!/bin/bash

if [ "$EUID" -eq 0 ]; then
  echo "Ce script ne doit pas être exécuté en root."
  exit 1
fi

if ! docker info >/dev/null 2>&1; then
  echo "Docker ne semble pas accessible."
  echo "Assurez-vous d'avoir ajouté votre utilisateur au groupe docker"
  echo "et relancé votre session (ou exécuté 'newgrp docker')."
  exit 1
fi

echo "Création du dossier de stockage..."
mkdir -p ~/.anythingllm

echo "Lancement d'AnythingLLM..."
docker run -d \
  --name anythingllm \
  --restart unless-stopped \
  -p 3001:3001 \
  -v ~/.anythingllm:/app/server/storage \
  mintplexlabs/anythingllm

echo ""
echo "Installation terminée."
echo "Accédez à : http://localhost:3001"
