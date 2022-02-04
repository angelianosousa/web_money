# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(email:"user@user.com", password:"user123", password_confirmation:"user123")

type = ["Receita", "Despesa"]
badge = ["success", "danger"]

2.times do |i|
  Category.find_or_create_by(title: type[i], badge: badge[i])
end