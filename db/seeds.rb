# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'Thai Tien Minh Quan',
             email: 'thaiquan25072000@gmail.com',
             password:              '123456',
             password_confirmation: '123456',  
             admin:                  true,
             activated: true,
             activated_at: Time.zone.now                        
)

users = User.where(activated: true).take(6)
30.times do
  users.each do |user|
    user.microposts.create!(content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit')
  end
end

# tao 100 user
100.times do |i|
  User.create(
    name: Faker::FunnyName.name, 
    email: Faker::Internet.email,
    password: 'All@123456',
    password_confirmation: 'All@123456',
    birthday: "2000-#{rand(1..12)}-#{rand(1..25)}",
    gender: Faker::Gender.binary_type,
    activated: true,
    activated_at: Time.zone.now
  )
end
