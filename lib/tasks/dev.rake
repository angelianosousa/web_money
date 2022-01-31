namespace :dev do
  desc "TODO"
  task setup: :environment do
    spinner_show("Apagando banco de dados...") { %x( rails db:drop ) }
    spinner_show("Criando novo banco de dados...") { %x( rails db:create ) }
    spinner_show("Construindo tabelas do banco...") { %x( rails db:migrate ) }
    spinner_show("Criando usuário padrão...") { %x( rails dev:add_default_user ) }
    spinner_show("Criando categorias padrão...") { %x( rails dev:add_categories ) }
    spinner_show("Criando recorrências exemplo...") { %x( rails dev:add_recurrences ) }
    spinner_show("Criando transações exemplo...") { %x( rails dev:add_transactions ) }
  end

  task add_default_user: :environment do
    User.create!(email:"user@user.com", password:"user123", password_confirmation:"user123")
  end

  task add_categories: :environment do
    type = ["Receita", "Despesa"]
    badge = ["success", "danger"]
  
    2.times do |i|
      Category.create!(title: type[i], badge: badge[i])
    end
  end

  task add_recurrences: :environment do
    contracts = ["Contrato 01", "Contrato 02", "Contrato 03", "Contrato 04", "Contrato 05"]
    expenses  = ["Conta de Luz", "Conta de Água", "Comida", "Internet", "TV a Cabo"]

    contracts.each do |contract|
      Recurrence.create!(
        user_profile: User.last.user_profile,
        category: Category.first,
        title: contract,
        value: rand(100..10000),
        date_expire: Faker::Date.in_date_period(year: 2022, month: 2)
      )
    end

    expenses.each do |expense|
      Recurrence.create!(
        user_profile: User.last.user_profile,
        category: Category.second,
        title: expense,
        value: rand(100..10000),
        date_expire: Faker::Date.in_date_period(year: 2022, month: 2)
      )
    end

  end

  task add_transactions: :environment do
    60.times do
      Transaction.create!(
        recurrence: Recurrence.all.sample,
        title: Faker::Educator.course_name,
        value: rand(100..10000),
        date: Faker::Date.in_date_period(year: 2022, month: 2)
      )
    end
  end

  private

  def spinner_show(msg_start, msg_end = "Concluído")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")   
    spinner.auto_spin 
    spinner.success(msg_end)
  end

end
