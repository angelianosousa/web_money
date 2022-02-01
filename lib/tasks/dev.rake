namespace :dev do
  desc "TODO"
  task setup: :environment do
    spinner_show("Apagando banco de dados...") { %x(rails db:drop) }
    spinner_show("Criando novo banco de dados...") { %x(rails db:create) }
    spinner_show("Construindo tabelas do banco...") { %x(rails db:migrate) }
    spinner_show("Criando usuário padrão...") { %x(rails dev:add_default_user) }
    spinner_show("Criando categorias padrão...") { %x(rails dev:add_categories) }
    spinner_show("Criando recorrências exemplo...") { %x(rails dev:add_recurrences) }
    spinner_show("Criando transações exemplo...") { %x(rails dev:add_transactions) }
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
    contracts = ["Produto 01", "Produto 02", "Produto 03", "Produto 04", "Produto 05"]
    expenses  = ["Conta de Luz", "Conta de Água", "Comida", "Internet", "TV a Cabo"]

    contracts.each do |contract|
      Recurrence.create!(
        user_profile: User.last.user_profile,
        category: Category.first,
        title: contract,
        value: [1000, 1000, 2000, 3000, 4000].sample,
        date_expire: Faker::Date.in_date_period
      )
    end

    expenses.each do |expense|
      Recurrence.create!(
        user_profile: User.last.user_profile,
        category: Category.second,
        title: expense,
        value: [500, 100, 600, 100, 120].sample,
        date_expire: Faker::Date.in_date_period
      )
    end

  end

  task add_transactions: :environment do
    50.times do
      @recurrence = Recurrence.all.sample

      Transaction.create!(
        recurrence: @recurrence,
        title: "Pagamento: #{@recurrence.title}",
        value: @recurrence.value,
        date: @recurrence.date_expire
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
