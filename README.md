# Finantial Systema

## Project Description
The objective from this project is to implement a financial system where the users may create your expenses or recipes e register transactions by month whenever they want e see on the graphics how much money they using e what accounts are more expensive.

## Getting Started

### Dependencies

* ruby 2.7.5
* rails .5.2.0
* Postgre SQL
* Bootstrap 4.3.1

### Build Project

~~~ruby
  - bundle install
  - rails db:create db:migrate
~~~

Commands for populate database
~~~ruby
  - rails dev:add_default_user
  - rails dev:add_recurrences # For create default accounts
  - rails dev:add_transactions # For create some transactions
~~~

Default user for heroku
~~~
  email: user@user.com
  senha: user123
~~~

## Importants Links

* In production: https://www.herokuapp.com/finantial-system.com.br
* In Staging: https://staging-finantial-system.herokuapp.com/

## Author

Angeliano Sousa [LinkedIn](https://www.linkedin.com/in/angeliano-sousa/)
