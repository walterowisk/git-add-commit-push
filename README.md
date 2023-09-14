<p align="center">
  <a href="https://skillicons.dev">
    <img src="https://skillicons.dev/icons?i=git,bash" />
  </a>
</p>

## :robot: Automatizando Git workflow com bash script simples

Todo mundo que utiliza o Git para controle de versão de código precisa executar comandos repetitivos e às vezes maçantes. Isso pode ser resolvido (ou amenizado) de algumas formas, como por exemplo utilizando aliases do próprio Git ou configurando bibliotecas como Commitlint, Husky e Commitizen.

Outra forma de agilizar esse processo é utilizando um bash script que seja capaz de automatizar um fluxo simples poupando comandos repetitivos.

### :technologist: O que faz este script
Automatiza três ações principais do Git:

1. Alterna para uma branch especificada (`git checkout`);
2. Verifica se existe alteração no código (`git status`) ;
3. Confirma as alterações com uma mensagem fornecida pelo usuário e envia para a branch definida (`git commit` / `git push`)

### :knife: Destrinchando o código
```bash
#!/bin/bash

# Verifica se o usuário forneceu o nome da branch e a mensagem de commit
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <branch_name> <commit_message>"
  exit 1
fi

branch_name="$1"
commit_message="${2:-Commit automático}"

```
Nesta parte inicial do script, ele verifica se o usuário forneceu pelo menos dois argumentos ao chamar o script: o nome da branch e a mensagem de commit. Se não forem fornecidos os argumentos necessários, o script exibe uma mensagem de uso e sai com um código de erro 1.

### :keyboard: Como usar este script
Clone o repositório, navegue até o diretório, dê permissão de execução e execute o arquivo conforme especificado no script:

1. `git clone git@github.com:walterowisk/git-add-commit-push.git`
2. `cd git-add-commit-push`
3. `chmod +x git-add-commit-push.git`
4. `./git-add-commit-push.git nome-da-branch "mensagem de commit"`

### :clap:	 Referência

 - [Automate Your Git Workflow with this Simple Bash Scripts](https://dev.to/devrx/automate-your-git-workflow-with-this-simple-bash-script-5cm5)

