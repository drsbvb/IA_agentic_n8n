#!/usr/bin/env bash

set -euo pipefail

CONTAINER_NAME="vault"

echo "🔐 Initialisation de Vault via le container Docker..."

# Vérifier que le container est up
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "❌ Le container Vault n'est pas en cours d'exécution"
  exit 1
fi

# Vérifier si Vault est déjà initialisé
if docker exec -i vault vault status 2>/dev/null | grep -q "Initialized.*true"; then
  echo "❌ Vault est déjà initialisé"
  exit 1
fi

docker exec -i vault vault operator init \
  -key-shares=3 \
  -key-threshold=2 | tee vault-keys.txt

echo
echo "✅ Vault initialisé avec succès"
echo "⚠️  Sauvegarde le fichier vault-keys.txt HORS de la VM"

