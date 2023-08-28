#!/bin/bash

# Verifica se o usuário forneceu o nome da branch e a mensagem de commit
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <branch_name> <commit_message>"
  exit 1
fi

branch_name="$1"
commit_message="$2"

# Verifica se existe alguma alteração para ser comitada
check_changes() {
  if [ -z "$(git status --porcelain)" ]; then
    echo "Não há alterações para commit."
    exit 0
  fi
}

# Adiciona alterações, faz commit e push
commit_and_push() {
  git add .
  git commit -m "$commit_message"
  git push origin "$branch_name"
}

# Início das verificações do script
echo "Executando script para automatizar ações do Git..."

# Verifica se o repositório atual é um repositório git
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Erro: Repositório atual não é um repositório Git."
  exit 1
fi

# Muda para a branch especificada
git checkout "$branch_name"

# Verifica se existem alterações
check_changes

# Executa commit e push
commit_and_push

echo "Mudanças confirmadas e enviadas com sucesso para a branch $branch_name."
