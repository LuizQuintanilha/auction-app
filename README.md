# README
## Sobre:
Este projeto se trata de uma aplicação  web com Ruby on Rails que servirá para conectar os usuários a produtos cadastrados em lotes, estes lotes poderão ser arrematados através de lances realizados por usuários logados.
O projeto permite três tipos de acessos:
  ##Administrador: 
    Depois de logado usuário  tem permissão de cadastrar produtos e lotes, bem como excluí-los, aprovar e encerrar lotes, bloquear e desbloquear conta de usuários, autorizar e responder perguntas, podendo também excluí-las. Não é capaz de realizar lances e nem de fazer perguntas.
  ##Usuário logado:
    Usuário tem acesso as páginas que contêm todos os produtos cadastrados, todos os lotes cadastrados, todos os lotes vencedores, além de ter acesso a duas páginas exclussivas onde pode ver seus lotes adquiridos e lotes favoritados e um campo de busca. É capaz de fazer perguntas, favoritar e desfavoritar um lote e realizar lances.
  ##Usuário não logado:
    Usuário tem acesso as páginas que contêm todos os produtos cadastrados, todos os lotes cadastrados, todos os lotes vencedores. Não é capaz de realizar perguntas e nem fazer lances.

Produtos:
  - Nome
  - Foto(aceita qualquer formato de imagem)
  - Peso
  - Comprimento
  - Altura
  - Profundidade
  - Descrição
  - Categoria do Produto (categorias prefiamente cadastradas)

Lotes:
  - Produto(s)
  - Código do lote(único e criado de forma manual, devendo conter 3 letras e 6 números)
  - Data/hora inicial
  - Data/hora final
  - Valor inicial do lote
  - Diferença mínima entre lances
  - Um lote depois de criado deve ser aprovado por um segundo admistrador
  - Um lote terá o status: 'Em andamento', 'Lote futuro' ou 'Lote encerrado'


    
Projeto criado com --minimal e --skip -test
Criação realizada com TDD (Test Driven Development)

## Projeto Treinadev - Fluxo de atividades
https://github.com/users/LuizQuintanilha/projects/2

https://github.com/LuizQuintanilha/auction-app/issues/3

## Gems

| Resource | Version|
|:---|:---:|
| bootsnap | 1.4.4 |
| puma | 5.0 |
| Ruby | 3.0.0p0 |
| Ruby on Rails | 7.0.4.3 |
| rubocop-rails ||
| rspec ||
| devise ||
| sqlite | 1.4 |
| capybara ||
| pry-byebug ||
| activestorage | 5.2' |
| simplecov |
## Instalando projeto:

### Instalando gems:

```
bundle install
```
### Configurando banco de dados:
```
rails db:create
rails db:migrate
rails db:seed
```

### Iniciando  Aplicação:
```
rails server
```