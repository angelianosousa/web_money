# Web Money

## Project Description
The objective from this project is to implement a financial system where the users may create your expenses or recipes e register transactions by month whenever they want e see on the graphics how much money they using e what accounts are more expensive.

## Next steps
* Adicionar configuração de notificação de recorrências
* O sistema deve deixar uma notificação padrão de recorrência para 1 dia antes do vencimento
* Importação e exportação de planilha excel para movimentações
* O sistema deve dar um link com uma planilha modelo para importação de movimentações
* Adicionar testes automatizados de integração

## Getting Started

### Dependencies

* ruby 2.7.5
* rails 6.0.1
* Postgre SQL 12.1
* Bootstrap 4.3.1
* Chartkick and groupdate for charts
* Fontawesome 4.6.3

### Build Project

~~~bash
  docker-compose up --build
~~~

This command will create run migrations

### To populate the database

~~~bash
  docker-compose run app rails db:seed
~~~

## Importants Links

In Staging: https://web-money-6tx3.onrender.com/

## Author

Angeliano Sousa [LinkedIn](https://www.linkedin.com/in/angeliano-sousa/)
