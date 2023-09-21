# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email:"user@user.com", password: "user123", password_confirmation: "user123")

user_profile = User.last.user_profile

# Categorias
  ## Despesas
  ['Casa', 'Transporte', 'Alimentação', 'Supermercado', 'Internet', 'Transferência saída'].each do |category|
    user_profile.categories.find_or_create_by!(title: category, user_profile: user_profile, category_type: :expense)
  end

  ## Receitas
  ['Salário', 'Serviço', 'Investimentos', 'Transferência entrada'].each do |category|
    user_profile.categories.find_or_create_by!(title: category, user_profile: user_profile, category_type: :recipe)
  end

# Contas
  user_profile.accounts.each do |account|
    250.times do
      category = user_profile.categories.sample

      user_profile.transactions.create(
        description: Faker::Lorem.question(word_count: rand(2..5)),
        user_profile: user_profile,
        account: account,
        category: category,
        price_cents: rand(100..5000),
        date: Faker::Date.between(from: 12.month.ago.beginning_of_month, to: Date.today)
      )
    end
  end

# Recorrências
  ## Despesas
  ['Água', 'Energia', 'Internet'].each do |bill|
    user_profile.bills.create(
      title: bill,
      price_cents: rand(100..5000),
      due_pay: Faker::Date.between(from: 12.month.ago.beginning_of_month, to: Date.today),
      bill_type: :expense,
      status: :pending,
      user_profile: user_profile
    )
  end

  ## Receitas
  ['Salário', 'Investimentos', 'Renda Extra'].each do |bill|
    user_profile.bills.create(
      title: bill,
      price_cents: rand(100..5000),
      due_pay: Faker::Date.between(from: 12.month.ago.beginning_of_month, to: Date.today),
      bill_type: :recipe,
      status: :pending,
      user_profile: user_profile
    )
  end

  ## Transações das recorrências
  user_profile.bills.each do |bill|
    100.times do
      category = user_profile.categories.sample
      
      Transaction.create!(
        description: Faker::Lorem.question(word_count: rand(2..5)),
        user_profile: user_profile,
        bill: bill,
        account: user_profile.accounts.sample,
        category: category,
        price_cents: rand(100..5000),
        date: Faker::Date.between(from: 12.month.ago.beginning_of_month, to: Date.today)
      )
    end
  end

# Orçamentos
  ['Reserva de Emergência', 'Aposentadoria', 'Carro Novo'].each do |e|
    Budget.create!(
      objective_name: e,
      goals_price_cents: rand(5000..99999),
      date_limit: Faker::Date.between(from: 12.month.ago.beginning_of_month, to: Date.today.end_of_year),
      user_profile: user_profile
    )
  end

  ## Transações dos orçamentos

  user_profile.budgets.each do |budget|
    category = user_profile.categories.recipes.sample

    10.times do
      Transaction.create!(
        description: Faker::Lorem.question(word_count: rand(2..5)),
        user_profile: user_profile,
        account: user_profile.accounts.sample,
        category: category,
        budget: budget,
        price_cents: rand(100..5000),
        date: Faker::Date.between(from: 12.month.ago.beginning_of_month, to: Date.today)
      )
    end
  end

  achievements = [
    'Parabéns, você está construindo um hábito muito importante para a saude financeira',
    'Parabéns, continue gerindo seu patrimônio!!',
    'Parabéns, cumprir suas metas é um passo importante para construir o futuro!!',
    'Continue pagando suas contas em dia',
    'Continue gerindo seu dinheiro com a Web Money'
  ]

  Achievement.create(icon: 'fa-duotone fa-money-bill-transfer', description: achievements[0], code: :money_movement, goal: { level_01: 10, level_02: 50, level_03: 100 })
  Achievement.create(icon: 'fa-solid fa-sack-dollar',           description: achievements[1], code: :money_managed, goal: { level_01: 1000, level_02: 3000, level_03: 5000 })
  Achievement.create(icon: 'fa-solid fa-hand-holding-dollar',   description: achievements[2], code: :budget_reached, goal: { level_01: 1, level_02: 3, level_03: 5 })
  Achievement.create(icon: 'fa-solid fa-calendar-check',        description: achievements[3], code: :bill_in_day, goal: { level_01: 1, level_02: 3, level_03: 5 })
  Achievement.create(icon: 'fa-solid fa-business-time',         description: achievements[4], code: :profile_time, goal: { level_01: 1, level_02: 3, level_03: 5 })

  user_profile.achievements = Achievement.all
  user_profile.save!
