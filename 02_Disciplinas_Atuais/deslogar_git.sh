#!/usr/bin/env bash
# logout-github-mac-linux.sh
# Remove suas credenciais e configurações do Git/GitHub deste computador (macOS/Linux).
# Uso: chmod +x logout-github-mac-linux.sh && ./logout-github-mac-linux.sh

set -e

echo "==> Removendo nome/e-mail configurados globalmente no Git..."
git config --global --unset user.name 2>/dev/null || true
git config --global --unset user.email 2>/dev/null || true

echo "==> Limpando cache de credenciais do Git..."
git credential-cache exit 2>/dev/null || true

echo "==> Removendo arquivo de credenciais salvas em texto (~/.git-credentials)..."
rm -f "$HOME/.git-credentials"

echo "==> Removendo tokens salvos no gitconfig (credential.helper)..."
git config --global --unset-all credential.helper 2>/dev/null || true

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "==> Removendo credenciais do Keychain (macOS) relacionadas ao GitHub..."
    security delete-internet-password -s github.com 2>/dev/null || true
    security delete-generic-password -s "github.com" 2>/dev/null || true
fi

if command -v gh &> /dev/null; then
    echo "==> Fazendo logout da GitHub CLI (gh)..."
    gh auth logout --hostname github.com -y 2>/dev/null || true
fi

echo "==> Removendo chaves SSH carregadas no agente..."
ssh-add -D 2>/dev/null || true

echo ""
echo "Pronto! Sua conta do Git/GitHub foi removida deste computador."