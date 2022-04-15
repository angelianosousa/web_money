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
