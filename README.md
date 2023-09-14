<p align="center">
  <a href="https://skillicons.dev">
    <img src="https://skillicons.dev/icons?i=git,bash" />
  </a>
</p>

# :robot: Automatizando Git workflow com bash script

Todo mundo que utiliza o Git para controle de versão de código precisa executar comandos repetitivos e às vezes maçantes. Isso pode ser resolvido (ou amenizado) de algumas formas, como por exemplo utilizando aliases do próprio Git ou configurando bibliotecas como Commitlint, Husky e Commitizen.

Outra forma de agilizar esse processo é utilizando um bash script que seja capaz de automatizar um fluxo simples poupando comandos repetitivos.

Essa foi a proposta desta [postagem](https://dev.to/devrx/automate-your-git-workflow-with-this-simple-bash-script-5cm5) que encontrei no dev.to dia desses. A ideia de criar um git workflow com algumas linhas de shell script é ótima, mas ao testar encontrei um problema: `git add .`. Não vi uma forma de selecionar uma unstaged change específica para commit caso houvesse mais de um arquivo pendente.

Com isso, fiz algumas modificações, pedi ajuda de IA generativa para adicionar validações de repositório e _voilá_.


## :technologist: O que faz este script
Automatiza quatro ações principais do Git:

1. Alterna para uma branch especificada (`git checkout`);
2. Verifica se existe alteração no código (`git status`) ;
3. Confirma as alterações com uma mensagem fornecida pelo usuário (`git commit`); 
4. Envia para a branch definida (`git push`).

## :knife: Destrinchando o código
Explicando os trechos do script:


```bash
#!/bin/bash

if [ "$#" -lt 2 ]; then
  echo "Dica: Use o script no seguinte formato => $0 <branch_name> <commit_message>"
  exit 1
fi

branch_name="$1"
commit_message="${2:-Commit automático}"

```
Nesta parte inicial do código, ele verifica se o usuário forneceu pelo menos dois argumentos ao chamar o script: o nome da branch e a mensagem de commit. Se não forem fornecidos os argumentos necessários, o script exibe uma mensagem de dica de uso e sai com um código de erro 1.


```bash
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Erro: Repositório atual não é um repositório Git."
  exit 1
fi

if ! git ls-remote --exit-code origin; then
  echo "Erro: Repositório remoto 'origin' não encontrado."
  exit 1
fi

```
Esta parte do script acima verifica se o diretório atual é um repositório Git, usando o comando `git rev-parse`. Se não for um repositório Git, o script exibe uma mensagem de erro e sai. Logo em seguida verifica se o repositório remoto chamado `origin` existe usando o comando `git ls-remote``. Se não existir, é exibida uma mensagem de erro e o fluxo é encerrado.


```bash
git checkout "$branch_name" || exit 1

git status --short

read -p "Digite os números dos arquivos que deseja commitar (separados por espaços): " file_indices

```
Esta parte do código muda para a branch especificada pelo usuário usando o comando `git checkout`. Se a mudança falhar, o script sai com um código de erro 1. Em seguida exibe a lista de arquivos modificados no formato curto usando o comando `git status --short`. Isso exibe uma lista de arquivos que foram modificados no repositório. Logo em seguida é solicitado ao usuário que insira os números correspondentes à ordem dos arquivos que deseja commitar, separados por espaços.


```sh
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

```
Por fim, o script processa os números dos arquivos inseridos pelo usuário e adiciona, confirma e faz push apenas dos arquivos selecionados. Se nenhum arquivo válido for selecionado para commit, ele exibe uma mensagem informando. Se os arquivos forem selecionados e commitados com sucesso, ele exibirá uma mensagem de sucesso.


## :keyboard: Como usar este script
Clone o repositório, navegue até o diretório, dê permissão de execução e execute o arquivo conforme especificado no script:

1. `git clone git@github.com:walterowisk/git-add-commit-push.git`
2. `cd git-add-commit-push`
3. `chmod +x git-add-commit-push.git`
4. `./git-add-commit-push.git nome-da-branch "mensagem de commit"`

## :clap:	 Referência

 - [Automate Your Git Workflow with this Simple Bash Scripts](https://dev.to/devrx/automate-your-git-workflow-with-this-simple-bash-script-5cm5)

