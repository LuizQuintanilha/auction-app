# README
## Sobre:
Este projeto se trata de uma aplicação  web com Ruby on Rails que servirá para conectar o público em geral com o estoque de itens abandonados, permitindo que estes itens sejam comercializados com preços atrativos e que, ao mesmo tempo, os galpões tenham seus espaços melhor aproveitados. O formato escolido foi o de leilão de itens.

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