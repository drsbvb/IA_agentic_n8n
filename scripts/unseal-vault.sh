#!/usr/bin/env bash

set -euo pipefail

echo "🔓 Unseal Vault (2 clés requises)"

read -p "Unseal key 1: " KEY1
docker exec -i vault vault operator unseal "$KEY1"

read -p "Unseal key 2: " KEY2
docker exec -i vault vault operator unseal "$KEY2"

echo "✅ Vault déverrouillé"

