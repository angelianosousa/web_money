# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

achievements = [
  'Movimente a plataforma e com isso construa o hábito de acompanhar suas finanças regularmente.',
  'Acumule pontos conforme sua receita aumenta',
  'Cada meta batida significa uma superação.',
  'Continue pagando suas contas em dia',
  'Continue gerindo seu dinheiro com a Web Money'
]

Achievement.create(description: achievements[0], code: :money_movement, level: :silver, points: 100)
Achievement.create(description: achievements[0], code: :money_movement, level: :golden, points: 500)
Achievement.create(description: achievements[0], code: :money_movement, level: :diamond, points: 1000)

Achievement.create(description: achievements[1], code: :money_managed, level: :silver, points: 1000)
Achievement.create(description: achievements[1], code: :money_managed, level: :golden, points: 3000)
Achievement.create(description: achievements[1], code: :money_managed, level: :diamond, points: 5000)

Achievement.create(description: achievements[2], code: :budget_reached, level: :silver, points: 100)
Achievement.create(description: achievements[2], code: :budget_reached, level: :golden, points: 300)
Achievement.create(description: achievements[2], code: :budget_reached, level: :diamond, points: 500)

# Achievement.create(description: achievements[3], code: :bill_in_day, level: 1, points: 1)
# Achievement.create(description: achievements[3], code: :bill_in_day, level: 2, points: 3)
# Achievement.create(description: achievements[3], code: :bill_in_day, level: 3, points: 5)

# Achievement.create(description: achievements[4], code: :profile_time, points: 1)
# Achievement.create(description: achievements[4], code: :profile_time, points: 3)
# Achievement.create(description: achievements[4], code: :profile_time, points: 5)

User.find_or_create_by(email: 'user@user.com', password: 'user123', password_confirmation: 'user123')

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
%w[Água Energia Internet].each do |bill|
  user_profile.bills.find_or_create_by(
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
  user_profile.bills.find_or_create_by(
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

# Meta
['Reserva de Emergência', 'Aposentadoria', 'Carro Novo'].each do |e|
  Budget.find_or_create_by!(
    objective_name: e,
    goals_price_cents: rand(5000..99_999),
    date_limit: Faker::Date.between(from: 12.month.ago.beginning_of_month, to: Date.today.end_of_year),
    user_profile: user_profile
  )
end

## Transações das metas

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

