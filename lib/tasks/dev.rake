# frozen_string_literal: true

namespace :dev do
  desc 'Prepare environment for personal tests'

  task setup: :environment do
    spinner_show('Construindo tabelas do banco...') { `bundle exec rake db:migrate` }
    spinner_show('Criando usuário padrão...') { `bundle exec rake dev:add_default_user` }
    spinner_show('Criando adicionar categorias de exemplo...') { `bundle exec rake dev:add_categories` }
    spinner_show('Criando contas e transações de exemplo...') { `bundle exec rake dev:add_accounts_and_transactions` }
  end

  task add_default_user: :environment do
    User.create(email: 'user@user.com', password: 'user123', password_confirmation: 'user123')
  end

  desc 'Adicionar transações ficticias conforme as contas cadastradas'
  task add_accounts_and_transactions: :environment do
    Account.all.each do |account|
      20.times do
        Transaction.create!(
          description: Faker::Lorem.question(word_count: rand(2..5)),
          user_profile: User.last.user_profile,
          account: account,
          category: Category.all.sample,
          price_cents: rand(100..5000),
          date: Faker::Date.in_date_period(year: 2021, month: 12)
        )
      end
    end
  end

  desc 'Criar as categorias bases'
  task add_categories: :environment do
    # Despesas
    %w[Casa Transporte Alimentação Supermercado Internet].each do |category|
      Category.create(title: category, user: User.last)
    end

    # Receitas
    %w[Salário Serviço Investimentos].each do |category|
      Category.create(title: category, user: User.last)
    end
  end

  private

  def spinner_show(msg_start, msg_end = 'Concluído')
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    spinner.notice(msg_end)
  end
end
