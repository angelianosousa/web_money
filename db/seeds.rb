# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email:"user@user.com", password:"user123", password_confirmation:"user123")

# Despesas
['Casa', 'Transporte', 'Alimentação', 'Supermercado', 'Internet'].each do |category|
  Category.create(title: category, user: User.last)
end

# Receitas
['Salário', 'Serviço', 'Investimentos'].each do |category|
  Category.create(title: category, user: User.last)
end

Account.all.each do |account|
  20.times do
    Transaction.create!(
      description: Faker::Lorem.question(word_count: rand(2..5)),
      user_profile: User.last.user_profile,
      move_type: %i[recipe expense].sample,
      account: account,
      category: Category.all.sample,
      price_cents: rand(100..5000),
      date: Faker::Date.in_date_period(year: 2021, month: 12)
    )
  end
end
