# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email:"user@user.com", password:"user123", password_confirmation:"user123")

# Recurrence.all.each do |recurrence|
#   Notification.create!(
#     recurrence: recurrence,
#     user_profile: recurrence.user_profile,
#     title: "#{recurrence.title} - Vence hoje!",
#     description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
#     read: [true, false].sample
#   )
# end

2.times do |product|
  Recurrence.create!(
    user_profile: User.last.user_profile,
    title: "Conta X #{product + 1}",
    price_cents: 10000
  )
end

# Despesas
['Casa', 'Transporte', 'Alimentação', 'Supermercado', 'Internet'].each do |category|
  Category.create(title: category, user: User.last)
end

['Salário', 'Serviço', 'Investimentos'].each do |category|
  Category.create(title: category, user: User.last)
end

Recurrence.all.each do |recurrence|
  20.times do
    Transaction.create!(
      user_profile: User.last.user_profile,
      move_type: %i[recipe expense].sample,
      recurrence: recurrence,
      category: Category.all.sample,
      title: "Transação - #{recurrence.title}",
      price_cents: rand(100..5000),
      date: Faker::Date.in_date_period(year: 2020, month: 1)
    )
  end
end
