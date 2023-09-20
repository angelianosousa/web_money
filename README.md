# Web Money

## Descrição
Web Money é um sistema financeiro onde os usuários podem adicionar
suas despesas ou receitas, registrar transações e acompanhar suas
movimentações diariamente. Dividindo os registros em diferentes categorias,
como também demonstrando cálculos pertinentes à movimentação
utilizando-se de gráficos e tabelas.

O objetivo principal do sistema é ser uma plataforma capaz de auxiliar o
acompanhamento da própria saúde financeira dos usuários, o planejamento de
metas financeiras e desbloqueio de conquistas conforme estiver avançando
nos seus planos e no uso do sistema.

## Próximos passos
* Adicionar configuração de notificação de recorrências
* O sistema deve deixar uma notificação padrão de recorrência para 1 dia antes do vencimento
* Relatórios de movimentações
* Exportação / Importação de planilhas (Movimentações)
* Adicionar testes automatizados de integração

## Start

### Dependências

* ruby 3.0.5
* rails 6.0.1
* Postgre SQL 12.1
* Bootstrap 4.3.1
* Chartkick and groupdate for charts
* Fontawesome 4.6.3

### Construindo projeto

Instale as dependências do projeto

~~~bash
  bundle install
~~~

Gerar as tabelas do banco de dados

~~~bash
  rails db:setup
~~~

### Rodando projeto

~~~bash
  rails s
~~~

## Author

Angeliano Sousa [LinkedIn](https://www.linkedin.com/in/angeliano-sousa/)
