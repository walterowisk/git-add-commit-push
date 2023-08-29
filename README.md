## Automatizando Git workflow com bash script simples

Todo mundo que utiliza o Git para controle de versão de código precisa executar comandos repetitivos e às vezes maçantes. Isso pode ser resolvido (ou amenizado) de algumas formas, como por exemplo utilizando aliases do próprio Git ou configurando bibliotecas como Commitlint, Husky e Commitizen.

Outra forma de agilizar esse processo é utilizando um bash script que seja capaz de automatizar um fluxo simples poupando comandos repetitivos.

### O que faz este script
Automatiza três ações principais do Git:

1. Alterna para uma branch especificada (`git checkout`);
2. Verifica se existe alteração no código (`git status`) ;
3. Confirma as alterações com uma mensagem fornecida pelo usuário e envia para a branch definida (`git commit` / `git push`)



