# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email:"user@user.com", password: "user123", password_confirmation: "user123")

user_profile = User.last.user_profile

# Despesas
['Casa', 'Transporte', 'Alimentação', 'Supermercado', 'Internet', 'Transferência saída'].each do |category|
  user_profile.categories.find_or_create_by!(title: category, user_profile: user_profile, category_type: :expense)
end

# Receitas
['Salário', 'Serviço', 'Investimentos', 'Transferência entrada'].each do |category|
  user_profile.categories.find_or_create_by!(title: category, user_profile: user_profile, category_type: :recipe)
end

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

# Despesas
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

# Receitas
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