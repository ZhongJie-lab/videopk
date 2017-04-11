# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "create an admin account and a user account"
User.create!(email: "admin@test.com", password: "123456", password_confirmation: "123456", is_admin: true)
User.create!(email: "123@gmail.com", password: "123456", password_confirmation: "123456", is_admin: false)
