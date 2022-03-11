# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create(email:"user@user.com", password:"user123", password_confirmation:"user123")

Recurrence.all.each do |recurrence|
  Notification.create!(
    recurrence: recurrence,
    user_profile: recurrence.user_profile,
    title: "#{recurrence.title} - Vence hoje!",
    description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
    read: [true, false].sample
  )
end