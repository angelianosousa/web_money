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

    12.times do |product|
      Recurrence.create!(
        user_profile: User.last.user_profile,
        category: Category.first,
        title: "Receita #{product + 1}",
        price_cents: [1000, 1000, 2000, 3000, 4000].sample,
        date_expire: "2022-#{product+1}-#{product+1}"
      )
    end

    12.times do |expense|
      Recurrence.create!(
        user_profile: User.last.user_profile,
        category: Category.second,
        title: "Despesa #{expense + 1}",
        price_cents: [1000, 1200, 700, 500, 320].sample,
        date_expire: "2022-#{expense+1}-#{expense+1}"
      )
    end

  end

  desc "Adicionar transações ficticias conforme as contas cadastradas"
  task add_transactions: :environment do

    Recurrence.all.each do |recurrence|
      rand(2..5).times do
        Transaction.create!(
          user_profile: User.last.user_profile,
          category: recurrence.category,
          recurrence: recurrence,
          title: "Pagamento: #{recurrence.title}",
          price_cents: recurrence.price_cents,
          date: Faker::Date.in_date_period
          # date: recurrence.date_expire
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
