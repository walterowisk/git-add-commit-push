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

### :keyboard: Como usar este script
Clone o repositório¹, navegue até o diretório, dê permissão de execução e execute o arquivo conforme especificado no script:

1. `git clone git@github.com:walterowisk/git-add-commit-push.git`
2. `cd git-add-commit-push`
3. `chmod +x git-add-commit-push.git`
4. `./git-add-commit-push.git nome-da-branch "mensagem de commit"`

### :clap:	 Referência

 - [Automate Your Git Workflow with this Simple Bash Scripts](https://dev.to/devrx/automate-your-git-workflow-with-this-simple-bash-script-5cm5)

