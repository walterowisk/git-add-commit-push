#!/bin/bash

# ++++ STABLE VERSION ++++

# Verifica se o usuário forneceu o nome da branch e a mensagem de commit
if [ "$#" -lt 2 ]; then
  echo "Dica: Use o script no seguinte formato => $0 <branch_name> <commit_message>"
  exit 1
fi

branch_name="$1"
commit_message="${2:-Commit automático}"

# Verifica se o repositório atual é um repositório git
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Erro: Repositório atual não é um repositório Git."
  exit 1
fi

# Verifica se o repositório remoto existe
if ! git ls-remote --exit-code origin; then
  echo "Erro: Repositório remoto 'origin' não encontrado."
  exit 1
fi

# Muda para a branch especificada
git checkout "$branch_name" || exit 1

# Exibe a lista de arquivos modificados
git status --short

# Solicita ao usuário que escolha os arquivos a serem commitados de acordo com a sequência exibida
read -p "Digite os números dos arquivos que deseja commitar (separados por espaços): " file_indices

# Confirma as alterações selecionadas
if [ -n "$file_indices" ]; then
  selected_files=()
  while read -ra indices; do
    for index in "${indices[@]}"; do
      selected_files+=($(git status --short | sed -n "${index}p" | awk '{print $2}'))
    done
  done <<< "$file_indices"

  if [ "${#selected_files[@]}" -gt 0 ]; then
    git add "${selected_files[@]}"
    git commit -m "$commit_message"
    git push origin "$branch_name"
    echo
    echo "✨️As mudanças foram confirmadas e enviadas com sucesso para a branch $branch_name!!✨️"
    echo
  else
    echo "Nenhum arquivo selecionado para commit. Operação cancelada."
  fi
else
  echo "Nenhum arquivo selecionado para commit. Operação cancelada."
fi
