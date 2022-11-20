namespace :dev do
  desc "Prepare environment for personal tests"

  task setup: :environment do
    spinner_show("Apagando banco de dados...") { %x(rails db:drop) }
    spinner_show("Criando novo banco de dados...") { %x(rails db:create) }
    spinner_show("Construindo tabelas do banco...") { %x(rails db:migrate) }
    spinner_show("Criando usuário padrão...") { %x(rails dev:add_default_user) }
    spinner_show("Criando recorrências exemplo...") { %x(rails dev:add_recurrences) }
    spinner_show("Criando transações exemplo...") { %x(rails dev:add_transactions) }
  end

  task add_default_user: :environment do
    User.create(email:"user@user.com", password:"user123", password_confirmation:"user123")
  end

  desc "Adicionar contas ficticias"
  task add_recurrences: :environment do

    2.times do |product|
      Recurrence.create!(
        user_profile: User.last.user_profile,
        title: "Banco Y #{product + 1}",
        price_cents: 10000
      )
    end
  end

  desc "Adicionar transações ficticias conforme as contas cadastradas"
  task add_transactions: :environment do

    Recurrence.all.each do |recurrence|
      rand(2..5).times do
        Transaction.create!(
          user_profile: User.last.user_profile,
<<<<<<< Updated upstream
          type: %i[recipe expense].sample,
          recurrence: recurrence,
=======
          account: account,
>>>>>>> Stashed changes
          category: Category.all.sample,
          title: "Transação - #{recurrence.title}",
          price_cents: rand(100..5000),
          date: Faker::Date.in_date_period(year: 2020, month: 1)
        )
      end
    end

  end

  private

  def spinner_show(msg_start, msg_end = "Concluído")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")   
    spinner.auto_spin 
    spinner.success(msg_end)
  end

end
