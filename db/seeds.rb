# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# tao 20 user
100.times do |i|
  User.create(
    name: Faker::FunnyName.name, 
    email: Faker::Internet.email,
    password: 'All@123456',
    birthday: "2000-#{rand(1..12)}-#{rand(1..25)}",
    gender: Faker::Gender.binary_type
  )
end
