#!/bin/bash

# Pergunta a mensagem de commit
read -p "Digite a mensagem do commit: " mensagem

# Caso aperte Enter sem digitar nada, usa uma mensagem padrão
if [ -z "$mensagem" ]; then
    mensagem="Atualização automatizada em $(date +'%d/%m/%Y %H:%M')"
fi

echo -e "\nAdicionando arquivos..."
git add .

echo "Criando commit..."
git commit -m "$mensagem"

echo "Enviando para o GitHub..."
git push

echo -e "\nProjeto salvo com sucesso no GitHub!"
read -p "Pressione Enter para fechar..."