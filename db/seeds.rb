# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# tao 20 user
20.times do |i|
  User.create(
    name: "User ##{i}",
    email: "thaiquan#{i}@gmail.com",
    age: i,
    phone: "01243565#{i}"
  )
end 
