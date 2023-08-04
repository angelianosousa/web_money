# Web Money

## Descrição

***
Breve descrição do projeto.

## Próximos passos
* Adicionar configuração de notificação de recorrências
* O sistema deve deixar uma notificação padrão de recorrência para 1 dia antes do vencimento
* Importação e exportação de planilha excel para movimentações
* O sistema deve dar um link com uma planilha modelo para importação de movimentações
* Adicionar testes automatizados de integração

### Dependências

* ruby 2.7.5
* rails 6.0.1
* Postgre SQL 12.1
* Bootstrap 4.3.1
* Chartkick and groupdate for charts
* Fontawesome 4.6.3

### Rodando o projeto

~~~bash
    rails db:setup && rails server
~~~

* Esse comando deve criar e rodar as migrações do projeto conforme o schema.rb e subir o servidor do projeto no link http://localhost:3000


~~~bash
    rails db:seed
~~~

* O comando acima gera mais dados ficticios caso precise para mais testes

## Author

Angeliano Sousa [LinkedIn](https://www.linkedin.com/in/angeliano-sousa/)
