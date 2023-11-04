<h1>Leilão de Estoque</h1>

> Status do Projeto: ⚠️ Projeto Finalizado
## Sobre o Projeto
<p>

Projeto individual feito como parte do processo do curso de desenvolvimento web, na turma 10 do[TreinaDev](https://treinadev.com.br/), realizado pela [Campus Code](https://www.campuscode.com.br/).

Este projeto se trata de uma aplicação  web com Ruby on Rails que servirá para conectar os usuários a produtos cadastrados em lotes, estes lotes poderão ser arrematados através de lances realizados por usuários logados.
<p>
A aplicação é capaz de receber dados através de API ([Warehouse-App](https://github.com/LuizQuintanilha/warehouse-app)), por isso certifique-se de que tenha as duas aplicações rodando, para total funcionamento da aplicação do projeto Auction-app.
<p>

## Configurações
### Pré-requisitos
⚠️ [Ruby](https://github.com/ruby/ruby) </br>
⚠️ [Ruby On Rails](https://github.com/rails/rails)
### Principais Gems
⚠️ [Devise](https://github.com/heartcombo/devise) </br>
⚠️ [Faraday](https://github.com/lostisland/faraday) </br>
⚠️ [Bootstrap](https://github.com/twbs/bootstrap-rubygem) </br>
⚠️ [Capybara](https://github.com/teamcapybara/capybara) </br>
⚠️ [Rspec](https://github.com/rspec/rspec-rails) </br>
⚠️ [Simplecov](https://github.com/simplecov-ruby/simplecov) </br>
⚠️ [Rubocop 🚓 💀](https://github.com/rubocop/rubocop) </br>

### Como baixar o projeto
 No terminal, faça um clone do projeto com o código abaixo:
 ```
 git@github.com:LuizQuintanilha/auction-app.git
  ```
### Como rodar a aplicação
No terminal, entre na pasta do projeto e digite:
```
bin/setup
```
Logo após:
```
rails db:seed
```
#### Sobre as seeds
As seeds irão popular a aplicação com dados já prontos para facilitar a interação do usuário com ela.
1. Usuários previamente cadastrados:
    * ``vando@leilaodogalpao.com.br`` e ``edna@leilaodogalpao.com.br``, ambos com a senha ``123456``
2. Categorias cadastradas:

    |Nome|
    |----|
    |informatica|
    |eletronico|
    |acessorio|
    |moveis|
    |eletrodomestico|
2. Produtos cadastrados:

    |Nome|Peso|Altura|Profundidade|Largura|Descrição|Foto|Categoria|
    |----|----|------|------------|-------|---------|----|---------|
    |Mouse|90|4|6|12|MOUSE OFFICE TGT P90|informatica|
    |Microondas|90|4|6|12|Microondas 20 Litros|eletrodomestico|
    |Geladeira|90|4|6|12|Geladeira Eletrulux 130L|eletrodomestico|
    |SMARTV|90|4|6|12|Smart-Tv 42 polegadas Samsung|eletronico|
    |Sofa|90|4|6|12|Sofa 3 lugares Loreal Cinza Grafite|moveis|
2. Lotes cadastrados aguardando aprovação:

    |Código|Data inicial|Data final|Lance inicial|Diferença mínima|Estatus|
    |------|---- -------|---- -----|----- -------|--------- ------|-------|
    |ACB112233|Data atual|10 horas apartir de agora|R$622,00|R$17,00|Em andamento|
    |ACB321654|5 horas atrás|1 horas apartir de agora|R$698,00|R$3,00|Em andamento|

    **Obs:** Deve-se utilizar o ``edna@leilaodogalpao.com.br`` para aprovação dos lotes

<br>

### Como rodar os testes

No terminal, abra a pasta do projeto e digite:

```
$ bundle exec rspec
```
### Como executar o app

No terminal e dentro da página do projeto, digite:
```
bundle exec rails server
```
No navegador, utilize a seguinte URL:
```
http://localhost:3000/
```
## Funcionalidades
### **Controle de Usuários**

A aplicação tem dois perfis: administrador responsável por todas as operações e deve ter e-mail com domínio ``leilaodogalpao.com.br`` e usuário comum com acesso a algumas operações.
### **Administrador**

  1. Um administrador pode gerenciar ``produtos`` que contêm ``nome``, ``peso``, ``altura``, ``profundidade``, ``largura``, ``descrição``, ``foto``, ``categoria``.
  2. Um administrador pode gerenciar ``lotes``, que contêm ``codigo``, ``data inicial``, ``data final``, ``lance inicial``, ``diferenca minima``, ``estatus``, e selecionar quais ``produtos`` devem estar disponíveis no ``lote``.
  3. Um administrador pode gerenciar ``usuarios``, bloqueando e desbloquando perfis.
  4. Um administrador pode  aprovar `` lotes``, seguindo a regra de negócio(adminostrador que cria deve ser direfente do administrador que aprova).
  5. Um administrador pode encerrar ``lotes``, (apenas lotes que receberam algum lance podem ser encerrados).
  6. Um administrador pode excluir ``lotes``, (lotes sem lances podem ser excluídos).
  7. Um administrador pode responder ``perguntas de usuários``, após ser respondida, dúvida fica visível na página.
### **Usuario**

  1. Usuário pode ver todos os  ``produtos`` cadastrados.
  2. Usuário pode ver todos os  ``lotes`` cadastrados.
  3. Usuário pode favoritar e desfavoritar ``lotes``.
  4. Usuário pode realizar  ``lances`` nos lotes que estão em andamento.
  5. Usuário pode ver todos os  ``lotes`` vencedores.
  6. Usuário pode ver todos os  ``lotes`` nos quais se saiu vencedor.
  7. Usuário pode fazer ``perguntas`` e ver as ``respostas``.

    **Obs:** Usuário não logados ou com conta suspensa têm acesso apenas as páginas de produtos e lotes cadastrados.
<br>